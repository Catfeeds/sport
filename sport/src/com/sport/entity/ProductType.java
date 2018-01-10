package com.sport.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
@Component
@Scope("prototype")
@Entity
public class ProductType  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
	 * Id；
	typeName；种类名；
	introduction；类别简介；
	parentProductType；（父分类）；多对一，双向关联
	List<ProductType> childrenProductTypes；（子分类）；一对多
	List<Product>products;（一对多，双向关联）
	Grade（级别、整型（0代表酒水总分类，1代表类型、2代表品种））；
	isLeaf；是否是叶子节点；
	
	 */
	public static final String DELETE_FAIL_INFO="请先删除使用到分类的等级、教练、场地产品、教练产品等信息再行删除!";
	private int id;
	private String typeName;//种类名
	private String introduction;//类别简介
	private ProductType parentProductType;//父产品分类
	private List<ProductType> childrenProductTypes;//子产品分类集
	private List<Product> products;//有哪些产品属于这个分类
	private Image image;//该分类的图标
	private int grade;//度
	private boolean leaf;//是否是叶子节点	
	
	public ProductType(){}

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public ProductType setId(int id) {
		this.id = id;
		return this;
	}
	@Column(unique=true)
	public String getTypeName() {
		return typeName;
	}
	public ProductType setTypeName(String typeName) {
		this.typeName = typeName;
		return this;
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public ProductType getParentProductType() {
		return parentProductType;
	}
	public ProductType setParentProductType(ProductType parentProductType) {
		this.parentProductType = parentProductType;
		return this;
	}
	@OneToMany(mappedBy="parentProductType",fetch=FetchType.LAZY,cascade=CascadeType.ALL)
	public List<ProductType> getChildrenProductTypes() {
		return childrenProductTypes;
	}
	public ProductType setChildrenProductTypes(List<ProductType> childrenProductTypes) {
		this.childrenProductTypes = childrenProductTypes;
		return this;
	}
	
	public int getGrade() {
		return grade;
	}
	public ProductType setGrade(int grade) {
		this.grade = grade;
		return this;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public ProductType setLeaf(boolean isLeaf) {
		this.leaf = isLeaf;
		return this;
	}
	@Lob
	public String getIntroduction() {
		return introduction;
	}
	public ProductType setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
	@OneToMany(mappedBy="type",cascade=CascadeType.ALL,fetch=FetchType.LAZY)
	public List<Product> getProducts() {
		return products;
	}

	public ProductType setProducts(List<Product> products) {
		this.products = products;
		return this;
	}
	@OneToOne(fetch=FetchType.LAZY)
	public Image getImage() {
		return image;
	}

	public ProductType setImage(Image image) {
		this.image = image;
		return this;
	}
}
