/**
 * BaseAPIService.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2013
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on 2013-7-29 上午11:05:42
 * @author lijianhang
 * @version 1.0
 */

/**
 * 
 */
package com.ssqian.common.service;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import com.ssqian.common.util.WebUtils;

/**
 * @author lijianhang
 * 
 */
public class BaseAPIService {

	protected static String action = "";

	protected static String uploadfile = "";

	protected static Map<String, Object> upcontent = new LinkedHashMap<String, Object>();

	protected static String subdata = "";

	protected static Map<String, Object> reqcontent = new LinkedHashMap<String, Object>();

	protected static int stype = 0;
	
	protected static String userlist;
	
	protected static String senduser;

	protected static JSONObject doService() {

		APIServiceHelper serviceHelper = new APIServiceHelper(action);
		return toJson(serviceHelper.doService(reqcontent));
	}

	protected static JSONObject doService(int type, String mobile,String companyName, String imgType,String imgName){
		APIServiceHelper serviceHelper = new APIServiceHelper(action);
		JSONObject jsonObject;
		jsonObject=toJson(serviceHelper.updoService(uploadfile, mobile,
				 subdata,  type,  companyName,  imgType, imgName));
		return jsonObject;
	}
	
	protected static JSONObject doService(int type) {

		APIServiceHelper serviceHelper = new APIServiceHelper(action);

		JSONObject jsonObject;
		switch (type) {
		case 3:
			jsonObject = toJson(serviceHelper.updoService(uploadfile,
					upcontent, subdata, type,userlist));
			break;

		case 5:
			jsonObject = toJson(serviceHelper.updoService(uploadfile,
					upcontent, subdata, type,userlist));
			break;
		case 6:
			jsonObject = toJson(serviceHelper.updoService(uploadfile,
					upcontent, subdata, type,userlist,senduser));
			break;
			
		case 7:
			jsonObject = toJson(serviceHelper.updoService(uploadfile,
					upcontent, subdata, type,userlist,senduser));
			break;	
			
		case 9:
			jsonObject = toJson(serviceHelper.doService(reqcontent, type));
			break;	
			
		case 10:
			jsonObject = toJson(serviceHelper.updoService(uploadfile,
					upcontent, subdata, type,userlist,senduser));
			break;
		case 11:
			jsonObject = toJson(serviceHelper.updoService(uploadfile,
					upcontent, subdata, type,userlist,senduser));
			break;	
		case 12:
			jsonObject = toJson(serviceHelper.updoService(uploadfile,
					upcontent, subdata, type,userlist,senduser));
			break;	
		default:
			jsonObject = toJson(serviceHelper.doService(reqcontent, type));
			break;
		}

		return jsonObject;

	}

	protected static JSONObject doUPService() {

		APIServiceHelper serviceHelper = new APIServiceHelper(action);
		return toJson(serviceHelper.doService(uploadfile, upcontent, subdata));
	}

	private static JSONObject toJson(String content) {

		content = WebUtils.nullToStrTrim(content);

		if (WebUtils.isEmpty(content)) {
			return null;
		}

		StringReader stringReader = new StringReader(content);

		try {
			return new JSONObject(stringReader);
		} catch (Exception e) {
			return null;
		}
	}

	protected static List<Map<String, Map<String, String>>> getListMult(
			String element, List<Map<String, String>> contents) {

		if (WebUtils.isEmpty(element) || contents == null
				|| contents.size() == 0) {
			return null;
		}

		Map<String, Map<String, String>> maplist = null;
		Map<String, String> map = null;
		List<Map<String, Map<String, String>>> list = new ArrayList<Map<String, Map<String, String>>>();

		for (Map<String, String> values : contents) {

			maplist = new HashMap<String, Map<String, String>>();
			map = new HashMap<String, String>();
			for (String value : values.keySet()) {
				map.put(value, WebUtils.nullToStrTrim(values.get(value)));
			}

			maplist.put(element, map);
			list.add(maplist);
		}

		return list;
	}

}
