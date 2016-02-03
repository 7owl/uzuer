package com.lingtong.interfaces.interceptor;

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
import org.apache.wink.client.Resource;
import org.apache.wink.client.RestClient;
import org.apache.wink.json4j.JSONException;
import org.apache.wink.json4j.JSONObject;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.google.gson.Gson;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.util.SystemConfiguration;

/**
 * @author xqq
 * @date 2015-8-16 上午10:28:57
 * 
 */
public class BmobSmsUtil {
	private static BmobSmsUtil bmob;
	
	private static  String APPLICATIONID = SystemConfiguration.getString("bomb.applicationid");
	private static  String RESTAPIKEY = SystemConfiguration.getString("bomb.restapikey");
	
	private BmobSmsUtil(){};
	
	public static BmobSmsUtil getInstance(){
		if( bmob == null ){
			bmob = new BmobSmsUtil();
		}
		return bmob;
	}
	//获取验证码
	public Map<String, Object> requestSmsCode( String tel_number ){
		Map<String, Object> ret = new HashMap<String, Object>();
		
		JSONObject result;

		String url = "https://api.bmob.cn/1/requestSmsCode";
		RestClient restClient;
		try {
			restClient = new RestClient(getClientConfig());
			Resource resource = restClient.resource(url);

			resource.header("X-Bmob-Application-Id", APPLICATIONID);

			resource.header("X-Bmob-REST-API-Key", RESTAPIKEY);
			
			resource.contentType("application/json");
			
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("mobilePhoneNumber", tel_number );
			ClientResponse response = resource.post(new Gson().toJson(map));

			if (response.getStatusCode() == 200) {

				try {
					result = new JSONObject(response.getEntity(String.class));
					System.out.println("result:" + result );
					ret.put("code", 0);
					ret.put("msg", "获取验证码成功");
					return ret;
				} catch (JSONException e) {
					e.printStackTrace();
				}

			}
			System.out.println("获取验证码请求状态:" + response.getStatusCode() + ";" + response.getMessage());
			ret.put("code", CommonErrorEnum.REQUEST_SMS_CODE_OUT_FALI.getCode() );
			ret.put("msg", CommonErrorEnum.REQUEST_SMS_CODE_OUT_FALI.getMessage() );
			return ret;
		} catch (ServletException e1) {
			e1.printStackTrace();
			ret.put("code", CommonErrorEnum.REQUEST_SMS_CODE_IN_FALI.getCode());
			ret.put("msg", CommonErrorEnum.REQUEST_SMS_CODE_IN_FALI.getMessage());
			return ret;
		}
	}
	//验证验证码
	public boolean verifySmsCode( String smsCode, String tel_number ){
		JSONObject result;

		String url = "https://api.bmob.cn/1/verifySmsCode/" + smsCode;
		RestClient restClient;
		try {
			restClient = new RestClient(getClientConfig());
			Resource resource = restClient.resource(url);

			resource.header("X-Bmob-Application-Id", APPLICATIONID);

			resource.header("X-Bmob-REST-API-Key", RESTAPIKEY);
			
			resource.contentType("application/json");
			
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("mobilePhoneNumber", tel_number);
			ClientResponse response = resource.post(new Gson().toJson(map));

			if (response.getStatusCode() == 200) {

				try {
					result = new JSONObject(response.getEntity(String.class));
					System.out.println("result:" + result );
					if( result != null && "ok".equals( result.get("msg") )){
						return true;
					}
					return false;
				} catch (JSONException e) {
					e.printStackTrace();
					return false;
				}

			}
			System.out.println( "验证验证码结果:" + response.getStatusCode());
		} catch (ServletException e1) {
			e1.printStackTrace();
			return false;
		}
		return false;
	}
	//发送短信
	public void sendSMS(String content, String tel_number){
		JSONObject result;

		String url = "https://api.bmob.cn/1/requestSms";
		RestClient restClient;
		try {
			restClient = new RestClient(getClientConfig());
			Resource resource = restClient.resource(url);
			
			resource.header("X-Bmob-Application-Id", APPLICATIONID);

			resource.header("X-Bmob-REST-API-Key", RESTAPIKEY);
			
			resource.contentType("application/json");
			System.out.println(APPLICATIONID+","+RESTAPIKEY);
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("mobilePhoneNumber", tel_number);
			map.put("content", content);
			ClientResponse response = resource.post(new Gson().toJson(map));
			if (response.getStatusCode() == 200) {
				System.out.println(tel_number+",短信发送成功...");
			} else {
				System.out.println( "结果:" + response.getStatusCode());
			}
		} catch (ServletException e1) {
			e1.printStackTrace();
			System.out.println(tel_number+",短信发送失败...");
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
	
	public static void main(String[] args) {
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		APPLICATIONID = SystemConfiguration.getString("APPLICATIONID");
		RESTAPIKEY = SystemConfiguration.getString("RESTAPIKEY");
		new BmobSmsUtil().sendSMS("hello mtt", "15215731373");
	}
}
