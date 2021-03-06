package com.lingtong.interfaces.test;

import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.servlet.ServletException;

import org.apache.wink.client.ClientConfig;
import org.apache.wink.client.ClientResponse;
import org.apache.wink.client.RestClient;
import org.apache.wink.client.Resource;
import org.apache.wink.json4j.JSONException;
import org.apache.wink.json4j.JSONObject;

import com.google.gson.Gson;

/**
 * @author xqq
 * @date 2015-8-16 上午8:49:14
 * 
 */
public class TestSMS {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		//new TestSMS().getMethod();
		//new TestSMS().verifySMS();
		new TestSMS().sendSMS();
	}
	
	public void sendSMS(){
		JSONObject result;

		String url = "https://api.bmob.cn/1/requestSmsCode";
		RestClient restClient;
		try {
			restClient = new RestClient(getClientConfig());
			Resource resource = restClient.resource(url);

			//resource.header("X-Bmob-Application-Id", "6703d7f03cd5c12024c452771c7d50e3");
			//resource.header("X-Bmob-REST-API-Key", "ccfd88c4d55a68d8a50c155853bda607");
			
			resource.header("X-Bmob-Application-Id", "78ffc654d3597de9983fad2570abd64b");
			resource.header("X-Bmob-REST-API-Key", "de2e19eea3a3db3e4fb87e6303063729");
			
			resource.contentType("application/json");
			
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("mobilePhoneNumber", "18458195521");
			//map.put("mobilePhoneNumber", "15715800143");
			//map.put("mobilePhoneNumber", "15215731373");
			//map.put("content", "haha");
			ClientResponse response = resource.post(new Gson().toJson(map));

			if (response.getStatusCode() == 200) {

				try {
					result = new JSONObject(response.getEntity(String.class));
					System.out.println("result:" + result );
				} catch (JSONException e) {
					e.printStackTrace();
				}

			}
			System.out.println(response.getStatusCode());
			System.out.println(response.getMessage());
		} catch (ServletException e1) {
			e1.printStackTrace();
		}
	}
	
	public void verifySMS(){
		JSONObject result;

		String url = "https://api.bmob.cn/1/verifySmsCode/620681";
		RestClient restClient;
		try {
			restClient = new RestClient(getClientConfig());
			Resource resource = restClient.resource(url);

			resource.header("X-Bmob-Application-Id", "6703d7f03cd5c12024c452771c7d50e3");

			resource.header("X-Bmob-REST-API-Key", "ccfd88c4d55a68d8a50c155853bda607");
			
			resource.contentType("application/json");
			
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("mobilePhoneNumber", "15215731373");
			ClientResponse response = resource.post(new Gson().toJson(map));

			if (response.getStatusCode() == 200) {

				try {
					result = new JSONObject(response.getEntity(String.class));
					System.out.println("result:" + result );
				} catch (JSONException e) {
					e.printStackTrace();
				}

			}
			System.out.println(response.getStatusCode());
		} catch (ServletException e1) {
			e1.printStackTrace();
		}
	}
	
	public void getMethod(){

		JSONObject result;

		String url = "https://api.bmob.cn/1/classes/_User";
		RestClient restClient;
		try {
			restClient = new RestClient(getClientConfig());
			Resource resource = restClient.resource(url);

			resource.header("X-Bmob-Application-Id", "6703d7f03cd5c12024c452771c7d50e3");

			resource.header("X-Bmob-REST-API-Key", "ccfd88c4d55a68d8a50c155853bda607");

			ClientResponse response = resource.get();

			if (response.getStatusCode() == 200) {

				try {
					result = new JSONObject(response.getEntity(String.class));
					System.out.println("result:" + result );
				} catch (JSONException e) {
					e.printStackTrace();
				}

			}
			System.out.println(response.getStatusCode());
		} catch (ServletException e1) {
			e1.printStackTrace();
		}

		
	}

	private ClientConfig getClientConfig() throws ServletException {

		ClientConfig myConfig = new ClientConfig();

		SSLContext sc;

		try {

			sc = SSLContext.getInstance("SSL");

			sc.init(null, getTrustManager(), new java.security.SecureRandom());

		} catch (NoSuchAlgorithmException e) {

			throw new ServletException(e.getMessage());

		} catch (KeyManagementException e) {

			throw new ServletException(e.getMessage());

		}

		HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

		myConfig.setBypassHostnameVerification(true);

		myConfig.connectTimeout(100000);

		myConfig.readTimeout(100000);

		myConfig.followRedirects(false);

		return myConfig;

	}

	private TrustManager[] getTrustManager() {

		TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {

			public java.security.cert.X509Certificate[] getAcceptedIssuers() {

				return null;

			}

			public void checkClientTrusted(

			java.security.cert.X509Certificate[] certs, String authType) {

			}

			public void checkServerTrusted(

			java.security.cert.X509Certificate[] certs, String authType) {

			}

		} };

		return trustAllCerts;
	}
}
