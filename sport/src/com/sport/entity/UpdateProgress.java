package com.sport.entity;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class UpdateProgress  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public final static int DEFAUL_UPDATE_DAYS=7;
	private int id;
	private Date date;//当前最近更新预定信息的时间
	private int updateDayNumber;//可以提前预定的天数
	private int updateNumber;//已经更新的次数
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public UpdateProgress setId(int id) {
		this.id = id;
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
	public UpdateProgress setDate(Date date) {
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
	public int getUpdateNumber() {
		return updateNumber;
	}
	public UpdateProgress setUpdateNumber(int updateNumber) {
		this.updateNumber = updateNumber;
		return this;
	}
	public int getUpdateDayNumber() {
		return updateDayNumber;
	}
	public UpdateProgress setUpdateDayNumber(int updateDayNumber) {
		this.updateDayNumber = updateDayNumber;
		return this;
	}
	
}
