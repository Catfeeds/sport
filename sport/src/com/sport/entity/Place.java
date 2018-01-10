package com.sport.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

//场地信息
@Entity
public class Place  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String placeNumber;//场地编号
	private String placeName;//场地名字
	private String discountInfo;//优惠信息
	private String timePrice;//各个时间段的价格,10，20，30，......
	private String introduction;//简介
	private Site site;//该场地是哪个场馆的
	private PlaceProduct product;//该场地属于那种类型的场地产品
	private List<OrderItem> orderItems;//场地已经被预定的订单项详情
	//dto变量
	private float[] prices;//价格数组，可根据管理员调整，以小时为最小单位
	public Place(){
		prices=new float[24];
	}
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Place setId(int id) {
		this.id = id;
		return this;
	}
	public String getPlaceNumber() {
		return placeNumber;
	}
	public Place setPlaceNumber(String placeNumber) {
		this.placeNumber = placeNumber;
		return this;
	}
	public String getPlaceName() {
		return placeName;
	}
	public Place setPlaceName(String placeName) {
		this.placeName = placeName;
		return this;
	}
	public String getDiscountInfo() {
		return discountInfo;
	}
	public Place setDiscountInfo(String discountInfo) {
		this.discountInfo = discountInfo;
		return this;
	}
	@Lob
	public String getTimePrice() {
		return timePrice;
	}
	public Place setTimePrice(String timePrice) {
		this.timePrice = timePrice;
		return this;
	}
	@Lob
	public String getIntroduction() {
		return introduction;
	}
	public Place setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
	@Transient
	public float[] getPrices() {
		String []pricesStr=timePrice.split(",");
		int i=0;
		for(String str:pricesStr){
			try{
				prices[i++]=Float.parseFloat(str);
			}catch(Exception e){
				String info="数据非法，无法转化为浮点型！";
				System.out.println(info);
				continue;
			}
		}
		return prices;
	}
	public Place setPrices(float[] prices) {
		this.prices = prices;
		StringBuffer buffer=new StringBuffer();
		for(float i:prices){
			buffer.append(i+",");
		}
		timePrice=buffer.substring(0, buffer.length()-1);
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Site getSite() {
		return site;
	}
	public Place setSite(Site site) {
		this.site = site;
		return this;
	}
	
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL,mappedBy="place")
	public List<OrderItem> getOrderItems() {
		return orderItems;
	}
	public Place setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public PlaceProduct getProduct() {
		return product;
	}
	public Place setProduct(PlaceProduct product) {
		this.product = product;
		return this;
	}
	
}
