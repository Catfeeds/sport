package com.sport.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;


import com.sport.entity.Coach;
import com.sport.entity.CoachProduct;
import com.sport.entity.Company;
import com.sport.entity.Order;
import com.sport.entity.OrderItem;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.OrderItemService;
import com.sport.service.OrderService;
import com.sport.service.QueryOrderService;
import com.sport.service.UserService;
import com.sport.timer.TimerTaskQueue;

@Component
@Scope("prototype")
public class OrderAction extends RootAction {
	// 定义订单的支付方式
	public static final String PAY_BY_WEIXIN_JSAPI = "weixinJs";// 微信页面jsAPI进行支付
	public static final String PAY_BY_WEIXIN_NATIVE = "weixinNative";// pc页面微信扫码支付
	private Order order;// 操作某订单时需要
	private OrderService orderService;
	private OrderItem item;// 操作某订单项时需要
	private OrderItemService orderItemService;
	private List<Order> orders;// 用户查看自己所有订单，或管理员查看订单时需要
	private List<OrderItem> items;// 当某订单里内容太多，需要分页读取订单项
	private boolean addOrcutdown;// 增加订单项产品数量，还是减少
	// 教练产品
	private CoachProduct coachProduct;
	// 时间日期控制
	public static final String[] WEEKS = { "周日", "周一", "周二", "周三", "周四", "周五",
			"周六" };
	private List<Date> dates;// 今天的日期
	private List<String> weeks;// 存放星期几
	private int week;// 预定的是星期几的
	// 订单支付方式选择
	private String payMethod;
	// 微信原生态支付反馈会页面的url地址
	private String nativePayUrl;
	// 订单的查询
	private QueryOrderService queryOrderService;
	// 同步创建订单
	private int[] times;
	// 微信用户匿名登录
	private UserService userService;
	// 微信用户授权码
	private String code;

	/************
	 * 对订单项的操作
	 * 
	 * @throws PromptException
	 * @throws ServerErrorException
	 ***********/
	/*
	 * 写入一条订单项，需要判断是否是新建订单的第一条订单项, 如果不是则需要先新建一个订单,一个场地或一个教练服务就是一个订单项
	 */
	public void addItem() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		if (coachProduct != null)
			item.setProduct(coachProduct);
		try {
			String orderNumber = (String) session.get("orderNumber");
			User user = this.getCurrentUser();
			if (orderNumber == null) {
				orderNumber = "" + new Date().getTime();
				session.put("orderNumber", orderNumber);
				order = new Order();
				
//				SimpleDateFormat sbr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//sbr.parse(sbr.format(new Date()))	
				
				order.setOrderNumber(orderNumber).setBuyer(user)
						.setCreateTime(new Date());
				System.out.println("createtime is " + order.getCreateTime() + "______________________");
				orderService.add(order);
			} else {
				order = orderService.load(new Order()
						.setOrderNumber(orderNumber));
			}
			item.setOrder(order);
			orderItemService.add(item);
			orderService.update(order);// 更新用于获取总金额
			json.add(true);
			errorMsg = "" + item.getId();
		} catch (PromptException e) {
			errorMsg = e.toString();
			json.add(false);
			session.remove("orderNumber");
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			errorMsg = PromptException.SYSTEM_ERROR;
			session.remove("orderNumber");
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();
	}

