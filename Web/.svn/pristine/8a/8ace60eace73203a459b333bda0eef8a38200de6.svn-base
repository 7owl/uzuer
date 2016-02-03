package com.uzuser.thirdparty.sciener;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.MessageFormat;
import java.util.Map;

import net.sf.json.JSONObject;

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

import com.lingtong.model.Tenants;
import com.lingtong.util.SystemConfiguration;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.util.MD5Utils;

/**
 * @author xqq
 * @date 2015-9-25 下午9:44:25
 * 科技锁注册工具类
 */
public class GetKeyListUtil {
	private static GetKeyListUtil util;
	
	private GetKeyListUtil(){}
	
	public static GetKeyListUtil getInstance(){
		if( util == null ){
			util = new GetKeyListUtil();
		}
		return util;
	}
	
	public JSONObject getKeyList(Map map){
		String client_id = SystemConfiguration.getString("sciener.client_id");
		
		if( map == null){
			map = Authorize.getInstance().authorizeDirect(SystemConfiguration.getString("sciener.admin.username"), MD5Utils.md5(SystemConfiguration.getString("sciener.admin.password")));
		}
		String access_token = map.get("access_token") != null ? map.get(
				"access_token").toString() : "";
		String url = MessageFormat
				.format("https://api.sciener.cn/v1/key/list?client_id={0}&access_token={1}&date={2}",
						client_id, access_token, System.currentTimeMillis()+"");
		System.out.println("sciener获取房源信息:" + url);
		InputStream in = null;
		String sciener_username = null;
		JSONObject json = null;
		try {
			HttpGet get = new HttpGet(url);
			HttpClient client = new DefaultHttpClient();
			client = WrapClientUtils.wrapClient(client);
			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT,
					CoreConstants.REQUESTTIMEOUTINMILLIS);
			HttpResponse status = client.execute(get);
			StringBuilder sb = new StringBuilder();
			if (status.getStatusLine().getStatusCode() == 200) {
				HttpEntity entity = status.getEntity();
				in = entity.getContent();
				if (in != null) {
					int l = -1;
					byte[] tmp = new byte[1024];
					while ((l = in.read(tmp)) != -1) {
						sb.append(new String(tmp, 0 , l));
						System.out.println(new String(tmp, 0, l));
					}
					json = JSONObject.fromObject(sb.toString());
				}
			}
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			if( in != null ){
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return json;
		}
	}
	
	public static void main(String[] args) {
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		Map map = Authorize.getInstance().authorizeDirect("uzu_15715800143", MD5Utils.md5("800143"));
		GetKeyListUtil.getInstance().getKeyList(map);
	}
}
