package com.ssqian.signature.demo;

import org.json.JSONObject;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class ContractQuery extends BaseAPIService{
	
	
	
	public static JSONObject execute(String statuspar,String MID, String PRIVATEKEY) {
		CoreConstants.MID=MID;
		CoreConstants.PRIVATEKEY=PRIVATEKEY;		
		action ="contractQuery.json";
		stype=1;//1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名
		String status = statuspar;//合同状态	
		reqcontent.put("status", status);
		
		return doService(stype);

	}

	

}