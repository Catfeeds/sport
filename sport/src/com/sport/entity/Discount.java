package com.sport.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.sport.util.DateFormatUtil;

@Entity
public class Discount {
	public static final int ACTIVITY_NOT_BEGIN=1;//活动还没开始
	public static final int ACTIVITY_ACTIVE=0;//活动正在进行中
	public static final int ACTIVITY_END=2;//活动已经结束
	
	public static final int TYPE_COACH=1;//教练活动
	public static final int TYPE_SITE=2;//场馆活动
	
	private int id;
	private String title;//优惠信息标题
	private String introduction;//优惠信息简介
	private String detail;//有优惠信息详情
	private Date beginDate;//活动开始时间
	private Date endDate;//活动结束时间
	private Image preViewImg;//预览大图
	private int type;//优惠信息所属的类型
	private Coach coach;//这个活动是哪个教练发布的
	private Site site;//这个活动是哪个场馆发布的
	private int discountStatus;//活动状态,具体请参考上面的状态定义
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Discount setId(int id) {
		this.id = id;
		return this;
	}
	public String getTitle() {
		return title;
	}
	public Discount setTitle(String title) {
		this.title = title;
		return this;
	}
	@Lob
	public String getIntroduction() {
		return introduction;
	}
	public Discount setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
	@Lob
	public String getDetail() {
		return detail;
	}
	public Discount setDetail(String detail) {
		this.detail = detail;
		return this;
	}
	public Date getBeginDate() {
		return beginDate;
	}
	public Discount setBeginDate(Date beginDate) {
		long nowTime=DateFormatUtil.formatDay(new Date()).getTime();
		if(nowTime<DateFormatUtil.formatDay(beginDate).getTime()){
			this.discountStatus=Discount.ACTIVITY_NOT_BEGIN;
		}
		this.beginDate = beginDate;
		return this;
	}
	public Date getEndDate() {
		return endDate;
	}
	public Discount setEndDate(Date endDate) {
		long nowTime=DateFormatUtil.formatDay(new Date()).getTime();
		if(nowTime>DateFormatUtil.formatDay(endDate).getTime()){
			this.discountStatus=Discount.ACTIVITY_END;
		}
		this.endDate = endDate;
		return this;
	}
	@OneToOne(fetch=FetchType.LAZY)
	public Image getPreViewImg() {
		return preViewImg;
	}
	public Discount setPreViewImg(Image preViewImg) {
		this.preViewImg = preViewImg;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Site getSite() {
		return site;
	}
	public Discount setSite(Site site) {
		this.site = site;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Coach getCoach() {
		return coach;
	}
	public Discount setCoach(Coach coach) {
		this.coach = coach;
		return this;
	}
	
	public int getDiscountStatus() {
		return discountStatus;
	}
	public Discount setDiscountStatus(int discountStatus) {
		this.discountStatus = discountStatus;
		return this;
	}
	public int getType() {
		return type;
	}
	public Discount setType(int type) {
		this.type = type;
		return this;
	}
	
}
