package com.sport.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
@Entity
@Table(name="manager_right")
public class Right  implements Serializable {	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String rightName;//权限名
	private String detail;//权限说明
	public Right(){}
	
	@Column(unique=true)
	public String getRightName() {
		return rightName;
	}

	public Right setRightName(String rightName) {
		this.rightName = rightName;
		return this;
	}

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	
	public Right setId(int id) {
		this.id = id;
		return this;
	}

	public String getDetail() {
		return detail;
	}
	@Lob
	public Right setDetail(String detail) {
		this.detail = detail;
		return this;
	}
	
	
}
