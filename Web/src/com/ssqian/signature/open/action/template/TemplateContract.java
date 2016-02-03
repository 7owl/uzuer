/**
 * TemplateContract.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2014
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on 2014-11-5 下午2:35:28
 * @author lijianhang
 * @version 1.0
 */

/**
 * 
 */
package com.ssqian.signature.open.action.template;

import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;
import com.ssqian.common.util.WebUtils;

/**
 * @author lijianhang
 *
 */
public class TemplateContract extends BaseAPIService {

	public static JSONObject execute(Map<String, String> paras) throws JSONException {

		String id = paras.get("id");
		reqcontent.put("id", paras.get("id"));
		reqcontent.put("contractno", paras.get("contractno"));
		reqcontent.put("contractname", paras.get("contractname"));
		reqcontent.put("isvideo", WebUtils.nullToStrTrim(paras.get("isvideo")));
		reqcontent.put("name", WebUtils.nullToStrTrim(paras.get("name")));
		reqcontent.put("idcard", WebUtils.nullToStrTrim(paras.get("idcard")));
		reqcontent.put("email", WebUtils.nullToStrTrim(paras.get("email")));
		reqcontent.put("mobile", WebUtils.nullToStrTrim(paras.get("mobile")));

		JSONObject json = TemplatecfgGet.execute(id);
		JSONObject res = json.getJSONObject("response");
		JSONObject info = res.getJSONObject("info");
		String code = String.valueOf(info.get("code"));
		if (code.equals(CoreConstants.SUCCESS_CODE)) {
			JSONArray contractlist = res.getJSONObject("content").getJSONArray("tempcfglist");
			int length = contractlist.length();
			for (int i=0; i<length; i++) {
				JSONObject tempcfginfo = contractlist.getJSONObject(i).getJSONObject("tempcfginfo");
				reqcontent.put(String.valueOf(tempcfginfo.get("id")), i + 1); //这个值请根据具体情况填写
			}
		}

		action = "templateContract.json";

		return doService();
	}

}
