package com.sport.dto;


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.entity.Company;
import com.sport.entity.Product;
import com.sport.entity.ProductType;

@Component
@Scope(value="prototype")//每一个请求产生一个实例
@Qualifier(value="condition")
public class SearchCondition {	
	//是否进行选择排序搜索
	private boolean sortSearchFlag;
	private String sortColumnName;
	//标志，是否是选择搜索页面传递过来的
	private boolean chooseSearchFlag;
	//标志，判断简单那搜索还是复杂
	private boolean flag;
	//简单搜索类型选择
	private String searchType;
	//复杂模糊产品搜索字段标志
	private boolean hasProductName;
	private boolean hasTypeName;
	private boolean hasCompanyName;
	private boolean hasPriceRange;
	//复杂范围精确产品搜索
	private int minPrice;//价格范围
	private int maxPrice;
	private String orderBy;//按某列排序
	private Company company;//公司名
	private ProductType rootType;//根分类
	private ProductType parentType;//父分类
	private ProductType type;//产品类型
	private Product product;//产品自身属性，模糊查找
	//简单搜索,可搜索公司、产品
	
	private String simpleInfo;

	public int getMinPrice() {
		return minPrice;
	}
	public SearchCondition setMinPrice(int minPrice) {
		this.minPrice = minPrice;
		return this;
	}
	public int getMaxPrice() {
		return maxPrice;
	}
	public SearchCondition setMaxPrice(int maxPrice) {
		this.maxPrice = maxPrice;
		return this;
	}
	public Company getCompany() {
		return company;
	}
	public SearchCondition setCompany(Company company) {
		this.company = company;
		return this;
	}
	public ProductType getType() {
		return type;
	}
	public SearchCondition setType(ProductType type) {
		this.type = type;
		return this;
	}
	public Product getProduct() {
		return product;
	}
	public SearchCondition setProduct(Product product) {
		this.product = product;
		return this;
	}
	public String getSimpleInfo() {
		return simpleInfo;
	}
	public SearchCondition setSimpleInfo(String simpleInfo) {
		this.simpleInfo = simpleInfo;				
		return this;
	}
	public boolean isFlag() {
		return flag;
	}
	public SearchCondition setFlag(boolean flag) {
		this.flag = flag;
		return this;
	}
	public String getOrderBy() {
		return orderBy;
	}
	public SearchCondition setOrderBy(String orderBy) {
		this.orderBy = orderBy;
		return this;
	}
	public boolean isHasProductName() {
		return hasProductName;
	}
	public SearchCondition setHasProductName(boolean hasProductName) {
		//System.out.println("hasProductName:"+hasProductName);
		this.hasProductName =hasProductName;
		return this;
	}
	public boolean isHasTypeName() {
		return hasTypeName;
	}
	public SearchCondition setHasTypeName(boolean hasTypeName) {
		this.hasTypeName = hasTypeName;
		return this;
	}
	public boolean isHasCompanyName() {
		return hasCompanyName;
	}
	public SearchCondition setHasCompanyName(boolean hasCompanyName) {
		this.hasCompanyName = hasCompanyName;
		return this;
	}
	public boolean isHasPriceRange() {
		return hasPriceRange;
	}
	public SearchCondition setHasPriceRange(boolean hasPriceRange) {
		this.hasPriceRange = hasPriceRange;
		return this;
	}
	public ProductType getRootType() {
		return rootType;
	}
	public SearchCondition setRootType(ProductType rootType) {
		this.rootType = rootType;
		return this;
	}
	public ProductType getParentType() {
		return parentType;
	}
	public SearchCondition setParentType(ProductType parentType) {
		this.parentType = parentType;
		return this;
	}
	public String getSearchType() {
		return searchType;
	}
	public SearchCondition setSearchType(String searchType) {
		this.searchType = searchType;		
		return this;
	}
	public boolean isChooseSearchFlag() {
		return chooseSearchFlag;
	}
	public SearchCondition setChooseSearchFlag(boolean chooseSearchFlag) {
		this.chooseSearchFlag = chooseSearchFlag;
		System.out.println("接收到了标志！");
		return this;
	}
	public boolean isSortSearchFlag() {
		return sortSearchFlag;
	}
	public SearchCondition setSortSearchFlag(boolean sortSearchFlag) {
		this.sortSearchFlag = sortSearchFlag;
		return this;
	}
	public String getSortColumnName() {
		return sortColumnName;
	}
	public SearchCondition setSortColumnName(String sortColumnName) {
		this.sortColumnName = sortColumnName;
		return this;
	}
	
	
}
