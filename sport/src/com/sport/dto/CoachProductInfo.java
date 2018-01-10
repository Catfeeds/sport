package com.sport.dto;

import java.util.ArrayList;
import java.util.List;

import com.sport.entity.CoachProduct;

public class CoachProductInfo {
	private int id;
	private String productName;
	public static List<CoachProductInfo> formCoachProducts(List<CoachProduct> products){
		List<CoachProductInfo> infos=new ArrayList<CoachProductInfo>();
		for(CoachProduct p:products){
			infos.add(new CoachProductInfo().setId(p.getId())
						.setProductName(p.getProductName())
					);
		}
		return infos;
	}
	public int getId() {
		return id;
	}
	public CoachProductInfo setId(int id) {
		this.id = id;
		return this;
	}
	public String getProductName() {
		return productName;
	}
	public CoachProductInfo setProductName(String productName) {
		this.productName = productName;
		return this;
	}
}
