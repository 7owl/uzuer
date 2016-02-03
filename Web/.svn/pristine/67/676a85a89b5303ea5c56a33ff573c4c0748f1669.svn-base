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

public class GetSignPageself {

	public static void excute() throws IOException {

		String returnurl="https://www.baidu.com/";
		String action = "contractSelfsign.page";
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + "1430205318744Y3ZJ2");
		signdata.append(CoreConstants.SIGN_SPLITSTR + returnurl);
		
//		
//		signdata.append("mid="+ CoreConstants.MID);
//		signdata.append("&signid="  + "1430125916512REF12");
//		signdata.append("&returnurl=" + returnurl);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign=java.net.URLEncoder.encode(sign);
		String url = "http://localhost:8080/openpage/contractSelfsign.page?signid=1430205318744Y3ZJ2&returnurl=https://www.baidu.com/&mid=E0000000000000000009&sign="
				+ sign;
		
		System.out.println(url);
//		HttpClient client = new DefaultHttpClient();
//		HttpGet request = new HttpGet(url);
//		HttpResponse response = client.execute(request);
//		System.out.println("Response Code: "
//				+ response.getStatusLine().getStatusCode());
//		BufferedReader rd = new BufferedReader(new InputStreamReader(response
//				.getEntity().getContent()));
//		String line = "";
//		while ((line = rd.readLine()) != null) {
//			System.out.println(line);
//		}

	}
	public static void main(String[] args) throws IOException {
		excute();

	}

}
