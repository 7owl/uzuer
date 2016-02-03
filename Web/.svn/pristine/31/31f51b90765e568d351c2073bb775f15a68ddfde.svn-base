package com.ssqian.signature.open.action.test;

import com.ssqian.common.service.BaseAPIService;

public class SignRefusein extends BaseAPIService{

	
	public static String execute() {
		String tmpstring = "";
		action ="signRefuseinface.json";
		stype=4;//1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名
		String status = "1";//合同状态
		String userName="123456";
		String email="liwenjixxxx@163.com";
		String fsdid="14380636434435CJ82";//合同编号		
		reqcontent.put("status", status);
		
		
		reqcontent.put("fsdid", fsdid);
		
		reqcontent.put("email", email);
		reqcontent.put("userName", userName);
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
