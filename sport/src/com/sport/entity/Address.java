package com.sport.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
@Entity
public class Address  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String addressName;//地点名字
	private String introduction;//地区简介
	private Address parentAddress;//隶属于哪个地点
	private List<Address> childrenAddress;//管辖哪些地点
	private boolean leaf;//是否是最小范围的区地点
	private int grade;//第几级地点
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Address setId(int id) {
		this.id = id;
		return this;
	}
	public String getAddressName() {
		return addressName;
	}
	public Address setAddressName(String addressName) {
		this.addressName = addressName;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Address getParentAddress() {
		return parentAddress;
	}
	public Address setParentAddress(Address parentAddress) {
		this.parentAddress = parentAddress;
		return this;
	}
	@OneToMany(cascade=CascadeType.ALL,fetch=FetchType.EAGER,mappedBy="parentAddress")
	public List<Address> getChildrenAddress() {
		return childrenAddress;
	}
	public Address setChildrenAddress(List<Address> childrenAddress) {
		this.childrenAddress = childrenAddress;
		return this;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public Address setLeaf(boolean leaf) {
		this.leaf = leaf;
		return this;
	}
	public int getGrade() {
		return grade;
	}
	public Address setGrade(int grade) {
		this.grade = grade;
		return this;
	}
	public String getIntroduction() {
		return introduction;
	}
	public Address setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
}
