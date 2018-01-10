package com.sport.util;

import java.util.Calendar;
import java.util.Date;
/*
 * 根据日期换算出这是星期几
 */
public class DateToWeek {
	public static final String[] WEEKS={"周日","周一","周二","周三","周四","周五","周六"};
	public static String getWeek(Date date){
		Calendar calendar=Calendar.getInstance();
		calendar.setTimeInMillis(date.getTime());
		return WEEKS[calendar.get(Calendar.DAY_OF_WEEK)-1];
	}
}
