package com.lingtong.interfaces.test;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;


import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreConnectionPNames;


public class TestComplain {
	  
    /** @MethodName	: main
     * @Description	: JaxRs测试客户端
     * @param args
     */
    public static void main(String[] args) {
    	HttpPost post = new HttpPost("http://120.26.115.220:8080/rental/services/complain/save");
    	//HttpPost post = new HttpPost("http://localhost:8080/rental/services/complain/save");
		HttpClient client = new DefaultHttpClient();
		
		List<NameValuePair> params = new ArrayList<NameValuePair>();  
		//String auth = "{\"uid\":\"48\",\"platform\":\"\",\"version\":\"\",\"token\":\"e2f715b51539c7fd02a3b5ccf4993649\",\"packageName\":\"\"}";
		String auth = "{\"uid\":\"47\",\"platform\":\"\",\"version\":\"\",\"token\":\"39e0c6dc88a2b3ff7424cb1bd1e50636\",\"packageName\":\"\"}";
		params.add(new BasicNameValuePair("complain", "{\"id\":\"0\", \"content\": \"课外\", \"createtime\":\"\"}"));
		params.add(new BasicNameValuePair("auth", auth));
		
		//params.add(new BasicNameValuePair("tenant", tenant));
		//params.add(new BasicNameValuePair("auth", ""));
		UrlEncodedFormEntity formentity;
		try {
			formentity = new UrlEncodedFormEntity(params, "utf-8");
			post.setEntity(formentity);
			
			client.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, 5000);
			
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
