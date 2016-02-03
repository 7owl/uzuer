package com.lingtong.interfaces.message;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

/**
 * @author xqq
 * @date 2015-8-23 下午1:04:47
 * 
 */
public class TestAppPage {
	public static void main(String[] args) {
		AppRoomPage page = new AppRoomPage();
		Map<String, String> filter = new HashMap<String, String>();
		filter.put("price", "1000,5000");
		filter.put("kind", "2室");
		filter.put("rental_end_time", "30");
		filter.put("createtime", "yes");
		page.setFilter(filter);
		
		Map<String, String> order = new HashMap<String, String>();
		order.put("size", "1");
		order.put("price", "0");
		order.put("distance", "1");
		order.put("createtime", "1");
		page.setSort(order);
		
		page.setCurPage(1);//当前页
		System.out.println( new Gson().toJson(page));
		//System.out.println( AppRoomPageUtil.getInstance().getPageSql( page, "120,12" ) );
	}
}
