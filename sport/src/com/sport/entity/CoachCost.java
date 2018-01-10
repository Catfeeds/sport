package com.sport.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Transient;

//教练安排自己的工作时间与收费情况
@Entity
public class CoachCost implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int employNumber;// 该项目一次可以辅导的人数
	private Coach coach;// 该收费标准属于哪个教练定制的
	private CoachProduct product;// 是哪种教练服务
	private String introduction;// 简要介绍，可以填写一些优惠信息或该项目附加项目说明等
	private String timePrice;// 时间价格表，每天24小时，价格排列如下：20,30,20,20,......
	// dto变量
	private float[] prices;// 价格数组，为了前台取数据方便而设置

	public CoachCost() {
		prices = new float[24];
	}

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public CoachCost setId(int id) {
		this.id = id;
		return this;
	}

	public int getEmployNumber() {
		return employNumber;
	}

	public CoachCost setEmployNumber(int employNumber) {
		this.employNumber = employNumber;
		return this;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	public Coach getCoach() {
		return coach;
	}

	public CoachCost setCoach(Coach coach) {
		this.coach = coach;
		return this;
	}

	@OneToOne(fetch = FetchType.LAZY)
	public CoachProduct getProduct() {
		return product;
	}

	public CoachCost setProduct(CoachProduct product) {
		this.product = product;
		return this;
	}

	@Lob
	public String getIntroduction() {
		return introduction;
	}

	public CoachCost setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}

	public String getTimePrice() {
		return timePrice;
	}

	public CoachCost setTimePrice(String timePrice) {
		this.timePrice = timePrice;
		return this;
	}

	@Transient
	public float[] getPrices() {
		if (timePrice != null) {
			String[] pricesStr = timePrice.split(",");
			int i = 0;

			for (String str : pricesStr) {
				try {
					prices[i++] = Float.parseFloat(str);
				} catch (Exception e) {
					String info = "数据非法，无法转化为浮点型！";
					System.out.println(info);
					continue;
				}
			}
		}
		return prices;
	}

	public CoachCost setPrices(float[] prices) {
		this.prices = prices;
		StringBuffer buffer = new StringBuffer();
		for (float i : prices) {
			buffer.append(i + ",");
		}
		timePrice = buffer.substring(0, buffer.length() - 1);
		return this;
	}

	public CoachCost setUnionPrices(float price) {
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < 24; i++) {
			this.prices[i] = price;
			buffer.append(price + ",");
		}
		timePrice = buffer.substring(0, buffer.length() - 1);
		return this;
	}
}
