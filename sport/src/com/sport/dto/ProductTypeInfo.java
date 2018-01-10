package com.sport.dto;

import java.util.ArrayList;
import java.util.List;

import com.sport.entity.ProductType;

public class ProductTypeInfo {
	private int id;
	private String typeName;
	private String introduction;
	public ProductTypeInfo(){}
	public ProductTypeInfo(ProductType type){
		this.id=type.getId();
		this.typeName=type.getTypeName();
		this.introduction=type.getIntroduction();
	}
	public static List<ProductTypeInfo> fromTypes(List<ProductType> types){
		List<ProductTypeInfo> infos=new ArrayList<ProductTypeInfo>();
		for(ProductType type:types)
		{
			infos.add(new ProductTypeInfo(type));
		}
		return infos;
	}
	public int getId() {
		return id;
	}
	public ProductTypeInfo setId(int id) {
		this.id = id;
		return this;
	}
	public String getTypeName() {
		return typeName;
	}
	public ProductTypeInfo setTypeName(String typeName) {
		this.typeName = typeName;
		return this;
	}
	public String getIntroduction() {
		return introduction;
	}
	public ProductTypeInfo setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
}