	// 直接同步创建一个订单及其订单项并设置为提交状态,利用ids来传递选中的时间段
	public String createAndSubmitOrder() throws PromptException {
		try {
			// 生成订单
			String orderNumber = (String) session.get("orderNumber");
			User user = this.getCurrentUser();
			if (orderNumber == null) {
				orderNumber = "" + new Date().getTime();
				session.put("orderNumber", orderNumber);
				order = new Order();
				
//				SimpleDateFormat sbr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//sbr.parse(sbr.format(new Date()))	
				
				order.setOrderNumber(orderNumber).setBuyer(user)
						.setCreateTime(new Date());
				System.out.println("createtime is " + order.getCreateTime() + "______________________");
				orderService.add(order);
			} else {
				order = orderService.load(new Order()
						.setOrderNumber(orderNumber));
			}
			// 创建各个订单项
			for (int time : times) {
				item = new OrderItem().setTime(time).setCoachPreOrder(
						item.getCoachPreOrder());
				if (coachProduct == null || coachProduct.getId() < 1)
					item.setProduct(new CoachProduct());// 赋值为空
				else
					item.setProduct(coachProduct);
				item.setOrder(order);
				orderItemService.add(item);
				orderService.update(order);// 更新用于获取总金额
			}
			order.setHasSubmit(true).setOrderStatus(Order.SUBMIT_NOT_PAY_ORDER)
					.setSubmitTime(new Date());
			orderService.update(order);
			session.remove("orderNumber");// 删除session中的订单编号,以便下次继续下单,清除当前已提交订单
		} catch (Exception e) {
			errorMsg = "您没有未提交的订单，请核实后再试!";
			e.printStackTrace();
			throw new PromptException(errorMsg);
		}
		if (order.getCoach() != null)
			return "submitedCoachOrder";
		return "submitOrder";
	}

