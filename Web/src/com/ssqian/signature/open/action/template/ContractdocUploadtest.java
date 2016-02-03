package com.ssqian.signature.open.action.template;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.json.JSONObject;

import sun.misc.BASE64Encoder;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class ContractdocUploadtest extends BaseAPIService {

	public static String execute() {
		try {
			action = "UseClouddocsend.json";
			String filePath = "D:\\errorCode.docx";

			// subdata = filename + °∞\n°± + email + °∞\n°± + name + °∞\n°± +
			// needvideo + °∞\n°± + mobile + °∞\n°± + emailtitle + °∞\n°± +
			// emailcontent + °∞\n°± + sxdays + °∞\n°± + selfsign

			String filename = "za829A25161820.doc";
			
			String cloudfilepath="public/E0000000000000000009/za829A25161820.doc";
			String email = "252089721@qq.com";
			String name = "≤‚ ‘";
			String needvideo = "0";

			String emailtitle = "≤‚ ‘";
			String emailcontent = "≤‚ ‘";
			String sxdays = "";
			String selfsign = "0";
			reqcontent.put("filename", filename);
			
			reqcontent.put("cloudfilepath", cloudfilepath);
			
			File file = new File(filePath);
			FileInputStream fileInputStream;

			fileInputStream = new FileInputStream(file);
			byte[] buffer = new byte[(int) file.length()];

			fileInputStream.read(buffer);
			fileInputStream.close();
			String base64Code = new BASE64Encoder().encode(buffer);
			uploadfile = "D:\\errorCode.docx";

			subdata = filename + CoreConstants.SIGN_SPLITSTR + email
					+ CoreConstants.SIGN_SPLITSTR + name
					+ CoreConstants.SIGN_SPLITSTR + needvideo
					+ CoreConstants.SIGN_SPLITSTR + emailtitle
					+ CoreConstants.SIGN_SPLITSTR + emailtitle
					+ CoreConstants.SIGN_SPLITSTR + emailcontent
					+ CoreConstants.SIGN_SPLITSTR + sxdays + emailcontent
					+ CoreConstants.SIGN_SPLITSTR + selfsign;

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	String tmpstring="";
	
	//tmpstring=doUPService().toString();
	tmpstring=doService().toString();
	System.out.println(tmpstring);
	
	
		return tmpstring;
	}

	public static void main(String[] args) {

		execute();
	}

}
