package com.sport.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;

@Entity
public class Level  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public final static int TYPE_COACH=1;
	public final static int TYPE_PLACE=0;
	private int id;
	private String levelName;//等级名
	private ProductType type;//隶属于哪种分类（足球、羽毛球之类的）
	private int flag;//目前区别是教练服务、或者是场地等级(0代表场地、1代表教练)
	private String introduction;//简介
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Level setId(int id) {
		this.id = id;
		return this;
	}
	public String getLevelName() {
		return levelName;
	}
	public Level setLevelName(String levelName) {
		this.levelName = levelName;
		return this;
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public ProductType getType() {
		return type;
	}
	public Level setType(ProductType type) {
		this.type = type;
		return this;
	}
	@Lob
	public String getIntroduction() {
		return introduction;
	}
	public Level setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
	public int getFlag() {
		return flag;
	}
	public Level setFlag(int flag) {
		this.flag = flag;
		return this;
	}
	
}
