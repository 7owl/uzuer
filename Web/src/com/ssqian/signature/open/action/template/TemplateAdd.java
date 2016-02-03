/**
 * TemplateAdd.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2014
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on 2014-10-31 下午4:23:39
 * @author lijianhang
 * @version 1.0
 */

/**
 * 
 */
package com.ssqian.signature.open.action.template;

import org.json.JSONObject;

import com.ssqian.common.service.BaseAPIService;

/**
 * @author lijianhang
 *
 */
public class TemplateAdd extends BaseAPIService {

	public static JSONObject execute(String name, String desc) {

		action = "templateAdd.json";

		reqcontent.put("name", name);
		reqcontent.put("desc", desc);

		return doService();
	}

}
