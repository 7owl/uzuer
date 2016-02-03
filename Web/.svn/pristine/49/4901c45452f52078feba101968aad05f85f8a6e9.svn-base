package com.uzuser.thirdparty.sciener;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.apache.commons.lang.StringUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.params.HttpParams;

import com.lingtong.model.Tenants;
import com.lingtong.model.Unlock;
import com.lingtong.util.SystemConfiguration;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.util.MD5Utils;

import net.sf.json.JSONObject;

/**
 * @author xqq
 * @date 2015-9-23 上午12:06:54
 * 
 */
public class SendKey {
	private static SendKey util;
	
	private SendKey(){}
	
	public static SendKey getInstance(){
		if( util == null ){
			util = new SendKey();
		}
		return util;
	}
	
	public boolean sendKey(Integer room_id, Tenants tenant, String start_date, String end_date) {
		String sciener_password = tenant.getSciener_password();
		/*********************************************管理员登录的token*********************************************/
		Map map = Authorize.getInstance().authorizeDirect(SystemConfiguration.getString("sciener.admin.username"), MD5Utils.md5(SystemConfiguration.getString("sciener.admin.password")));
		if( map == null ){
			System.out.println("sendKey,获取管理员token失败");
			return false;
		}
		String client_id = SystemConfiguration.getString("sciener.client_id");
		String access_token = map.get("access_token") != null ? map.get(
				"access_token").toString() : "";
		long date = System.currentTimeMillis();
		/*********************************************管理员登录的token*********************************************/
		String url = MessageFormat
				.format("https://api.sciener.cn/v1/key/send?client_id={0}&access_token={1}&openid={2}&room_id={3}&date={4}&start_date={5}&end_date={6}",
						client_id, access_token, tenant.getSciener_openid() + "", room_id + "",
						date + "", start_date, end_date);
		System.out.println("sendKey:"+url);
		InputStream in = null;
		boolean flag = false;
		try {
			HttpGet get = new HttpGet(url);
			HttpClient client = new DefaultHttpClient();
			client = WrapClientUtils.wrapClient(client);
			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT,
					CoreConstants.REQUESTTIMEOUTINMILLIS);
			HttpParams params = new BasicHttpParams();
			get.setParams(params);
			HttpResponse status = client.execute(get);
			if (status.getStatusLine().getStatusCode() == 200) {
				Header[] headers = status.getAllHeaders();
				for (int i = 0; i < headers.length; i++) {
					System.out.println(headers[i].toString());
				}
				HttpEntity entity = status.getEntity();
				in = entity.getContent();
				StringBuilder sb = new StringBuilder();
				if (in != null) {
					int l = -1;
					byte[] tmp = new byte[1024];
					while ((l = in.read(tmp)) != -1) {
						sb.append(new String(tmp, 0, l));
						System.out.println(new String(tmp, 0, l));
					}
				}
				JSONObject json = JSONObject.fromObject(sb.toString());
				if( json != null ){
					Integer errcode = json.getInt("errcode");
					if( errcode == 0 ){
						flag = true;
					}
				}
			}
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if( in != null ){
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return flag;
		}
	}

}
