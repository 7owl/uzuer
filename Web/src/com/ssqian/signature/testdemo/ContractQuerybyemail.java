package com.ssqian.signature.testdemo;

import org.json.JSONObject;

import com.ssqian.common.service.BaseAPIService;

public class ContractQuerybyemail  extends BaseAPIService {
	public static String execute() {
		String tmpstring = "";
		action ="contractQuerybyEmail.json";
		stype=1;//1：合同列表查询 
		String status = "7";//合同状态	
		String email = "362021204@qq.com";//合同状态	
		String datetime="2015-07-10 11:49:52";
		String endtime="2015-07-23 11:49:52";
		reqcontent.put("status", status);
		reqcontent.put("email", email);
		reqcontent.put("starttime", datetime);	
		reqcontent.put("endtime", endtime);	
		
		
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
