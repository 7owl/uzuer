package com.ssqian.signature.open.action.test;

import com.ssqian.common.service.BaseAPIService;

public class ContractQuery extends BaseAPIService{
	
	
	
	public static String execute() {
		String tmpstring = "";
		action ="contractQuery.json";
		stype=1;//1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名
		String status = "1";//合同状态	
		reqcontent.put("status", status);
		tmpstring = doService(stype).toString();
		System.out.println(tmpstring);
		return tmpstring;

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		execute();
	}

}
