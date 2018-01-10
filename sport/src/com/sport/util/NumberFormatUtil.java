package com.sport.util;

import java.text.DecimalFormat;

public class NumberFormatUtil {
	public static float formatFloat(float number){
		 DecimalFormat df = new DecimalFormat("#.00");//精确到小数点后两位
	     String str = df.format(number);
	     try{
	    	 number=Float.parseFloat(str);
	     }catch(Exception e){
	    	 e.printStackTrace();
	     }
	     return number;
	}
}
