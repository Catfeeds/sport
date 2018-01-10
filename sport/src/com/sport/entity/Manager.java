package com.sport.entity;


import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
@Entity//代表一个实体
@Component//这里同时也用作数据传输对象
@Scope("prototype")//每次请求产生一个实例
@PrimaryKeyJoinColumn(name="id",referencedColumnName="person_id")
public class Manager extends Person  implements Serializable{
	/*
	 * 
		Id;	
		company;管理员所属的公司
	 */
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Company company;//属于哪个公司的管理员
	private String levelPosition;//职位
	private boolean hasSuper;//是否是加盟商超级管理员
	public Manager(){}
	
	public Manager(String levelPosition, Right right) {
		super();
		
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public Company getCompany() {
		return company;
	}

	public Manager setCompany(Company company) {
		this.company = company;
		return this;
	}

	public String getLevelPosition() {
		return levelPosition;
	}

	public Manager setLevelPosition(String levelPosition) {
		this.levelPosition = levelPosition;
		return this;
	}

	public boolean isHasSuper() {
		return hasSuper;
	}

	public void setHasSuper(boolean hasSuper) {
		this.hasSuper = hasSuper;
	}
			
}
