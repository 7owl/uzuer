/**
 * ContractInfo.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2014
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on 2014-11-10 下午1:44:36
 * @author lijianhang
 * @version 1.0
 */

/**
 * 
 */
package com.ssqian.signature.open.action.contract;

import org.json.JSONObject;

import com.ssqian.common.service.BaseAPIService;

/**
 * @author lijianhang
 *
 */
public class ContractInfo extends BaseAPIService {

	public static JSONObject execute(String fsdid, String status) {

		action = "contractInfo.json";

		reqcontent.put("fsdid", fsdid);
		reqcontent.put("status", status);

		return doService();
	}

}
