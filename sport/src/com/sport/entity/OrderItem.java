package com.sport.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Transient;

import com.sport.util.DateToWeek;
import com.sport.util.NumberFormatUtil;

@Entity
public class OrderItem  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
	 * 
	 	Id；
		Order;所属订单；（多对一）
		product;商品；（多对一）
		productNumber；商品数量；
		discount；优惠金额；
		totalPrice；总价；
		comment；评论；
		*/
	private int id;
	private Order order;//所属订单；（多对一）
	private Product product;//商品；（一对一）
	private Place place;//哪个场地
	private Coach coach;//哪个教练
	private PlacePreOrder placePreOrder;//属于哪个场地预定信息的订单
	private CoachPreOrder coachPreOrder;//或属于哪个教练预定信息的订单
	private int time;//几点钟开始，eg. 8 就代表（8点-9点）,教练则是上午0点、下午1点、晚上2点、全天3点
	private Date useDate;//消费时间
	private float discount;//优惠金额；
	private float price;//价格；
	private Comment comment;//评论；
	//dto
	private String week;//根据date换算星期
	public OrderItem(){}	
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public OrderItem setId(int id) {
		this.id = id;
		return this;
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public Order getOrder() {
		return order;
	}
	public OrderItem setOrder(Order order) {
		this.order = order;
		return this;
	}
	@OneToOne(fetch=FetchType.EAGER)
	public Product getProduct() {
		return product;
	}
	public OrderItem setProduct(Product product) {
		this.product = product;
		return this;
	}

	public float getDiscount() {
		discount=NumberFormatUtil.formatFloat(discount);
		return discount;
	}
	public OrderItem setDiscount(float discount) {
		discount=NumberFormatUtil.formatFloat(discount);
		this.discount = discount;
		return this;
	}

	@OneToOne(fetch=FetchType.LAZY)
	public Comment getComment() {
		return comment;
	}
	public OrderItem setComment(Comment comment) {
		this.comment = comment;
		return this;
	}


	public float getPrice() {
		price=NumberFormatUtil.formatFloat(price);
		return price;
	}


	public OrderItem setPrice(float price) {
		price=NumberFormatUtil.formatFloat(price);
		this.price = price;
		return this;
	}


	public int getTime() {
		return time;
	}


	public OrderItem setTime(int time) {
		this.time = time;
		return this;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	public Place getPlace() {
		return place;
	}


	public OrderItem setPlace(Place place) {
		this.place = place;
		return this;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	public Coach getCoach() {
		return coach;
	}


	public OrderItem setCoach(Coach coach) {
		this.coach = coach;
		return this;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	public PlacePreOrder getPlacePreOrder() {
		return placePreOrder;
	}


	public OrderItem setPlacePreOrder(PlacePreOrder placePreOrder) {
		this.placePreOrder = placePreOrder;
		return this;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	public CoachPreOrder getCoachPreOrder() {
		return coachPreOrder;
	}


	public OrderItem setCoachPreOrder(CoachPreOrder coachPreOrder) {
		this.coachPreOrder = coachPreOrder;
		return this;
	}

	public Date getUseDate() {
		//useDate=DateFormatUtil.formatDay(useDate);
		return useDate;
	}

	public OrderItem setUseDate(Date useDate) {
		//useDate=DateFormatUtil.formatDay(useDate);
		this.useDate = useDate;
		return this;
	}
	@Transient
	public String getWeek() {
		week=DateToWeek.getWeek(this.useDate);
		return week;
	}

	public OrderItem setWeek(String week) {
		this.week = week;
		return this;
	}

	
	
}
