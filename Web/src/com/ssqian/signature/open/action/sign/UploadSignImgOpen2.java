package com.ssqian.signature.open.action.sign;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class UploadSignImgOpen2 extends BaseAPIService {

	public static String execute() {// 非注册用户公章上传
		String tmpstring = "";
		action = "nonRegUploadSeal2.json";
		stype = 10;
		uploadfile = "D:\\aeb21f51cd2544ad2.jpg";
		String mobile = "18698237448";
		String companyName = "北京股权通公司";//
		String imgType = "jpg";
		String imgName = "seal.jpg";
		subdata = mobile + CoreConstants.SIGN_SPLITSTR + companyName
				+ CoreConstants.SIGN_SPLITSTR + imgType
				+ CoreConstants.SIGN_SPLITSTR + imgName;

		tmpstring = doService(stype, mobile,companyName,imgType,imgName)
				.toString();
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
