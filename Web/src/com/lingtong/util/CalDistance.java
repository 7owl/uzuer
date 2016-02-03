package com.lingtong.util;

/**
 * @author xqq
 * @date 2015-8-26 下午8:59:11
 * 
 */
public class CalDistance {
	/* 根据经纬度计算距离
	 * 注意,数据库经纬度字段分别是longitude, longitude
	 */
	public static  String getDistanceBylonAndLat( Double longitude, Double latitude){
		return " round(6378.138*2*asin(sqrt(pow(sin((" + latitude + "*pi()/180-latitude*pi()/180)/2),2)+cos(" + latitude + "*pi()/180)*cos(latitude*pi()/180)*pow(sin( (" + longitude + "*pi()/180-longitude*pi()/180)/2),2)))*1000) ";
	}
}
