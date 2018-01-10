package com.sport.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Transient;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
/*
 * 每个公司都有自己的一套产品，以产品名区分所有的产品，当然id也可以，产品分类则是所有公司共有的
 */
@Entity
@PrimaryKeyJoinColumn(name="id",referencedColumnName="product_id")
public class PlaceProduct extends Product implements Serializable{
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Site site;//哪些场馆有这种相同类型的运动场地
	private List<Place> places;//该种场地有哪些实体场地存在	
	private List<PlacePreOrder> preOrders;//场地的所有预定信息
	
	@OneToMany(fetch=FetchType.LAZY,mappedBy="product")
	public List<Place> getPlaces() {
		return places;
	}
	public PlaceProduct setPlaces(List<Place> places) {
		this.places = places;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Site getSite() {
		return site;
	}
	public PlaceProduct setSite(Site site) {
		this.site = site;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.REMOVE)
	public List<PlacePreOrder> getPreOrders() {
		return preOrders;
	}
	public PlaceProduct setPreOrders(List<PlacePreOrder> preOrders) {
		this.preOrders = preOrders;
		return this;
	}
	
}
