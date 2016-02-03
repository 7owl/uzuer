package com.uzuser.thirdparty.sciener;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.MessageFormat;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.params.HttpParams;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.lingtong.util.SystemConfiguration;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.util.MD5Utils;

import net.sf.json.JSONObject;

/**
 * @author xqq
 * @date 2015-9-26 上午12:32:22
 * 
 */
public class FreezeKeyUtil {
	private static FreezeKeyUtil util;
	
	private FreezeKeyUtil(){}
	
	public static FreezeKeyUtil getInstance(){
		if( util == null ){
			util = new FreezeKeyUtil();
		}
		return util;
	}
	
	/***
	 * 冻结电子锁
	 * @param json
	 * @param room_id
	 * @param key_id
	 * @return
	 */
	public boolean freeze(JSONObject json, Integer room_id, Integer key_id, String openid){
		String access_token = json.get("access_token").toString();
		String client_id = SystemConfiguration.getString("sciener.client_id");
		//String openid = json.getString("openid").toString();
		
		String url = MessageFormat
				.format("https://api.sciener.cn/v1/key/freeze?access_token={0}&client_id={1}&openid={2}&room_id={3}&key_id={4}&date={5}",
						access_token, client_id, openid, room_id+"", key_id+"", System.currentTimeMillis()+"");
		System.out.println("冻结电子锁接口地址:" + url);
		boolean flag = false;
		try {
			HttpGet get = new HttpGet(url);
			HttpClient client = new DefaultHttpClient();
			client = WrapClientUtils.wrapClient(client);
			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT,
					CoreConstants.REQUESTTIMEOUTINMILLIS);
			HttpResponse status = client.execute(get);
			StringBuilder sb = new StringBuilder("");
			if (status.getStatusLine().getStatusCode() == 200) {
				HttpEntity entity = status.getEntity();
				InputStream in = entity.getContent();
				if (in != null) {
					int l = -1;
					byte[] tmp = new byte[1024];
					while ((l = in.read(tmp)) != -1) {
						sb.append(new String(tmp, 0, l));
						System.out.println(new String(tmp, 0, l));
					}
				}
			}
			if( StringUtils.isNotBlank(sb.toString()) ){
				JSONObject result = JSONObject.fromObject(sb.toString());
				if( result.get("errcode") != null && result.getInt("errcode") == 0 ){
					flag = true;
				}
			}
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			return flag;
		}
	}
	/***
	 * 解冻电子锁
	 * @param json
	 * @param room_id
	 * @param key_id
	 * @return
	 */
	public boolean unfreeze(JSONObject json, Integer room_id, Integer key_id, String openid){
		String access_token = json.get("access_token").toString();
		String client_id = SystemConfiguration.getString("sciener.client_id");
		//String openid = json.getString("openid").toString();
		
		String url = MessageFormat
				.format("https://api.sciener.cn/v1/key/unfreeze?access_token={0}&client_id={1}&openid={2}&room_id={3}&key_id={4}&date={5}",
						access_token, client_id, openid, room_id+"", key_id+"", System.currentTimeMillis()+"");
		System.out.println("解冻电子锁接口地址:" + url);
		boolean flag = false;
		try {
			HttpGet get = new HttpGet(url);
			HttpClient client = new DefaultHttpClient();
			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT,
					CoreConstants.REQUESTTIMEOUTINMILLIS);
			HttpResponse status = client.execute(get);
			StringBuilder sb = new StringBuilder("");
			if (status.getStatusLine().getStatusCode() == 200) {
				HttpEntity entity = status.getEntity();
				InputStream in = entity.getContent();
				if (in != null) {
					int l = -1;
					byte[] tmp = new byte[1024];
					while ((l = in.read(tmp)) != -1) {
						sb.append(new String(tmp, 0, l));
						System.out.println(new String(tmp, 0, l));
					}
				}
			}
			if( StringUtils.isNotBlank(sb.toString()) ){
				JSONObject result = JSONObject.fromObject(sb.toString());
				if( result.get("errcode") != null && result.getInt("errcode") == 0 ){
					flag = true;
				}
			}
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			return flag;
		}
	}
	public static void main(String[] args) {
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		//Map json = Authorize.getInstance().authorizeDirect("api_sciener@uzuer.com", "47f71f4336d30258e7e7ec813c92f3c2");
		/*Map json = Authorize.getInstance().authorizeDirect("uzu_15715800143", MD5Utils.md5("800143"));
		if( json != null ){
			FreezeKeyUtil.getInstance().freeze(JSONObject.fromObject(json), 3106, 30541);
		}*/
	}
}
