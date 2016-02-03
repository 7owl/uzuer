package com.ssqian.signature.testdemo;

import java.io.IOException;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;

public class ContractvideoDownload {
	public static void excute() throws IOException {
		String action = "";
		String fsdid = "1439885344982CIGQ2";
		String url = CoreConstants.HOST + "openpage/";
		String status = "3";
		int urltype = 2;// 1表示zip、2、表示pdf文件
		if (urltype == 1) {
			action = "contractDownload.page";
			url = url + action;
		}
		if (urltype == 2) {
			action = "contractDownloadMobile.page";
			url = url + action;
		}
		StringBuilder signdata = new StringBuilder();
		signdata.append(action + CoreConstants.SIGN_SPLITSTR);
		signdata.append(CoreConstants.MID + CoreConstants.SIGN_SPLITSTR);
		signdata.append(fsdid + CoreConstants.SIGN_SPLITSTR);
		signdata.append(status);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign = java.net.URLEncoder.encode(sign);
		String geturl = url + "?fsdid=" + fsdid + "&status=" + status + "&mid="
				+ CoreConstants.MID + "&sign=" + sign;
		System.out.println(geturl);
	}

	public static void main(String[] args) throws IOException {
		excute();
	}
}
