package com.ssqian.signature.testdemo;

import com.ssqian.common.service.BaseAPIService;

public class ContractAutoSignAfterPay extends BaseAPIService{


	public static String execute(String signid,String email) { 
		String tmpstring = "";
		action ="AutoSign.json";
		stype=2; 
//		String signid="1439884271910BXDF2";
//		String email="13706532684@nomail.visual";
		String pagenum="0";
		String signx="0.5";
		String signy="0.5";
		
		String openflag="1"; 
		
		reqcontent.put("email", email);
		reqcontent.put("signid", signid);
		reqcontent.put("pagenum", pagenum);
		reqcontent.put("signx", signx);
		reqcontent.put("signy", signy);
		reqcontent.put("openflag", openflag);
		
		tmpstring = doService(stype).toString();
		System.out.println(tmpstring);
		return tmpstring;

	}

	/**
	 * @param args
	 */
//	public static void main(String[] args) {
//		execute();
//	}


}
