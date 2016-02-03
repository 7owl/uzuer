/**
 * TemplatedocDelete.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2014
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on 2014-11-4 上午10:47:44
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
public class TemplatedocDelete extends BaseAPIService {

	public static JSONObject execute(String id) {

		action = "templatedocDelete.json";

		reqcontent.put("id", id);

		return doService();
	}

}
