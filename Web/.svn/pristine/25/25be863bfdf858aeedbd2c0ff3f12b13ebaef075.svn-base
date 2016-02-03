package com.ssqian.signature.open.action.template;

import com.ssqian.common.service.BaseAPIService;

public class ContractQuerytest2 extends BaseAPIService {

	public static String execute() {

		action = "contractInfo.json";

		// subdata = filename + ¡°\n¡± + email + ¡°\n¡± + name + ¡°\n¡± +
		// needvideo + ¡°\n¡± + mobile + ¡°\n¡± + emailtitle + ¡°\n¡± +
		// emailcontent + ¡°\n¡± + sxdays + ¡°\n¡± + selfsign

		String status = "2";
		String fsdid="1427348791528SXG72";
		reqcontent.put("status", status);
		reqcontent.put("fsdid", fsdid);
		String tmpstring = "";

		// tmpstring=doUPService().toString();
		tmpstring = doService(0).toString();
		System.out.println(tmpstring);

		return tmpstring;
	}

	public static void main(String[] args) {

		execute();
	}

}