	// 删除一个订单项
	public void deleteItem() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			item = orderItemService.load(item);
			order = item.getOrder();
			if (order.getOrderStatus() >= Order.SUBMIT_NOT_PAY_ORDER) {
				throw new PromptException("提交后的订单，不允许继续更改！");
			}
			order.getItems().remove(item);//先解除关系
			orderItemService.delete(item);
			if (order.getItems().size() < 1) {
				orderService.delete(order);
				session.remove("orderNumber");
			} else {
				orderService.update(order);
			}
			json.add(true);
		} catch (PromptException e) {
			errorMsg = e.toString();
			json.add(false);
			json.add(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(PromptException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}

	/*
	 * 商家管理自己的订单项
	 */
	public String orderItemList() throws PromptException, ServerErrorException {
		try {
			Company company = this.getCurrentCompany();
			items = new ArrayList<OrderItem>();
			if (page.getPageNumber() != 0)
				page.setTotalItemNumber(orderItemService.findAllByCompany(
						items, company, page.getPageNumber(),
						page.getPageSize()));
			else
				page.setTotalItemNumber(orderItemService.findAllByCompany(
						items, company, 1, page.getPageSize()));
			System.out.println(items.size());
		} catch (PromptException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "orderList";
	}

	/************** 对订单的操作 ***************/
	/*****
	 * 订单状态的修改
	 * 
	 * @throws PromptException
	 * @throws ServerErrorException
	 ***********/
	// 管理员查看订单
	public void readOrder() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			order = orderService.load(order);
			order.setHasRead(true).setDeliveredTime(new Date());// 管理员已经查看
			orderService.update(order);
			json.add(true);
		} catch (Exception e) {
			errorMsg = PromptException.SYSTEM_ERROR;
			json.add(false);
			json.add(errorMsg);
		}
		out.println(json);
		this.closeOut();
	}

	// 提交订单
	public String submitOrder() throws PromptException {
		try {

			String orderNumber = (String) session.get("orderNumber");
			if (orderNumber == null)
				throw new PromptException("您没有需要提交的订单!");
			order = orderService.load(new Order().setOrderNumber(orderNumber));
			setOrderDate(order);
			
//			SimpleDateFormat sbr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//	sbr.parse(sbr.format(new Date()))
			
			order.setHasSubmit(true).setOrderStatus(Order.SUBMIT_NOT_PAY_ORDER)
					.setSubmitTime(new Date());
			orderService.update(order);
			session.remove("orderNumber");// 删除session中的订单编号,以便下次继续下单,清除当前已提交订单
		} catch (Exception e) {
			errorMsg = "您没有未提交的订单，请核实后再试!";
			e.printStackTrace();
			throw new PromptException(errorMsg);
		}
		if (order.getCoach() != null)
			return "submitedCoachOrder";
		return "submitOrder";
	}

	// 重新提交订单
	public String resubmitOrder() throws PromptException {
		String result = "submitOrder";
		try {
			order = orderService.load(order);
			setOrderDate(order);
			session.remove("orderNumber");// 删除session中的订单编号,以便下次继续下单,清除当前已提交订单
		} catch (Exception e) {
			errorMsg = RootException.SYSTEM_ERROR;
			e.printStackTrace();
			throw new PromptException(errorMsg);
		}
		if (order.getOrderStatus() == Order.CONFIRM_OK_ORDER
				&& (order.getPhone() != null && (!order.getPhone().trim()
						.equals("")))) {// 认证过了就直接去支付
			if (order.getCoach() != null)
				result = "payCoachOrder";
			else
				result = "payOrder";
		} else {// 否者需要继续认证
			if (order.getCoach() != null)
				result = "submitedCoachOrder";
			else
				result = "submitOrder";
		}
		return result;
	}

	// 短信认证用户，并转到选择支付方式界面
	public String toPayOrder() throws PromptException, ServerErrorException {
		try {
			String phone = order.getPhone();
			order = orderService.load(order);
			if (phone != null) {
				order.setPhone(phone).setOrderStatus(Order.CONFIRM_OK_ORDER);
				orderService.update(order);
			}
			setOrderDate(order);
		} catch (PromptException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		if (order.getCoach() != null)
			return "payCoachOrder";
		// Demo.getCodeurl(new WxPayDto());
		return "payOrder";
	}

	// 微信 jsAPI支付
	public void wxJsPay() throws ServerErrorException {/*
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			order = orderService.load(this.order);
			User user = this.getCurrentUser();
			StringBuffer productContent = new StringBuffer();
			productContent.append("您正在通过" + WeixinServerConfig.APPLICATION_NAME
					+ "公众平台");
			if (order.getCoach() == null) {
				productContent.append("预定场地");
			} else {
				productContent.append("预约教练");
			}
			// 微信支付jsApi
			WxPayDto tpWxPay = new WxPayDto();
			tpWxPay.setOpenId(user.getWeixin());
			tpWxPay.setBody(productContent.toString());
			tpWxPay.setOrderId(order.getOrderNumber());
			tpWxPay.setSpbillCreateIp(ServletActionContext.getRequest()
					.getRemoteHost());
			tpWxPay.setTotalFee(Float.toString(order.getTotalAcount()));
			String result = PayOrderManager.getPackage(tpWxPay);
			json.add(true);
			json.add(result);
			order.setOrderStatus(Order.PAYING_ORDER);// 设置订单正在支付中
			order.setPayingBeginTime(new Date());// 设置开始支付的时间，进行一个计时
			order.setJsPayParams(result);// 保存js支付参数，包括预支付id
			orderService.update(order);
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add("支付失败!");
		}
		out.println(json);
		this.closeOut();
	*/}

	// 微信原生态扫描二维码进行支付，code_url有效期为2小时，过期后扫码不能再发起支付。
	/*public String weixinScanPay() throws ServerErrorException, PromptException {
		try {
			order = orderService.load(this.order);
			StringBuffer productContent = new StringBuffer();
			productContent
					.append("您正在通过" + WeixinServerConfig.APPLICATION_NAME);
			if (order.getCoach() == null) {
				productContent.append("预定运动场地");
			} else {
				productContent.append("预约教练");
			}
			productContent.append("!");
			// 微信支付jsApi
			WxPayDto tpWxPay = new WxPayDto();
			tpWxPay.setBody(productContent.toString());
			tpWxPay.setOrderId(order.getOrderNumber());
			tpWxPay.setSpbillCreateIp(ServletActionContext.getRequest()
					.getRemoteHost());
			// tpWxPay.setTotalFee(""+0.01);
			tpWxPay.setTotalFee(String.valueOf(order.getTotalAcount()));
			if (order.getNativePayUrl() != null) {
				long usedTime = new Date().getTime()
						- order.getPayingBeginTime().getTime();
				long outTime = 2 * TimerTaskQueue.UPDATE_PREORDER_SCHEDULE;// 2个小时
				if (usedTime >= outTime) {
					nativePayUrl = PayOrderManager.getCodeurl(tpWxPay);
				} else {
					nativePayUrl = order.getNativePayUrl();
				}
			} else {
				nativePayUrl = PayOrderManager.getCodeurl(tpWxPay);
			}
			order.setOrderStatus(Order.PAYING_ORDER);// 设置订单正在支付中
			order.setPayingBeginTime(new Date());// 设置开始支付的时间，进行一个计时
			order.setNativePayUrl(nativePayUrl);// 保存扫码支付链接
			orderService.update(order);
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "weixinScanPay";
	}
*/
	// 订单支付成功后的处理
	public String payedOrder() throws PromptException {
		try {
			order = orderService.load(order);
			setOrderDate(order);
			/********** 测试支付代码开始 *********/
			/*
			 * if (order.getSubmitTime() == null) {
			 * order.setHasSubmit(true).setSubmitTime(new Date())
			 * .setOrderStatus(Order.SUBMIT_NOT_PAY_ORDER); }
			 * order.setHasPay(true).setOrderStatus(Order.PAYED_NOT_USE_ORDER)
			 * .setPayTime(new Date()); orderService.update(order);
			 */
			/********** 测试支付代码结束 *********/
			session.remove("orderNumber");// 删除session中的订单编号,以便下次继续下单,清除当前已提交订单
		} catch (Exception e) {
			errorMsg = "订单支付操作失败!";
			e.printStackTrace();
			throw new PromptException(errorMsg);
		}
		if (order.getCoach() != null)
			return "payedCoachOrder";
		return "payedOrder";
	}

	// 订单支付失败后的处理
	public String payFailed() throws PromptException {
		try {
			order = orderService.load(order);
			setOrderDate(order);
			order.setOrderStatus(Order.PAY_FAILED);
			orderService.update(order);
			session.remove("orderNumber");// 删除session中的订单编号,以便下次继续下单,清除当前已提交订单
		} catch (Exception e) {
			errorMsg = "订单支付操作失败!";
			e.printStackTrace();
			throw new PromptException(errorMsg);
		}
		if (order.getCoach() != null)
			return "payCoachFailed";
		return "payFailed";
	}

	// 前台页面查询订单支付的情况
	public void queryOrderStatus() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			json.add(queryOrderService.queryWeixinOrder(order));
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}

	// 订单使用
	public void useOrder() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			order = orderService.load(order);
			if (new Date().getTime() < order.getPreOrderTime().getTime())// 到了预定时间后才能确认消费
				throw new PromptException("还未到消费时间，请使用后再确认！");
			if (order.getOrderStatus() == Order.USEED_ORDER)
				throw new PromptException("您已经确认消费过该订单了");
			if (order.getOrderStatus() != Order.PAYED_NOT_USE_ORDER)
				throw new PromptException("您还未支付订单，无法确认消费！");

			order.setHasUse(true).setOrderStatus(Order.USEED_ORDER)
					.setUseTime(new Date());
			orderService.update(order);
			json.add(true);
		} catch (PromptException e) {
			errorMsg = e.toString();
			json.add(false);
		} catch (Exception e) {
			errorMsg = "订单使用操作失败!";
			e.printStackTrace();
			json.add(false);
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();

	}

	// 订单作废,当用户退款后
	public void unusedOrder() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			order = orderService.load(order);
			order.setHasUseless(true).setOrderStatus(Order.USELESS_ORDER);
			orderService.update(order);
			json.add(true);
		} catch (PromptException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			errorMsg = "订单作废操作失败!";
			json.add(false);
			json.add(errorMsg);
		}
		out.println(json);
		this.closeOut();
	}

	/**
	 * 用户申请退款
	 * 
	 * @throws ServerErrorException
	 * */
	public void aplyRefound() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			order = orderService.load(order);
			setOrderDate(order);
			long preOrderTime = order.getPreOrderTime().getTime();
			long nowTime = new Date().getTime();
			long limitTime = TimerTaskQueue.UPDATE_PREORDER_SCHEDULE * 2;// 两个小时之前可以申请退款
			if ((preOrderTime - nowTime) < limitTime) {// 如果小于2小时，则无法退款
				throw new PromptException("距离订单使用时间不足2小时，无法申请退款！");
			}
			if (order.getOrderStatus() != Order.PAYED_NOT_USE_ORDER) {// 如果不是刚付款，而未使用的订单也不能退款
				throw new PromptException("该订单不符合退款要求！");
			}

			session.remove("orderNumber");// 删除session中的订单编号,以便下次继续下单,清除当前已提交订单
			json.add(true);
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			errorMsg = "退款申请失败!";
			e.printStackTrace();
			json.add(false);
			json.add(errorMsg);
		}
		out.println(json);
		this.closeOut();
	}

	/**
	 * 转到退款页面
	 * 
	 * @throws ServerErrorException
	 * @throws PromptException
	 */
	public String refound() throws ServerErrorException, PromptException {
		try {
			order = orderService.load(order);
		} catch (RootException e) {
			throw new PromptException(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "refound";
	}

	public void deleteCurrentOrder() throws ServerErrorException {
		String orderNumber = (String) session.get("orderNumber");
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			if (orderNumber == null)
				throw new PromptException("你还没有进行任何预定操作！");
			order = orderService.load(new Order().setOrderNumber(orderNumber));
			orderService.delete(order);
			session.remove("orderNumber");// 删除session中的订单编号,以便下次继续下单,清除当前已提交订单
			json.add(true);
		} catch (PromptException e) {
			errorMsg = e.toString();
			json.add(false);
		} catch (Exception e) {
			e.printStackTrace();
			errorMsg = "删除订单失败!";
			json.add(false);
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();
	}

	// 删除订单
	public void deleteOrder() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			orderService.delete(order);
			session.remove("orderNumber");// 删除session中的订单编号,以便下次继续下单,清除当前已提交订单
			json.add(true);
		} catch (PromptException e) {
			errorMsg = e.toString();
			json.add(false);
		} catch (Exception e) {
			e.printStackTrace();
			errorMsg = "删除订单失败!";
			json.add(false);
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();
	}

	public void loginWeixinUser() throws PromptException, Exception {/*// 微信自动注册并登录
		try {
			if (null != session.get("currentUser"))
				return;
			User u = new User();
			// u.setUserName("weixinUser").setRealName("微信匿名登录用户");
			UserDetailInfo detailInfo = UserAuthManager.getUserDetail(code);
			u.setUserName("wxu" + new Date().getTime())
					.setRealName(detailInfo.getNickname())
					.setWeixin(detailInfo.getOpenId())
					.setNationality(detailInfo.getCuntry())
					.setSex(detailInfo.getSex());

			if (null == userService.findUser(u)) {
				userService.register(u);
			}
			u = userService.findUser(u);
			session.put("currentUser", u);
		} catch (PromptException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	*/}

	// 用户查看自己的订单,注意需要按时间排序分页显示
	public String userOrderList() throws PromptException, ServerErrorException {
		try {
			String path = ServletActionContext.getRequest().getServletPath();
			System.out.println("path:" + path);
			if (path.contains("weixin"))// 如果是从微信端进来的需要自动登录注册
				loginWeixinUser();
			User u = this.getCurrentUser();
			orders = new ArrayList<Order>();
			page.setTotalItemNumber(orderService.findAllUserOrders(orders, u,
					page.getPageNumber(), page.getPageSize()));
			System.out.println(orders.size());
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "userOrderList";
	}

	// 用户查看订单详情
	public String orderDetail() throws PromptException, ServerErrorException {
		try {
			order = orderService.load(order);
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "orderDetail";
	}

	/*
	 * 管理员分页查看订单 这里我们需要传入查询的条件，例如：是新订单还是历史订单、考虑排序方式等
	 * 查询条件需要引入一个传输对象,目前就用Order代替就行了
	 */
	public String orderList() throws ServerErrorException, PromptException {
		try {
			System.out.println("进入到方法");
			orders = new ArrayList<Order>();
			Company company =null;
			Coach coach = null;
			try {
				 company = this.getCurrentCompany();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				 coach = this.getCurrentCoach();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(company==null&&(coach==null))
				throw new PromptException("你的登录信息已过期，请重新登录！");
			if (order == null) {
				order = new Order();
			}
			if (company != null && (!company.isHost()))
				order.setCompany(company);
			if (coach != null)
				order.setCoach(coach);
			page.setTotalItemNumber(orderService.findAll(orders, order,
					page.getPageNumber(), page.getPageSize()));
			System.out.println(orders.size());
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "orderList";
	}

	/*
	 * 查看所有新付款后的订单
	 */
	public String newOrderList() throws ServerErrorException {
		orders = new ArrayList<Order>();
		try {
			page.setTotalItemNumber(orderService.findAll(orders,
					new Order().setOrderStatus(Order.PAYED_NOT_USE_ORDER),
					page.getPageNumber(), page.getPageSize()));

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "orderList";
	}

	/*
	 * 查看所有废弃后的订单
	 */
	public String uselessOrderList() throws ServerErrorException {
		orders = new ArrayList<Order>();
		try {
			page.setTotalItemNumber(orderService.findAll(orders,
					new Order().setOrderStatus(Order.USELESS_ORDER),
					page.getPageNumber(), page.getPageSize()));

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "orderList";
	}

	/********************* 商家管理自己公司的订单 *****************/
	/*
	 * 商家查看本公司所有订单
	 */
	public String orderListCompany() throws ServerErrorException {

		System.out.println("进入到方法");
		orders = new ArrayList<Order>();
		try {
			Company company = this.getCurrentCompany();
			page.setTotalItemNumber(orderService.findAll(orders,
					new Order().setCompany(company), page.getPageNumber(),
					page.getPageSize()));

			System.out.println(orders.size());
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "orderList";
	}

	/*
	 * 商家查看本公司所有新付款后的订单
	 */
	public String newOrderListCompany() throws ServerErrorException {
		orders = new ArrayList<Order>();
		try {
			Company company = this.getCurrentCompany();
			page.setTotalItemNumber(orderService.findAll(orders,
					new Order().setOrderStatus(Order.PAYED_NOT_USE_ORDER)
							.setCompany(company), page.getPageNumber(), page
							.getPageSize()));

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "newOrderList";
	}

	/*
	 * 商家查看本公司所有废弃后的订单
	 */
	public String uselessOrderListCompany() throws ServerErrorException {
		orders = new ArrayList<Order>();
		try {
			Company company = this.getCurrentCompany();
			page.setTotalItemNumber(orderService.findAll(orders, new Order()
					.setOrderStatus(Order.USELESS_ORDER).setCompany(company),
					page.getPageNumber(), page.getPageSize()));

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "uselessOrderList";
	}

	/********************* 商家管理自己公司的订单结束 *****************/
	// 批量删除订单
	public void deleteSelectedOrders() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		System.out.println(this.getIds());
		try {
			if (orderService.deleteSelectedOrders(this.getIds())) {
				json.add(true);
				json.add("删除选中订单成功！");
			} else {
				json.add(false);
				json.add("删除选中订单失败!");
			}
		} catch (Exception e) {
			json.add(false);
			json.add(PromptException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();

	}

	// 删除所有废单
	public void deleteUnusedOrders() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		User u = (User) session.get("currentManager");
		if (u == null) {
			errorMsg = "您还未登录，无法进行信息的修改！";
			out.println(errorMsg);
		}
		try {
			if (!orderService.load(order).isHasUse()) {
				orderService.delete(order);
				json.add(true);
				json.add("删除成功！");
			} else {
				json.add(false);
				json.add("删除失败!");
			}
		} catch (Exception e) {
			json.add(false);
			json.add(PromptException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}

	public int getDayOfWeek(Date date) {
		Calendar calendar = Calendar.getInstance();
		long time = date.getTime();
		calendar.setTimeInMillis(time);
		return calendar.get(Calendar.DAY_OF_WEEK) - 1;// 从0开始-6
	}

	// 设置该订单使用的那一天是星期几,通过weeks[week]获取
	public void setOrderDate(Order order) {
		Date date = null;
		if (order.getItems().get(0).getCoachPreOrder() == null) {
			date = order.getItems().get(0).getPlacePreOrder().getDate();
		} else {
			date = order.getItems().get(0).getCoachPreOrder().getDate();
		}
		week = getDayOfWeek(date);
	}

	/************ 注入代码 **********/
	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;

	}

	public OrderService getOrderService() {
		return orderService;
	}

	@Resource
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;

	}

	public OrderItem getItem() {
		return item;
	}

	public void setItem(OrderItem item) {
		this.item = item;

	}

	public OrderItemService getOrderItemService() {
		return orderItemService;
	}

	@Resource
	public void setOrderItemService(OrderItemService orderItemService) {
		this.orderItemService = orderItemService;

	}

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;

	}

	public List<OrderItem> getItems() {
		return items;
	}

	public void setItems(List<OrderItem> items) {
		this.items = items;

	}

	public boolean isAddOrcutdown() {
		return addOrcutdown;
	}

	public void setAddOrcutdown(boolean addOrcutdown) {
		this.addOrcutdown = addOrcutdown;
	}

	public List<Date> getDates() {
		dates = new ArrayList<Date>();
		weeks = new ArrayList<String>();
		Date date = new Date(new java.util.Date().getTime());
		long time = date.getTime();
		for (int i = 0; i < 7; i++) {
			time += i * TimerTaskQueue.SCHEDULE;
			Date temp = new Date(time);
			dates.add(temp);
			Calendar calendar = Calendar.getInstance();
			calendar.setTimeInMillis(time);
			weeks.add(WEEKS[calendar.get(Calendar.DAY_OF_WEEK) - 1]);
			time = date.getTime();
		}
		return dates;
	}

	public void setDates(List<Date> dates) {
		this.dates = dates;

	}

	public List<String> getWeeks() {
		getDates();
		return weeks;
	}

	public void setWeeks(List<String> weeks) {
		this.weeks = weeks;
	}

	public int getWeek() {
		return week;
	}

	public void setWeek(int week) {
		this.week = week;
	}

	public CoachProduct getCoachProduct() {
		return coachProduct;
	}

	public void setCoachProduct(CoachProduct coachProduct) {
		this.coachProduct = coachProduct;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public String getNativePayUrl() {
		return nativePayUrl;
	}

	public void setNativePayUrl(String nativePayUrl) {
		this.nativePayUrl = nativePayUrl;
	}

	public QueryOrderService getQueryOrderService() {
		return queryOrderService;
	}

	@Resource
	public void setQueryOrderService(QueryOrderService queryOrderService) {
		this.queryOrderService = queryOrderService;
	}

	public int[] getTimes() {
		return times;
	}

	public void setTimes(int[] times) {
		this.times = times;
	}

	public UserService getUserService() {
		return userService;
	}

	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}
