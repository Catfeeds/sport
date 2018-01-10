package com.sport.entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.PrimaryKeyJoinColumn;
/*
 * 教练
 */
@Entity
@PrimaryKeyJoinColumn(name="id",referencedColumnName="product_id")
public class CoachProduct extends Product implements Serializable{
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
 *
 * coachs;这个服务项目有哪些教练服务
	sites;教练隶属于哪些场馆(多个)
	List<Company>companys;//教练隶属于哪些公司
	comments;对该教练该运动项目服务的评论
*/
	private int employNumber;//该项目一次可以辅导的人数
	private List<Site> sites;//该服务产品有哪些场馆可以提供
	private List<Company> companys;//该服务产品有哪些公司提供
	
	public int getEmployNumber() {
		return employNumber;
	}
	public CoachProduct setEmployNumber(int employNumber) {
		this.employNumber = employNumber;
		return this;
	}
	
	@ManyToMany(fetch=FetchType.LAZY)
	public List<Site> getSites() {
		return sites;
	}
	public CoachProduct setSites(List<Site> sites) {
		this.sites = sites;
		return this;
	}
	@ManyToMany(fetch=FetchType.LAZY)
	public List<Company> getCompanys() {
		return companys;
	}
	public CoachProduct setCompanys(List<Company> companys) {
		this.companys = companys;
		return this;
	}
	
}
