package com.ssqian.signature.demo;

import java.io.IOException;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;

public class GetSignPagepc {

	public static String excute(String pagenum,String signx,String signy, String MID,String signid,String email) throws IOException {

		String sign = "";
		
		
		
		String action = "getSignPagePc.json";
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
		signdata.append(CoreConstants.SIGN_SPLITSTR + pagenum);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signx);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signy);
		
		
	
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sign=java.net.URLEncoder.encode(sign);
		
		
		
		

		return sign;

	}

}
