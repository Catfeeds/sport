package com.sport.dto;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope(value="prototype")//每一个请求产生一个实例
public class Page {
	private int totalPageNumber;
	private int pageNumber;
	private int pageSize;
	private int totalItemNumber;
	private String groupByColumn;
	private String orderByColumn;
	private boolean isAsc;
	public Page(){
		pageSize=8;//默认每页8条记录，页面传参可以改变容量
		pageNumber=1;//默认显示首页记录
	}
	public int getTotalPageNumber() {
		return totalPageNumber;
	}
	public Page setTotalPageNumber(int totalPageNumber) {
		this.totalPageNumber = totalPageNumber;
		return this;
	}
	public int getPageNumber() {
		return pageNumber;
	}
	public Page setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
		return this;
	}
	public int getPageSize() {
		return pageSize;
	}
	public Page setPageSize(int pageSize) {
		this.pageSize = pageSize;
		return this;
	}
	public String getGroupByColumn() {
		return groupByColumn;
	}
	public Page setGroupByColumn(String groupByColumn) {
		this.groupByColumn = groupByColumn;
		return this;
	}
	public String getOrderByColumn() {
		return orderByColumn;
	}
	public Page setOrderByColumn(String orderByColumn) {
		this.orderByColumn = orderByColumn;
		return this;
	}
	public boolean isAsc() {
		return isAsc;
	}
	public Page setAsc(boolean isAsc) {
		this.isAsc = isAsc;
		return this;
	}
	public int getTotalItemNumber() {
		return totalItemNumber;
	}
	public Page setTotalItemNumber(int totalItemNumber) {
		this.totalItemNumber = totalItemNumber;//设置分页总记录数，然后计算并设置总的页码数
		totalPageNumber = totalItemNumber / pageSize + ((totalItemNumber % pageSize) == 0 ? 0 : 1);
		return this;
	}
	
}
