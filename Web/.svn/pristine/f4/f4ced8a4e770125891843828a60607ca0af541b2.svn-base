package com.ssqian.signature.open.action.template;

import java.io.File;
import java.io.FileInputStream;

import java.io.IOException;

import sun.misc.BASE64Encoder;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class ContractQuerytest1 extends BaseAPIService {

	public static String execute() {
	
			action = "getSignPagemobile.json";
		

			// subdata = filename + ¡°\n¡± + email + ¡°\n¡± + name + ¡°\n¡± +
			// needvideo + ¡°\n¡± + mobile + ¡°\n¡± + emailtitle + ¡°\n¡± +
			// emailcontent + ¡°\n¡± + sxdays + ¡°\n¡± + selfsign

			String status="2";
			reqcontent.put("status", status);

			//reqcontent="12345";

			
			
		

		String tmpstring = "";

		// tmpstring=doUPService().toString();
		tmpstring = doService(1).toString();
		System.out.println(tmpstring);

		return tmpstring;
	}

	public static void main(String[] args) {

		execute();
	}

}
