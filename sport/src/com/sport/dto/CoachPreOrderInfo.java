package com.sport.dto;

import java.util.Date;

import javax.annotation.Resource;

import com.sport.entity.Coach;
import com.sport.entity.CoachCost;
import com.sport.entity.CoachPreOrder;
import com.sport.entity.CoachProduct;
import com.sport.exception.RootException;
import com.sport.service.CoachCostService;
import com.sport.service.CoachPreOrderService;
import com.sport.service.CoachProductService;
import com.sport.service.CoachService;

public class CoachPreOrderInfo {
	private Date date;//通过时间获取某天的预定信息
	private Coach coach;//通过场地获取该场地的预定信息
	private CoachProduct product;//教练服务项目产品
	private CoachCost costInfo;//教练的收费标准
	private CoachPreOrder order;//获取某天某场地的预定信息
	private CoachService coachService;
	private CoachProductService coachProductService;
	private CoachPreOrderService coachPreOrderService;
	private CoachCostService coachCostService;
	public CoachPreOrderInfo init(Date date,Coach coach,CoachProduct product){//传入参数获取某预定信息
		this.date=date;
		try {
			this.coach=coachService.findCoach(coach);
			this.order=coachPreOrderService.load(new CoachPreOrder().setDate(date)
						.setCoach(coach));
			System.out.println("coachPreOrderDate:"+order.getDate());
			if(product!=null){
				this.product=coachProductService.load(product);
				this.costInfo=coachCostService.load(new CoachCost().setCoach(coach).setProduct(product));
			}
		} catch (RootException e) {
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
		return this;
	}
	public Date getDate() {
		return date;
	}
	public CoachPreOrderInfo setDate(Date date) {
		this.date = date;
		return this;
	}
	public Coach getCoach() {
		return coach;
	}
	public CoachPreOrderInfo setCoach(Coach coach) {
		this.coach = coach;
		return this;
	}
	public CoachPreOrder getOrder() {
		return order;
	}
	public CoachPreOrderInfo setOrder(CoachPreOrder order) {
		this.order = order;
		return this;
	}
	public CoachProduct getProduct() {
		return product;
	}
	public CoachPreOrderInfo setProduct(CoachProduct product) {
		this.product = product;
		return this;
	}
	public CoachService getCoachService() {
		return coachService;
	}

	public CoachPreOrderInfo setCoachService(CoachService coachService) {
		this.coachService = coachService;
		return this;
	}
	public CoachPreOrderService getCoachPreOrderService() {
		return coachPreOrderService;
	}

	public CoachPreOrderInfo setCoachPreOrderService(CoachPreOrderService coachPreOrderService) {
		this.coachPreOrderService = coachPreOrderService;
		return this;
	}
	public CoachProductService getCoachProductService() {
		return coachProductService;
	}
	public CoachPreOrderInfo setCoachProductService(CoachProductService coachProductService) {
		this.coachProductService = coachProductService;
		return this;
	}
	public CoachCost getCostInfo() {
		return costInfo;
	}
	public CoachPreOrderInfo setCostInfo(CoachCost costInfo) {
		this.costInfo = costInfo;
		return this;
	}
	public CoachCostService getCoachCostService() {
		return coachCostService;
	}
	public CoachPreOrderInfo setCoachCostService(CoachCostService coachCostService) {
		this.coachCostService = coachCostService;
		return this;
	}
	
}
