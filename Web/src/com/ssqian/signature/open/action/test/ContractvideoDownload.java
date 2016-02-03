package com.ssqian.signature.open.action.test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;

public class ContractvideoDownload {
	public static void excute() throws IOException {
		String action = "contractDownload.page";
		StringBuilder signdata = new StringBuilder();
		signdata.append(action+CoreConstants.SIGN_SPLITSTR);
		signdata.append(CoreConstants.MID+CoreConstants.SIGN_SPLITSTR);
		signdata.append("14358378826312QT72"+CoreConstants.SIGN_SPLITSTR);
		signdata.append("3");
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign = java.net.URLEncoder.encode(sign);
		String url = "https://www.ssqian.com.cn/openpage/contractDownload.page?fsdid=14358378826312QT72&status=3&mid=E0000000000000000099&sign="+sign;
		System.out.println(url);				
	}

	public static void main(String[] args) throws IOException {
		excute();
	}
}
