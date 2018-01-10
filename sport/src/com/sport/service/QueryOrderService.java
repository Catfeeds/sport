package com.sport.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dto.Page;
import com.sport.entity.Order;
import com.sport.exception.RootException;
/*import danyuan.weixin.dto.order.OrderInfo;
import danyuan.weixin.dto.order.OrderQueryParam;
import danyuan.weixin.service.OrderManager;*/

@Component
public class QueryOrderService {
	private OrderService orderService;
	//查询某个订单的微信支付情况,查询服务器内部的某个订单是否支付成功
	public boolean queryWeixinOrder(Order order) throws RootException{
		boolean re=false;
		try {
			order=orderService.load(order);
			if(order.getOrderStatus()==Order.PAYED_NOT_USE_ORDER)
				re=true;
		} catch (RootException e) {			
			throw e;
		}catch(Exception e){
			e.printStackTrace();
		}
		return re;
	}
	//订单与微信订单状态批量同步
	public void batchQueryWeixinOrder() throws RootException{/*
		//1、查询出正在支付状态中的订单
		//2、循环获取微信端订单的信息,并同步更新到数据库
		List<Order> orders=new ArrayList<Order>();
		Order order=new Order().setOrderStatus(Order.PAYING_ORDER);//查询所有正在支付的订单状态
		Page page=new Page().setPageSize(50);
		page.setTotalItemNumber(orderService.findAll(orders,order, 1, page.getPageSize()));//获得场地信息的总页数
		for(int i=1;i<=page.getTotalPageNumber();i++){//每次取出最多50条正在支付的订单，直到全部处理完
			List<Order> os=new ArrayList<Order>();
			orderService.findAll(os, order, i, page.getPageSize());
			for(Order tempOrder:os){
				OrderInfo info=OrderManager.queryOrder(new OrderQueryParam().setOutTradeNo(tempOrder.getOrderNumber()));
				//根据反馈的信息来对该订单做相应的处理
				modifyOrder(info,tempOrder);				
			}
		}		
		
	*/}
	//根据微信反馈回来的订单信息对该订单做相应处理
	/*public void modifyOrder(OrderInfo info,Order order) throws RootException{
		if(OrderInfo.ORDER_STATE_SUCCESS.equals(info.getTradeState())){
			//支付成功
			order.setHasPay(true)
				.setOrderStatus(Order.PAYED_NOT_USE_ORDER)
				.setPayTime(new Date());
			//持久化到数据库
			orderService.update(order);
			System.out.println("订单"+order.getOrderNumber()+"支付成功！");
		}else if(OrderInfo.ORDER_STATE_NOTPAY.equals(info.getTradeState())){
			//还未支付
			System.out.println("订单"+order.getOrderNumber()+"还未支付！");
		}else if(OrderInfo.ORDER_STATE_CLOSED.equals(info.getOutTradeNo())){
			//订单已经关闭,只能重新发起支付,更改订单号
			order.setOrderNumber(""+new Date().getTime());
			orderService.update(order);
			System.out.println("订单"+order.getOrderNumber()+"已经关闭，已经重新分配了订单号!");
		}else if(OrderInfo.ORDER_STATE_PAYERROR.equals(info.getOutTradeNo())){
			//订单支付时出错，请重试
			System.out.println("订单"+order.getOrderNumber()+"已经关闭，已经重新分配了订单号!");
		}else if(OrderInfo.ORDER_STATE_REFUND.equals(info.getOutTradeNo())){
			//订单已经转入退款
			order.setOrderStatus(Order.REFOUNDING_ORDER);
			orderService.update(order);
			System.out.println("订单"+order.getOrderNumber()+"订单支付时出错，请重试!");
		}else if(OrderInfo.ORDER_STATE_USERPAYING.equals(info.getOutTradeNo())){
			//用户正在支付中
			System.out.println("订单"+order.getOrderNumber()+"用户正在支付中,请稍等!");
		}else if(OrderInfo.ORDER_STATE_REVOKED.equals(info.getOutTradeNo())){
			//刷卡支付，已撤销
			System.out.println("订单"+order.getOrderNumber()+"利用刷卡支付，已撤销!");
		}else{
			//否则全当做出错处理
			System.out.println("订单"+order.getOrderNumber()+"出现了未知的错误!");
		}
	}*/
	/***********自动注入代码************/
	public OrderService getOrderService() {
		return orderService;
	}
	@Resource
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}
	
	
}
