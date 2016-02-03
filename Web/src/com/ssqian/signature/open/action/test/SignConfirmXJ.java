package com.ssqian.signature.open.action.test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.net.ssl.SSLSocketFactory;
import javax.security.cert.CertificateException;
import javax.security.cert.X509Certificate;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.httpclient.HttpClientImpl;
import com.ssqian.signature.util.SignUtil;

import java.security.cert.*;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.*;

public class SignConfirmXJ {

	public static void excute() throws IOException {// 指定位置，生成默认图片
		String action = "signConfirmXJ.json";
		String mid = CoreConstants.MID;
		String fsid = "1438199549303B3I22";
		String email = "252089721@qq.com";
		String pagenum = "1";
		String signx = "0.5";
		String signy = "0.5";

		// String returnurl = "https://www.baidu.com";
		// String typedevice = "2";

		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + mid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
		signdata.append(CoreConstants.SIGN_SPLITSTR + pagenum);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signx);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signy);
		// signdata.append(CoreConstants.SIGN_SPLITSTR + returnurl);
		// signdata.append(CoreConstants.SIGN_SPLITSTR + typedevice);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign = java.net.URLEncoder.encode(sign);
		String url = "https://www.ssqian.com.cn/openpage/" + action
				+ "?fsid=" + fsid + "&pagenum=" + pagenum + "&signx=" + signx
				+ "&signy=" + signy + "&email=" + email + "&mid=" + mid
				+ "&sign=" + sign;
		System.out.println(url);

		// HttpClientImpl hc = null;
		// try {
		// hc = new HttpClientImpl(url);
		// } catch (Exception e1) {
		// // TODO Auto-generated catch block
		// e1.printStackTrace();
		// }
		// HttpClient client = null;
		// try {
		// client = hc.wrapClient();
		// } catch (Exception e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// HttpGet request = new HttpGet(url);
		// HttpResponse response = client.execute(request);
		// System.out.println("Response Code: " +
		// response.getStatusLine().getStatusCode());
		// BufferedReader rd = new BufferedReader(new
		// InputStreamReader(response.getEntity().getContent()));
		// String line = "";
		// while ((line = rd.readLine()) != null) {
		// System.out.println(line);
		// }

		// HttpClientUtil.sendGetRequest(url);

		/*
		 * HttpClient client = new DefaultHttpClient();
		 * 
		 * HttpGet request = new HttpGet(url); HttpResponse response =
		 * client.execute(request);
		 * 
		 * //InputStream isr = response.getEntity().getContent();
		 * 
		 * System.out.println("Response Code: "+
		 * response.getStatusLine().getStatusCode()); BufferedReader rd = new
		 * BufferedReader(new
		 * InputStreamReader(response.getEntity().getContent()));
		 * 
		 * 
		 * //String fileContent =
		 * 
		 * 
		 * String line = ""; while ((line = rd.readLine()) != null) {
		 * System.out.println(line); }
		 */
	}

	public static void main(String[] args) throws IOException {
		excute();
	}

}
