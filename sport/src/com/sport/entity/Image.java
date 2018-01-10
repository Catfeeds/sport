package com.sport.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Image  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String name;//图片名字
	private String type;//图片类型
	private String parentDir;//图片父路径
	private String pathName;//服务器公网相对路径地址
	private String companyIdStr;//公司内部数据分块
	private int picNumber;//该产品图片的编号
	private String diskName;//服务器物理地址
	private String fileExt;//文件拓展名
	public Image(){}
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Image setId(int id) {
		this.id = id;
		return this;
	}	
	
	public String getType() {
		return type;
	}
	public Image setType(String type) {
		this.type = type;
		return this;
	}
	public String getParentDir() {
		return parentDir;
	}
	public Image setParentDir(String parentDir) {
		this.parentDir = parentDir;
		return this;
	}
	@Column(nullable=false)
	public String getName() {
		return name;
	}
	public Image setName(String name) {
		this.name = name;
		return this;
	}
	@Column(unique=true)
	public String getPathName() {
		return pathName;
	}

	public Image setPathName(String pathName) {
		this.pathName = pathName;
		return this;
	}

	

	public int getPicNumber() {
		return picNumber;
	}

	public Image setPicNumber(int picNumber) {
		this.picNumber = picNumber;
		return this;
	}

	public String getDiskName() {
		return diskName;
	}

	public Image setDiskName(String diskName) {
		this.diskName = diskName;
		return this;
	}

	public String getCompanyIdStr() {
		return companyIdStr;
	}

	public Image setCompanyIdStr(String companyIdStr) {
		this.companyIdStr = companyIdStr;
		return this;
	}

	public String getFileExt() {
		return fileExt;
	}

	public Image setFileExt(String fileExt) {
		this.fileExt = fileExt;
		return this;
	}

	
}
