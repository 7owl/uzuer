package com.ssqian.signature.open.action.template;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.json.JSONObject;

import sun.misc.BASE64Encoder;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class Test1Upload extends BaseAPIService {

	public static String execute() {

		action = "contractdocUploadsend.json";
		String filePath = "D:\\errorCode.docx";

		// subdata = filename + °∞\n°± + email + °∞\n°± + name + °∞\n°± +
		// needvideo + °∞\n°± + mobile + °∞\n°± + emailtitle + °∞\n°± +
		// emailcontent + °∞\n°± + sxdays + °∞\n°± + selfsign

		String filename = "za829A25161820.doc";

		String cloudfilepath = "public/E0000000000000000009/za829A25161820.doc";
		String email = "252089721@qq.com";
		String name = "≤‚ ‘";
		String needvideo = "0";

		String emailtitle = "≤‚ ‘";
		String emailcontent = "≤‚ ‘";
		String sxdays = "";
		String selfsign = "0";
		// reqcontent.put("filename", filename);

		// reqcontent.put("cloudfilepath", cloudfilepath);

		uploadfile = "D:\\errorCode.docx";

		String tmpstring = "";

		tmpstring = doUPService().toString();
		// tmpstring=doService().toString();
		System.out.println(tmpstring);

		return tmpstring;
	}

	public static void main(String[] args) {

		execute();
	}

}
