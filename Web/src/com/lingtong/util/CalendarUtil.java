package com.lingtong.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class CalendarUtil {
	public static CalendarUtil calendarUtil = null;
	
	private DateFormat defaultDF = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	private CalendarUtil(){} 
	
	public static CalendarUtil getInstance(){
		if( calendarUtil == null ){
			calendarUtil = new CalendarUtil();
		}
		return calendarUtil;
	}
	
	/***
	 * 以yyyy-MM-dd HH:mm:ss格式,输出当前时间
	 * @return
	 */
	public String getCurrentTime(){
		Calendar cal = Calendar.getInstance();
		
		return defaultDF.format( cal.getTime() );
	}

	public String getCurrentTime( DateFormat defaultDF ){
		if( defaultDF == null ){
			return getCurrentTime();
		}
		Calendar cal = Calendar.getInstance();
		return defaultDF.format( cal.getTime() );
	}
}
