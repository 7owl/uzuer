package com.lingtong.interfaces.test;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.FileEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreConnectionPNames;

import com.lingtong.model.Tenants;
import com.ssqian.common.constant.CoreConstants;


public class TestContract {
	
    /** @MethodName	: main
     * @Description	: JaxRs测试客户端
     * @param args
     */
    public static void main(String[] args) {
    	//HttpPost post = new HttpPost("http://localhost:8080/rental/services/contract/signConstract");
    	HttpPost post = new HttpPost("http://121.40.71.48:8080/rental/services/contract/signConstract");
    	//HttpPost post = new HttpPost("http://localhost:8080/rental/services/contract/sign");
    	//HttpPost post = new HttpPost("http://localhost:8080/rental/services/contract/view");
    	
    	//HttpPost post = new HttpPost("http://121.40.71.48:8080/rental/services/contract/signConstract");
    	//HttpPost post = new HttpPost("http://192.157.220.203:8080/rental/services/contract/signConstract");
    	
    	//HttpPost post = new HttpPost("http://120.26.115.220:8080/rental/services/contract/uploadAndSend");
    	//HttpPost post = new HttpPost("http://120.26.115.220:8080/rental/services/contract/sign");
    	//HttpPost post = new HttpPost("http://120.26.115.220:8080/rental/services/contract/view");
		HttpClient client = new DefaultHttpClient();
		List<NameValuePair> params = new ArrayList<NameValuePair>();  
		//String auth = "{\"uid\":\"47\",\"platform\":\"\",\"version\":\"\",\"token\":\"6f5b66620f59f2a6bdd8acba858f07a6\",\"packageName\":\"\"}";
		//String auth = "{\"uid\":\"48\",\"platform\":\"\",\"version\":\"\",\"token\":\"8d5239e2d4c4da6777705c7d0f9e0449\",\"packageName\":\"\"}";
		String auth = "{\"uid\":\"58\",\"platform\":\"\",\"version\":\"\",\"token\":\"c515371ab15927a53a90b99864a100c6\",\"packageName\":\"\"}";
		/*
		 * constractType=2
		 * &
		 * roomid=43
		 * &
		 * auth={"uid":"58","platform":"","packageName":"","token":"c515371ab15927a53a90b99864a100c6","version":""}
		 * &
		 * tenantid=58
		 * */
		String tenantid = "58";
		String constractType = "1";
		String roomid="43";
        params.add(new BasicNameValuePair("tenantid", tenantid));
        params.add(new BasicNameValuePair("roomid", roomid));
        params.add(new BasicNameValuePair("constractType", constractType));
		params.add(new BasicNameValuePair("auth", auth));
//		params.add(new BasicNameValuePair("contractno", "contract000700212"));
		params.add(new BasicNameValuePair("auth", auth));
		
		/*
		//上传合同
		params.add(new BasicNameValuePair("contractno", "contract001000043"));
		params.add(new BasicNameValuePair("auth", auth));*/
			
		UrlEncodedFormEntity formentity;
		try {
			formentity = new UrlEncodedFormEntity(params, "utf-8");
			post.setEntity(formentity);
			
			client.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, CoreConstants.REQUESTTIMEOUTINMILLIS);
			HttpResponse status = client.execute( post ); 
			System.out.println(status.getStatusLine().getStatusCode());
            if ( status.getStatusLine().getStatusCode() == 200 ) {  
            	boolean flag = true;
            	
            	HttpEntity entity = status.getEntity();  
            	InputStream in = entity.getContent();
            	if( in != null){
	            	int l = -1;  
	                byte[] tmp = new byte[1024];  
	                while ((l = in.read(tmp)) != -1) {  
	                	System.out.println( new String(tmp, 0, l) );
	                } 
	                
            	}
            }  
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
    }
  
  }
