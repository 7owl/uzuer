package com.ssqian.signature.open.action.test;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class ContractdocUploadSend extends BaseAPIService {

	public static String execute() {

		action = "MultiJointcontractdocUploadsend.json";
		stype = 3;// 1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名
		uploadfile = "D:\\demo.docx";
		String filename = "demo.docx";

		String email = "362021204@qq.com";
		String name = "张五";
		String needvideo = "0";
        String mobile="18106532682";
		String emailtitle = "张五";
		String emailcontent = "210";
		String sxdays = "2";
		String selfsign = "1";

		subdata = filename + CoreConstants.SIGN_SPLITSTR + email
				+ CoreConstants.SIGN_SPLITSTR + name
				+ CoreConstants.SIGN_SPLITSTR + needvideo
				+ CoreConstants.SIGN_SPLITSTR + mobile
				+ CoreConstants.SIGN_SPLITSTR + emailtitle
				+ CoreConstants.SIGN_SPLITSTR + emailcontent
				+ CoreConstants.SIGN_SPLITSTR + sxdays 
				+ CoreConstants.SIGN_SPLITSTR + selfsign;
		
		String tmpstring = "";
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
