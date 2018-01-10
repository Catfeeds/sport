package com.sport.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Transient;

import com.sport.entity.Acount;
import com.sport.entity.Order;

public class AcountItem {
	public static final String PAYED="已结算";
	public static final String NOT_PAY="未结算";
	private int id;//订单id
	private String orderNumber;//订单编号
	private float totalAcount;//该订单总金额
	private Date payTime;//订单支付时间
	private String ownerName;//教练名、场馆名或者公司名
	private String orderStatus;//订单状态
	private String typeName;//类型名
	public static List<AcountItem> fromOrders(List<Order> orders,Acount acount){
		List<AcountItem> items=new ArrayList<AcountItem>();
		for(Order order:orders){
			AcountItem item=new AcountItem().setId(order.getId())
								.setOrderNumber(order.getOrderNumber())
								.setTotalAcount(order.getTotalAcount())
								.setPayTime(order.getPayTime());
			if(order.getCoach()!=null){
				item.setOwnerName(order.getCoach().getRealName());
			}else if(order.getSite()!=null){
				item.setOwnerName(order.getSite().getSiteName());
			}else{
				item.setOwnerName(order.getCompany().getCompanyName());
			}
			if(acount!=null){
				if(acount.getEndDate().getTime()>order.getPayTime().getTime())
					item.setOrderStatus(AcountItem.PAYED);
				else
					item.setOrderStatus(AcountItem.NOT_PAY);
			}else{
				item.setOrderStatus(AcountItem.NOT_PAY);
			}
			if(acount.getAcountType()==1)
				item.setTypeName("教练");
			else if(acount.getAcountType()==2)
				item.setTypeName("场馆");
			else
				item.setTypeName("公司");
			items.add(item);
		}
		return items;
	}
	public int getId() {
		return id;
	}
	public AcountItem setId(int id) {
		this.id = id;
		return this;
	}
	/****自动注入代码***/
	public AcountItem(){
		orderStatus="已支付";
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public AcountItem setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
		return this;
	}
	public float getTotalAcount() {
		return totalAcount;
	}
	public AcountItem setTotalAcount(float totalAcount) {
		this.totalAcount = totalAcount;
		return this;
	}
	public Date getPayTime() {
		return payTime;
	}
	public AcountItem setPayTime(Date payTime) {
		this.payTime = payTime;
		return this;
	}
	
	public String getOwnerName() {
		return ownerName;
	}
	public AcountItem setOwnerName(String ownerName) {
		this.ownerName = ownerName;
		return this;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public AcountItem setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
		return this;
	}
	@Transient
	public String getTypeName() {
		
		return typeName;
	}
	public AcountItem setTypeName(String typeName) {
		this.typeName = typeName;
		return this;
	}

}
