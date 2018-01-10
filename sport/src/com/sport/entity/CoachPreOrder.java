package com.sport.entity;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

import com.sport.util.DateToWeek;
//教练某天的预定情况
@Entity
public class CoachPreOrder  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final int TIME_AM_BEGIN_WORK=9;
	public static final int TIME_AM_END_WORK=12;
	public static final int TIME_PM_BEGIN_WORK=14;
	public static final int TIME_PM_END_WORK=17;
	public static final int TIME_NIGHT_BEGIN_WORK=19;
	public static final int TIME_NIGHT_END_WORK=21;
	private int id;
	private Coach coach;//哪个教练的预定情况
	private Date date;//这是哪天的预定信息
	private String orderInfo;//该天的预定情况,即：该小时是否已经被预定了
	private List<OrderItem> items;//该教练改天被预定的订单情况
	//dto变量
	private String week;//根据date换算星期
	private int orderInfos[];//改天每个小时的预定情况数组，eg. 1,1,1,0,1,......
	public CoachPreOrder(){
		orderInfos=new int[]{1,1,1,1,1,
				1,1,1,1,1,
				1,1,1,1,1,
				1,1,1,1,1,
				1,1,1,1
				};
	}
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public CoachPreOrder setId(int id) {
		this.id = id;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Coach getCoach() {
		return coach;
	}
	public CoachPreOrder setCoach(Coach coach) {
		this.coach = coach;
		return this;
	}
	@Lob
	public String getOrderInfo() {
		return orderInfo;
	}
	public CoachPreOrder setOrderInfo(String orderInfo) {
		this.orderInfo = orderInfo;
		return this;
	}
	@Transient
	public int[] getOrderInfos() {
		String []infos=orderInfo.split(",");
		int i=0;
		for(String str:infos){
			try{
				orderInfos[i++]=Integer.parseInt(str);
			}catch(Exception e){
				System.out.println("数据格式错误，转换为int型失败！");
				continue;
			}
		}
		return orderInfos;
	}
	public CoachPreOrder setOrderInfos(int[] orderInfos) {
		this.orderInfos = orderInfos;
		StringBuffer buffer=new StringBuffer();
		for(int info:orderInfos){
			buffer.append(info+",");
		}
		orderInfo=buffer.substring(0, buffer.length()-1);
		return this;
	}
	public CoachPreOrder setUnionOrderInfos(int number) {
		
		StringBuffer buffer=new StringBuffer();
		for(int i=0;i<24;i++){
			buffer.append(number+",");
		}
		orderInfo=buffer.substring(0, buffer.length()-1);
		return this;
	}
	public Date getDate() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // your template here
		String dateStr = formatter.format(date);
		try {
			date=formatter.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	public CoachPreOrder setDate(Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // your template here
		String dateStr = formatter.format(date);
		try {
			date=formatter.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		this.date = date;
		return this;
	}
	@OneToMany(mappedBy="coachPreOrder",fetch=FetchType.LAZY)
	public List<OrderItem> getItems() {
		return items;
	}
	public CoachPreOrder setItems(List<OrderItem> items) {
		this.items = items;
		return this;
	}
	@Transient
	public String getWeek() {
		week=DateToWeek.getWeek(this.date);
		return week;
	}
	public CoachPreOrder setWeek(String week) {
		this.week = week;
		return this;
	}
	
}
