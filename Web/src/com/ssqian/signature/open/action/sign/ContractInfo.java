package com.ssqian.signature.open.action.sign;

import com.ssqian.common.service.BaseAPIService;

public class ContractInfo extends BaseAPIService {

	public static String execute() {
		String tmpstring = "";
		action ="contractInfo.json";
		stype=2;//合同信息查询
		String fsdid="14387368724571DBB2";//合同编号		
		reqcontent.put("fsdid", fsdid);
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
