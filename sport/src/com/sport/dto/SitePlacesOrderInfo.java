package com.sport.dto;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import com.sport.entity.Place;
import com.sport.entity.PlaceProduct;
import com.sport.entity.Site;
import com.sport.exception.RootException;
import com.sport.service.PlacePreOrderService;
import com.sport.service.PlaceService;

public class SitePlacesOrderInfo {
	private Date date;//这是哪天的该场馆的预订信息
	private Site site;//哪个场馆
	private PlaceProduct product;//哪种产品类型的场地,***记得注入产品分类信息
	private List<PreOrderInfo> placesDayInfo;//某天某场馆的所有场地的预订信息
	private PlaceService placeService;
	private PlacePreOrderService placePreOrderService;
	public void init(Date date,Site site,PlaceProduct product){
		this.date=date;
		this.site=site;
		this.product=product;
		List<Place> places=new ArrayList<Place>();
		try {
			int totalNumber=placeService.findAll(places, product.getType(), site, 1, 50);
			if(totalNumber>50){
				System.out.println("该场馆中此类场地数目不能超过50个，如需添加更多，需要升级系统！");
				return ;
			}
			placesDayInfo=new ArrayList<PreOrderInfo>();
			for(Place place:places){
				PreOrderInfo info=new PreOrderInfo();
				info.setPlacePreOrderService(placePreOrderService)
					.setPlaceService(placeService)
					.init(date, place);
				placesDayInfo.add(info);
			}
		} catch (RootException e) {
			e.printStackTrace();
		}
	}
	/*********注入代码********/
	public Date getDate() {
		return date;
	}
	public SitePlacesOrderInfo setDate(Date date) {
		this.date = date;
		return this;
	}
	public Site getSite() {
		return site;
	}
	public SitePlacesOrderInfo setSite(Site site) {
		this.site = site;
		return this;
	}
	public PlaceProduct getProduct() {
		return product;
	}
	public SitePlacesOrderInfo setProduct(PlaceProduct product) {
		this.product = product;
		return this;
	}
	public List<PreOrderInfo> getPlacesDayInfo() {
		return placesDayInfo;
	}
	public SitePlacesOrderInfo setPlacesDayInfo(List<PreOrderInfo> placesDayInfo) {
		this.placesDayInfo = placesDayInfo;
		return this;
	}
	public PlaceService getPlaceService() {
		return placeService;
	}
	public SitePlacesOrderInfo setPlaceService(PlaceService placeService) {
		this.placeService = placeService;
		return this;
	}
	public PlacePreOrderService getPlacePreOrderService() {
		return placePreOrderService;
	}
	public SitePlacesOrderInfo setPlacePreOrderService(PlacePreOrderService placePreOrderService) {
		this.placePreOrderService = placePreOrderService;
		return this;
	}
	
}
