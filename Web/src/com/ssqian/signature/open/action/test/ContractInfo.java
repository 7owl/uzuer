package com.ssqian.signature.open.action.test;

import com.ssqian.common.service.BaseAPIService;

public class ContractInfo extends BaseAPIService {

	public static String execute() {
		String tmpstring = "";
		action ="contractInfo.json";
		stype=2;//1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名
		String status = "2";//合同状态
		String fsdid="1430380557067F8Y32";//合同编号		
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
