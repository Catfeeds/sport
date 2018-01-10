package com.sport.dto;

import java.util.Date;

import com.sport.entity.Address;
import com.sport.entity.Place;
import com.sport.entity.Product;
import com.sport.entity.ProductType;
/*
 * 用于场地和教练的复杂搜索
 */
public class ComplexSearchCondition {
	public final static String COMPLEX_SEARCH="complex";
	public final static String SIMPLE_SEARCH="simple";
	public final static String PLACE_SEARCH="place";
	public final static String COACH_SEARCH="coach";
	private String searchType;//区分搜索中是场地还是教练搜索
	private boolean simpleFlag;
	private String searchFlag;//判断是简单搜索还是复杂搜索
	private String simpleKeyWord;//关键字
	private Address address;//场馆地址
	private Address cityAddress;//选择的城市地区名
	private Date date;//日期
	private ProductType type;//产品种类
	private Product product;//哪种产品
	
	public Address getAddress() {
		return address;
	}
	public ComplexSearchCondition setAddress(Address address) {
		this.address = address;
		return this;
	}
	public Date getDate() {
		return date;
	}
	public ComplexSearchCondition setDate(Date date) {
		this.date = date;
		return this;
	}
	public ProductType getType() {
		return type;
	}
	public ComplexSearchCondition setType(ProductType type) {
		this.type = type;
		return this;
	}
	public Product getProduct() {
		return product;
	}
	public ComplexSearchCondition setProduct(Product product) {
		this.product = product;
		return this;
	}
	
	public String getSearchFlag() {
		return searchFlag;
	}
	public ComplexSearchCondition setSearchFlag(String searchFlag) {
		this.searchFlag = searchFlag;
		return this;
	}
	
	public String getSimpleKeyWord() {
		return simpleKeyWord;
	}
	public ComplexSearchCondition setSimpleKeyWord(String simpleKeyWord) {
		this.simpleKeyWord = simpleKeyWord;
		return this;
	}
	public boolean isSimpleFlag() {
		return simpleFlag;
	}
	public ComplexSearchCondition setSimpleFlag(boolean simpleFlag) {
		this.simpleFlag = simpleFlag;
		return this;
	}
	public String getSearchType() {
		return searchType;
	}
	public ComplexSearchCondition setSearchType(String searchType) {
		this.searchType = searchType;
		return this;
	}
	public Address getCityAddress() {
		return cityAddress;
	}
	public ComplexSearchCondition setCityAddress(Address cityAddress) {
		this.cityAddress = cityAddress;
		return this;
	}
}
