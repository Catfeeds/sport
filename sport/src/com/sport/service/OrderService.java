package com.sport.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.OrderDao;
import com.sport.dto.Page;
import com.sport.entity.Acount;
import com.sport.entity.CoachPreOrder;
import com.sport.entity.Order;
import com.sport.entity.OrderItem;
import com.sport.entity.Place;
import com.sport.entity.PlacePreOrder;
import com.sport.entity.PlaceProduct;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;

@Component
public class OrderService extends RootService {
	private static final String ENTITY_NAME = "Order";
	private OrderDao orderDao;
	private PlacePreOrderService placePreOrderService;
	private CoachPreOrderService coachPreOrderService;

	public OrderDao getOrderDao() {
		return orderDao;
	}

	@Resource
	public OrderService setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
		return this;
	}

	public PlacePreOrderService getPlacePreOrderService() {
		return placePreOrderService;
	}

	@Resource
	public void setPlacePreOrderService(
			PlacePreOrderService placePreOrderService) {
		this.placePreOrderService = placePreOrderService;
	}

	public CoachPreOrderService getCoachPreOrderService() {
		return coachPreOrderService;
	}

	@Resource
	public void setCoachPreOrderService(
			CoachPreOrderService coachPreOrderService) {
		this.coachPreOrderService = coachPreOrderService;
	}

	public void add(Order order) throws RootException {
		if (order == null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);
		order.setHasDelivered(false).setHasPay(false).setHasRead(false)
				.setHasSubmit(false).setHasUse(false).setOrderStatus(1)
				.setHasUseless(false);
		orderDao.save(order);
	}

	public void delete(Order order) throws RootException {

		if (order == null || (order.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);
		order = load(order);
		if(order.getOrderStatus()==Order.USELESS_ORDER||
				(order.getOrderStatus()==Order.PAY_FAILED)
				||(order.getOrderStatus()==Order.REFOUNDED_ORDER)||(order.getOrderStatus()<=Order.SUBMIT_NOT_PAY_ORDER)){
			
		}else{
			throw new PromptException("您只能删除未付款、废单、支付失败、已退款的订单！");
		}
		// 删除订单时需要更新预定信息
		for (OrderItem item : order.getItems()) {
			if (item.getCoach() == null) {
				PlacePreOrder preOrder = item.getPlacePreOrder();
				int[] orderInfos = preOrder.getOrderInfos();
				orderInfos[item.getTime()]++;
				preOrder.setOrderInfos(orderInfos);
				placePreOrderService.update(preOrder);
			} else {
				CoachPreOrder preOrder = item.getCoachPreOrder();
				int[] orderInfos = preOrder.getOrderInfos();
				if(item.getTime()==3){
					orderInfos[0]++;
					orderInfos[1]++;
					orderInfos[2]++;
				}else
					orderInfos[item.getTime()]++;
				preOrder.setOrderInfos(orderInfos);
				coachPreOrderService.update(preOrder);
			}
		}
		orderDao.delete(order);
	}
	
	/**释放订单的资源
	 * @throws RootException */
	public void releaseOrder(Order order) throws RootException {
		if (order == null || (order.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);
		order = load(order);
		// 删除订单时需要更新预定信息
		for (OrderItem item : order.getItems()) {
			if (item.getCoach() == null) {
				PlacePreOrder preOrder = item.getPlacePreOrder();
				int[] orderInfos = preOrder.getOrderInfos();
				orderInfos[item.getTime()]++;
				preOrder.setOrderInfos(orderInfos);
				placePreOrderService.update(preOrder);
			} else {
				CoachPreOrder preOrder = item.getCoachPreOrder();
				int[] orderInfos = preOrder.getOrderInfos();
				if(item.getTime()==3){
					orderInfos[0]++;
					orderInfos[1]++;
					orderInfos[2]++;
				}else
					orderInfos[item.getTime()]++;
				preOrder.setOrderInfos(orderInfos);
				coachPreOrderService.update(preOrder);
			}
		}
	}
	//判断是否有用户新生成的订单超过30分钟还未支付的,状态置为废单，并释放资源
	public void checkTimeOutNewOrders() throws RootException{
		List<Order> orders=new ArrayList<Order>();
		Page page=new Page().setPageSize(50);
		page.setTotalItemNumber(orderDao.findAllTimeOutOrders(orders, 1, page.getPageSize(),null,null,true));
		for(int i=1;i<=page.getTotalPageNumber();i++){
			List<Order> os=new ArrayList<Order>();
			orderDao.findAllTimeOutOrders(os, i, page.getPageSize(),null,null,true);
			for(Order order:os){
				long oldTime=order.getCreateTime().getTime();
				long newTime=new Date().getTime();
				if((newTime-oldTime)>Order.ORDER_TIMEOUT_LIMIT){//如果已经超时了，就释放资源
					releaseOrder(order);
					order.setOrderStatus(Order.USELESS_ORDER);//置为废单
					orderDao.update(order);
				}
			}
		}
	}
	public void delete(int id) throws RootException {
		if (id <= 0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);
		orderDao.delete(id);
	}

	public void update(Order order) throws RootException {
		if (order == null || (order.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		orderDao.update(order);
	}

	public Order load(Order order) throws RootException {
		if (order == null
				|| ((order.getId() <= 0) && (order.getOrderNumber() == null || order
						.getOrderNumber().trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return orderDao.load(order);
	}

	public Order load(int id) throws RootException {
		if (id <= 0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return orderDao.load(id);
	}
	// 按某列排序查看会员信息
	public int findAll(List<Order> orders,Order order, int pageNumber, int pageSize) {
		return findAll(orders,order, pageNumber, pageSize,"createTime", false);
	}


	public int findAll(List<Order> orders,Order order, int pageNumber, int pageSize,
			String orderByColumn, boolean isAsc) {
		return orderDao.findAll(orders,order, pageNumber, pageSize, null,
				"createTime", false);
	}
	///////////////
	//用户查看自己的所有订单
	public int findAllUserOrders(List<Order> orders,User user, int pageNumber, int pageSize) {
		return findAllUserOrders(orders,user, pageNumber, pageSize,"createTime", false);
	}
	
	public int findAllUserOrders(List<Order> orders,User user, int pageNumber, int pageSize,
			String orderByColumn, boolean isAsc) {
		return orderDao.findAllByUser(orders,user, pageNumber, pageSize, null,
				"createTime", false);
	}
	//////////////
	public boolean deleteSelectedOrders(String ids) throws PromptException {
		int id = 0;
		for (String idStr : ids.split(",")) {
			try {
				if ((id = Integer.parseInt(idStr)) <= 0)
					continue;
				Order p = (Order) new Order().setId(id);
				delete(p);
			} catch (Exception e) {
				e.printStackTrace();
				throw new PromptException("删除id为：" + id
						+ "的订单失败！请检查是否存在该订单，若存在，请重试！");
			}
		}
		return true;
	}

	public int findAll(List<Order> orders, Acount acount, int pageNumber,
			int pageSize) {
		return orderDao.findAll(orders,acount, pageNumber, pageSize);
	}

	
}
