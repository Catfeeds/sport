package com.sport.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormatUtil {
	public static SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd H:m:s");
	//格式化为时间加日期型日期
	public static Date formatDayTime(Date date){
		if(date==null)
			return null;
		formatter =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//24小时制
		String dateStr = formatter.format(date);
		try {
			date=formatter.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	//格式化为时间加日期型日期
		public static String formatDayTimeStr(Date date){
			if(date==null)
				return null;
			formatter =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//24小时制
			String dateStr = formatter.format(date);			
			return dateStr;
		}
	//格式化为日期型日期
	public static Date formatDay(Date date){
		if(date==null)
			return null;
		formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr = formatter.format(date);
		try {
			date=formatter.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	public static String formatDayStr(Date date){
		if(date==null)
			return null;
		formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr = formatter.format(date);
		return dateStr;
	}
}
