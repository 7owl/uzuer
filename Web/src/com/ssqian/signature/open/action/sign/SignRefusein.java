package com.ssqian.signature.open.action.sign;

import com.ssqian.common.service.BaseAPIService;

public class SignRefusein extends BaseAPIService{

	
	public static String execute() {
		String tmpstring = "";
		action ="signRefuseinface.json";
		stype=4;// 4：合同签名
		String status = "2";//合同状态
		String userName="123456";
		String email="362021204@qq.com";
		String fsdid="1428471503060Q54W2";//合同编号		
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
