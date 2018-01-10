package com.sport.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;

@Entity
public class Role  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;//角色名
	private List<Right> rights;//该角色具有的所有权限
	private String detail;//详情
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Role setId(int id) {
		this.id = id;
		return this;
	}
	@Column(unique=true)
	public String getName() {
		return name;
	}
	public Role setName(String name) {
		this.name = name;
		return this;
	}
	@OneToMany(fetch=FetchType.EAGER)
	public List<Right> getRights() {
		return rights;
	}
	public Role setRights(List<Right> rights) {
		this.rights = rights;
		return this;
	}
	@Lob
	public String getDetail() {
		return detail;
	}
	public Role setDetail(String detail) {
		this.detail = detail;
		return this;
	}
	
}
