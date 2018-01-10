package com.sport.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

@Entity
public class Refound implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private User user;//申请退款的用户
	private Order order;//申请退款的订单
	private String realName;//用户姓名
	private String phone;//联系电话号码
	private String zifubaoAcount;//支付宝账号
	private String weixinAcount;//微信支付账号
	private boolean hasRefound;//是否已经退款
	private Date applyTime;//申请时间
	private Date refoundedTime;//退款确认时间，管理员操作
	private String reason;//退款原
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Refound setId(int id) {
		this.id = id;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public User getUser() {
		return user;
	}
	public Refound setUser(User user) {
		this.user = user;
		return this;
	}
	@OneToOne(fetch=FetchType.LAZY)
	public Order getOrder() {
		return order;
	}
	public Refound setOrder(Order order) {
		this.order = order;
		return this;
	}
	public String getZifubaoAcount() {
		return zifubaoAcount;
	}
	public Refound setZifubaoAcount(String zifubaoAcount) {
		this.zifubaoAcount = zifubaoAcount;
		return this;
	}
	public String getWeixinAcount() {
		return weixinAcount;
	}
	public Refound setWeixinAcount(String weixinAcount) {
		this.weixinAcount = weixinAcount;
		return this;
	}
	@Lob
	public String getReason() {
		return reason;
	}
	public Refound setReason(String reason) {
		this.reason = reason;
		return this;
	}
	public boolean isHasRefound() {
		return hasRefound;
	}
	public Refound setHasRefound(boolean hasRefound) {
		this.hasRefound = hasRefound;
		return this;
	}
	public Date getApplyTime() {
		return applyTime;
	}
	public Refound setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
		return this;
	}
	public Date getRefoundedTime() {
		return refoundedTime;
	}
	public Refound setRefoundedTime(Date refoundedTime) {
		this.refoundedTime = refoundedTime;
		return this;
	}
	public String getPhone() {
		return phone;
	}
	public Refound setPhone(String phone) {
		this.phone = phone;
		return this;
	}
	public String getRealName() {
		return realName;
	}
	public Refound setRealName(String realName) {
		this.realName = realName;
		return this;
	}
	

}
