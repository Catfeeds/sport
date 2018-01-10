package com.sport.dto;

import java.util.Date;

import com.sport.entity.Place;
import com.sport.entity.PlacePreOrder;
import com.sport.exception.RootException;
import com.sport.service.PlacePreOrderService;
import com.sport.service.PlaceService;

public class PreOrderInfo {
	private Date date;//通过时间获取某天的预定信息
	private Place place;//通过场地获取该场地的预定信息
	private PlacePreOrder order;//获取某天某场地的预定信息
	private PlaceService placeService;
	private PlacePreOrderService placePreOrderService;
	public void init(Date date,Place place){//传入参数获取某预定信息
		this.date=date;
		try {
			this.place=placeService.load(place);
			this.order=placePreOrderService.load(new PlacePreOrder().setDate(date)
						.setPlace(place));
		} catch (RootException e) {
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**********注入代码段***********/
	public Date getDate() {
		return date;
	}
	public PreOrderInfo setDate(Date date) {
		this.date = date;
		return this;
	}
	public Place getPlace() {
		return place;
	}
	public PreOrderInfo setPlace(Place place) {
		this.place = place;
		return this;
	}
	public PlacePreOrder getOrder() {
		return order;
	}
	public PreOrderInfo setOrder(PlacePreOrder order) {
		this.order = order;
		return this;
	}
	public PlaceService getPlaceService() {
		return placeService;
	}

	public PreOrderInfo setPlaceService(PlaceService placeService) {
		this.placeService = placeService;
		return this;
	}
	public PlacePreOrderService getPlacePreOrderService() {
		return placePreOrderService;
	}

	public PreOrderInfo setPlacePreOrderService(PlacePreOrderService placePreOrderService) {
		this.placePreOrderService = placePreOrderService;
		return this;
	}
	
}
