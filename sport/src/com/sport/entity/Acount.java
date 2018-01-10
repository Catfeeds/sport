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

import com.sport.util.DateFormatUtil;
import com.sport.util.NumberFormatUtil;

@Entity
public class Acount implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*********账单的状态定义*********/
	public static final int NOT_PAY=1;//未结算
	public static final int PAYED=2;//已结算
	public static final int NO_FEE_NEED_PAY=3;//没有需要结算的金额
	
	public static final int TYPE_COACH=1;
	public static final int TYPE_SITE=2;
	public static final int TYPE_COMPANY=3;
	private int id;
	private Acount latestAcount;//教练、场馆或公司的最近的一次结算账单
	private Date lastOrderDate;//账单上次结算时订单截止时间，可以将其看成是一个链表结构
	private Date payedDate;//结算日期
	private Date beginDate;//订单起始日期
	private Date endDate;//订单结束日期
	private float payedTotalFee;//已经结算过的金额
	private float totalFee;//可结算总金额
	private int status;//账单状态
	private Company company;//这个账单属于哪个公司的
	private Coach coach;//这个账单属于哪个教练的
	private Site site;//这个账单属于哪个场馆的
	private int acountType;//场馆、教练、还是公司
	//dto变量
	/*****用于账单筛选******/
	private int clearFlag;//清空条件标志
	private Date acountBeginDate;
	private Date acountEndDate;//在这个时间段的账单	
	private String searchKey;//简单搜索，可以用于搜索指定教练和场馆的账单信息
	private Address address;//市级地址
	//用于excel
	private String name;//教练名、公司名、或者场馆名
	private String statusString;//账单状态:未结算、无需结算、已结算
	private String typeName;//类型名
	/**********/
	public Acount(){
		status=1;//默认为未结算
	}
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Acount setId(int id) {
		this.id = id;
		return this;
	}
	
	public Date getLastOrderDate() {
		lastOrderDate=DateFormatUtil.formatDay(lastOrderDate);
		return lastOrderDate;
	}
	public Acount setLastOrderDate(Date lastOrderDate) {
		lastOrderDate=DateFormatUtil.formatDay(lastOrderDate);
		this.lastOrderDate = lastOrderDate;
		return this;
	}
	public Date getPayedDate() {
		//payedDate=DateFormatUtil.formatDay(payedDate);
		return payedDate;
	}
	public Acount setPayedDate(Date payedDate) {
		//payedDate=DateFormatUtil.formatDay(payedDate);
		this.payedDate = payedDate;
		return this;
	}
	public Date getBeginDate() {
		//beginDate=DateFormatUtil.formatDay(beginDate);
		return beginDate;
	}
	public Acount setBeginDate(Date beginDate) {
		beginDate=DateFormatUtil.formatDay(beginDate);
		this.beginDate = beginDate;
		return this;
	}
	public Date getEndDate() {
		//endDate=DateFormatUtil.formatDay(endDate);
		return endDate;
	}
	public Acount setEndDate(Date endDate) {
		endDate=DateFormatUtil.formatDay(endDate);
		this.endDate = endDate;
		return this;
	}
	public float getPayedTotalFee() {
		payedTotalFee=NumberFormatUtil.formatFloat(payedTotalFee);
		return payedTotalFee;
	}
	public Acount setPayedTotalFee(float payedTotalFee) {
		payedTotalFee=NumberFormatUtil.formatFloat(payedTotalFee);
		this.payedTotalFee = payedTotalFee;
		return this;
	}
	public float getTotalFee() {
		totalFee=NumberFormatUtil.formatFloat(totalFee);
		return totalFee;
	}
	public Acount setTotalFee(float totalFee) {
		totalFee=NumberFormatUtil.formatFloat(totalFee);
		this.totalFee = totalFee;
		return this;
	}
	public int getStatus() {
		return status;
	}
	public Acount setStatus(int status) {
		this.status = status;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Company getCompany() {
		return company;
	}
	public Acount setCompany(Company company) {
		this.company = company;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Coach getCoach() {
		return coach;
	}
	public Acount setCoach(Coach coach) {
		this.coach = coach;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Site getSite() {
		return site;
	}
	public Acount setSite(Site site) {
		this.site = site;
		return this;
	}
	public int getAcountType() {
		return acountType;
	}
	public Acount setAcountType(int acountType) {
		this.acountType = acountType;
		return this;
	}
	@OneToOne(fetch=FetchType.LAZY)
	public Acount getLatestAcount() {
		return latestAcount;
	}
	public Acount setLatestAcount(Acount latestAcount) {
		this.latestAcount = latestAcount;
		return this;
	}
	@Transient
	public Date getAcountBeginDate() {		
		//acountBeginDate=DateFormatUtil.formatDay(acountBeginDate);
		return acountBeginDate;
	}
	public Acount setAcountBeginDate(Date acountBeginDate) {
		acountBeginDate=DateFormatUtil.formatDay(acountBeginDate);
		this.acountBeginDate = acountBeginDate;
		return this;
	}
	@Transient
	public Date getAcountEndDate() {
		//acountEndDate=DateFormatUtil.formatDay(acountEndDate);
		return acountEndDate;
	}
	public Acount setAcountEndDate(Date acountEndDate) {
		acountEndDate=DateFormatUtil.formatDay(acountEndDate);
		this.acountEndDate = acountEndDate;
		return this;
	}
	
	@Transient
	public String getSearchKey() {
		return searchKey;
	}
	public Acount setSearchKey(String searchKey) {
		this.searchKey = searchKey;
		return this;
	}
	@Transient
	public Address getAddress() {
		return address;
	}
	public Acount setAddress(Address address) {
		this.address = address;
		return this;
	}
	@Transient
	public int getClearFlag() {
		return clearFlag;
	}
	public Acount setClearFlag(int clearFlag) {
		this.clearFlag = clearFlag;
		return this;
	}
	@Transient
	public String getName() {
		if(company!=null){
			if(company.getCompanyName()!=null)
				name=company.getCompanyName();
		}
		if(site!=null){
			if(site.getSiteName()!=null)
				name=site.getSiteName();
		}
		if(coach!=null){
			if(coach.getRealName()!=null)
				name=coach.getRealName();
		}
		return name;
	}
	public Acount setName(String name) {
		this.name = name;
		return this;
	}
	@Transient
	public String getStatusString() {
		if(status==1)
			statusString="未结算";
		else if(status==2)
			statusString="已结算";
		else
			statusString="无需结算";
		return statusString;
	}
	public Acount setStatusString(String statusString) {
		this.statusString = statusString;
		return this;
	}
	@Transient
	public String getTypeName() {
		if(acountType==1)
			typeName="教练";
		else if(acountType==2)
			typeName="场馆";
		else
			typeName="公司";
		return typeName;
	}
	public Acount setTypeName(String typeName) {
		this.typeName = typeName;
		return this;
	}
	
	
	
}
