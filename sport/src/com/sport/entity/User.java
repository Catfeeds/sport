package com.sport.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Transient;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
@Component
@Scope("prototype")
@Entity
@PrimaryKeyJoinColumn(name="id",referencedColumnName="person_id")
public class User extends Person  implements Serializable{
	/*
	 * Id；		
		Level；会员等级
		Integration；积分	
		experience;论坛经验值	
		registerDate；注册日期
		types;关注的分类
		careProducts;关注的产品
		comments;评论
		*/
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int level;//会员等级
	private int integration;//会员积分
	private long experience;//会员论坛经验值
	private Date registerDate;//会员注册日期
	private List<Product> careProducts;//会员关注的产品
	private List<ProductType> types;//会员关注的分类
	private List<Comment> comments;//会员的评论
	//dto
	private boolean hasSign;//签到标志，登录一次只能签到一次
	public User(){}	
	
	public int getLevel() {
		return level;
	}
	public User setLevel(int level) {
		this.level = level;
		return this;
	}
	public int getIntegration() {
		return integration;
	}
	public User setIntegration(int integration) {
		this.integration = integration;
		return this;
	}
	public Date getRegisterDate() {
		//registerDate=DateFormatUtil.formatDay(registerDate);
		return registerDate;
	}
	public User setRegisterDate(Date registerDate) {
		//registerDate=DateFormatUtil.formatDay(registerDate);
		this.registerDate = registerDate;
		return this;
	}
	
	@OneToMany(mappedBy="user",fetch=FetchType.LAZY)
	public List<Comment> getComments() {
		return comments;
	}
	
	public User setComments(List<Comment> comments) {
		this.comments = comments;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY)
	public List<Product> getCareProducts() {
		return careProducts;
	}



	public User setCareProducts(List<Product> careProducts) {
		this.careProducts = careProducts;
		return this;
	}
	
	@OneToMany(fetch=FetchType.LAZY)
	public List<ProductType> getTypes() {
		return types;
	}

	public User setTypes(List<ProductType> types) {
		this.types = types;
		return this;
	}

	public long getExperience() {
		return experience;
	}

	public User setExperience(long experience) {
		this.experience = experience;
		return this;
	}
	@Transient
	public boolean isHasSign() {
		return hasSign;
	}

	public User setHasSign(boolean hasSign) {
		this.hasSign = hasSign;
		return this;
	}
	
	
}
