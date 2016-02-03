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


public class TestRoom {
	  
    /** @MethodName	: main
     * @Description	: JaxRs测试客户端
     * @param args
     */
    public static void main(String[] args) {
    	HttpPost post = new HttpPost("http://192.157.220.203:8080/rental/services/room/getFeaturedList");
    	//HttpPost post = new HttpPost("http://localhost:8080/rental/services/room/getFeaturedList");
    	//HttpPost post = new HttpPost("http://120.26.115.220:8080/rental/services/room/getRoomList");
    	//HttpPost post = new HttpPost("http://localhost:8080/rental/services/room/getRoomList");
    	//HttpPost post = new HttpPost("http://localhost:8080/rental/services/room/getRoomDetail");
    	//HttpPost post = new HttpPost("http://120.26.115.220:8080/rental/services/room/getRoomDetail");
    	
		HttpClient client = new DefaultHttpClient();
		
		List<NameValuePair> params = new ArrayList<NameValuePair>();  
		String auth = "{\"uid\":\"62\",\"platform\":\"\",\"version\":\"\",\"token\":\"0ac0893aaf82c17b0cb73965a76d00cc\",\"packageName\":\"\"}";
		//params.add(new BasicNameValuePair("version", "1.0"));
        //params.add(new BasicNameValuePair("platform", "android"));
		params.add(new BasicNameValuePair("auth", auth));
		/*************************房源推荐开始******************************/
		params.add(new BasicNameValuePair("cityid", "杭州"));
		/*************************房源推荐结束******************************/
		
		/*************************房源筛选开始******************************/
		//String pageStr = "{\"curPage\":4,\"rows\":5,\"filter\":{},\"sort\":{\"createtime\":\"1\",\"distance\":\"1\",\"price\":\"0\",\"size\":\"1\"}}";
		/*String pageStr = "{\"curPage\":0,\"rows\":5,\"filter\":{},\"sort\":{\"size\":\"0\"}}";
		params.add(new BasicNameValuePair("page", pageStr));
		params.add(new BasicNameValuePair("cityid", "杭州"));
		params.add(new BasicNameValuePair("comm_name", ""));*/
		/*************************房源筛选开始******************************/
		
		/*************************房源详情开始******************************/
		//params.add(new BasicNameValuePair("roomid", "24"));
		/*************************房源详情结束******************************/
        
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
