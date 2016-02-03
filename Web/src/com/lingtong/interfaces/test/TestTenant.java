package com.lingtong.interfaces.test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;


import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.ContentBody;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.protocol.HTTP;

import com.google.gson.Gson;
import com.lingtong.model.Tenants;


public class TestTenant {
	  
    /** @MethodName	: main
     * @Description	: JaxRs测试客户端
     * @param args
     */
    public static void main(String[] args) {
		//idPicture();
    	edit();
    	//getTenantDetail();
    	//save();
    }
    
    public static void idPicture(){//测试身份证件照上传的接口
    	//HttpPost post = new HttpPost("http://localhost:8080/rental/services/tenant/authentication");
    	//HttpPost post = new HttpPost("http://120.26.115.220:8080/rental/services/tenant/authentication");
    	HttpPost post = new HttpPost("http://121.40.71.48:8080/rental/services/tenant/authentication");
    	MultipartEntity entity = new MultipartEntity();
    	try {
    		//String auth = "{\"uid\":\"58\",\"platform\":\"\",\"version\":\"\",\"token\":\"1d36757ed4a341be633d6fcc68840770\",\"packageName\":\"\"}";
    		//String tenant = "{\"id\":58,\"id_card_valid\":\"111111111111111111\",\"full_name_valid\":\"马涛涛\"}";
    		
    		String auth = "{\"uid\":\"71\",\"platform\":\"\",\"version\":\"\",\"token\":\"c65b32f541ce0fbaa760d48056c893f9\",\"packageName\":\"\"}";
    		String tenant = "{\"id\":71,\"id_card_valid\":\"111111111111111111\",\"full_name_valid\":\"mtt\"}";
    		
    		StringBody stringBody = new StringBody( auth );
    		String tenantid = "71";
    		StringBody tenantidBody = new StringBody( tenantid );
    		//entity.addPart("imageFile", new StringBody(""));
    		entity.addPart("imageFile1", new FileBody(new File("D://test.jpg"), "image/jpeg"));
    		entity.addPart("imageFile2", new FileBody(new File("D://plane.jpg"), "image/jpeg"));
    		entity.addPart("imageFile3", new FileBody(new File("D://1.png"), "image/jpeg"));
    		/*entity.addPart("imageFile1", new StringBody(""));
    		entity.addPart("imageFile2", new StringBody(""));
    		entity.addPart("imageFile3", new StringBody(""));*/
    		entity.addPart("auth", stringBody );
    		//entity.addPart("tenantid", tenantidBody );
    		entity.addPart("tenant", new StringBody( tenant,Charset.forName("UTF-8") ) );
    		post.setEntity(entity);
    		//entity.writeTo(new FileOutputStream(new File("D://hello.txt")));
    		//System.out.println(entity.getContentEncoding());
			doPost( post );
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (UnsupportedOperationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    public static void save(){//测试房客注册和登录
    	//HttpPost post = new HttpPost("http://121.40.71.48:8080/rental/services/tenant/save");
    	//HttpPost post = new HttpPost("http://120.26.115.220:8080/rental/services/tenant/save");
    	HttpPost post = new HttpPost("http://localhost:8080/rental/services/tenant/save");
    	List<NameValuePair> params = new ArrayList<NameValuePair>();
    	
    	UrlEncodedFormEntity formentity;
    	try {
    		//params.add(new BasicNameValuePair("tel_number", "18368190120"));
	        params.add(new BasicNameValuePair("smsCode", "837432")); 
			params.add(new BasicNameValuePair("tel_number", "18458195521"));
			
			formentity = new UrlEncodedFormEntity(params, "utf-8");
			post.setEntity(formentity);
			doPost( post );
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
    }
    
    public static void edit(){//房客信息修改
    	HttpPost post = new HttpPost("http://localhost:8080/rental/services/tenant/edit");
    	//HttpPost post = new HttpPost("http://192.157.220.203:8080/rental/services/tenant/edit");
    	//HttpPost post = new HttpPost("http://121.40.71.48:8080/rental/services/tenant/edit");
    	List<NameValuePair> params = new ArrayList<NameValuePair>();
    	
    	UrlEncodedFormEntity formentity;
    	try {
    		//params.add(new BasicNameValuePair("tel_number", "18368190120"));
    		//String auth = "{\"uid\":\"47\",\"platform\":\"\",\"version\":\"\",\"token\":\"39e0c6dc88a2b3ff7424cb1bd1e50636\",\"packageName\":\"\"}";
    		String auth = "{\"uid\":\"62\",\"platform\":\"\",\"version\":\"\",\"token\":\"7e182b5bd35f699bc7317fd4a046a2b9\",\"packageName\":\"\"}";
    		//String tenant = "{\"id\":62,\"room_id\":null,\"role_id\":null,\"username\":\"'15715800143'\",\"pwd\":null,\"first_name\":\"廖\",\"last_name\":\"侃\",\"tel_number\":\"15715800143\",\"email\":\"zhuhaoqi@gisiinfo.com\",\"id_card\":\"111111111111111111\",\"native_place\":\"第三方\",\"work_unit\":\"是\",\"work_place\":\"啊打发\",\"work_place_number\":\"0000-00000000\",\"token\":\"0ac0893aaf82c17b0cb73965a76d00cc\",\"email_validate\":0}";
    		String tenant = "{\"id\":62,\"room_id\":null,\"role_id\":null,\"username\":\"'15715800143'\",\"pwd\":null,\"first_name\":\"廖\",\"last_name\":\"侃\",\"tel_number\":\"15715800143\",\"email\":\"zhuhaoqi@gisiinfo.com\",\"id_card\":\"111111111111111111\",\"native_place\":\"第三方\",\"work_unit\":\"是\",\"work_place\":\"啊打发\",\"work_place_number\":\"0000-00000000\",\"token\":\"7e182b5bd35f699bc7317fd4a046a2b9\",\"email_validate\":0}";
    		
    		//String auth = "{\"uid\":\"71\",\"platform\":\"\",\"version\":\"\",\"token\":\"c65b32f541ce0fbaa760d48056c893f9\",\"packageName\":\"\"}";
    		//String tenant = "{\"id\":71,\"room_id\":null,\"role_id\":null,\"username\":\"'15215731373'\",\"pwd\":null,\"first_name\":\"廖\",\"last_name\":\"侃\",\"tel_number\":\"15715800143\",\"email\":\"zhuhaoqi@gisiinfo.com\",\"id_card\":\"111111111111111111\",\"native_place\":\"第三方\",\"work_unit\":\"是\",\"work_place\":\"啊打发\",\"work_place_number\":\"0000-00000000\",\"token\":\"0ac0893aaf82c17b0cb73965a76d00cc\",\"email_validate\":0}";
    		params.add(new BasicNameValuePair("tenant", tenant));
    		params.add(new BasicNameValuePair("auth", auth));
			
			formentity = new UrlEncodedFormEntity(params, "utf-8");
			post.setEntity(formentity);
			doPost( post );
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
    }
    
    public static void getTenantDetail(){//房客详情
    	//HttpPost post = new HttpPost("http://localhost:8080/rental/services/tenant/getTenantDetail");
    	//HttpPost post = new HttpPost("http://120.26.115.220:8080/rental/services/tenant/getTenantDetail");
    	HttpPost post = new HttpPost("http://192.157.220.203:8080/rental/services/tenant/getTenantDetail");
    	List<NameValuePair> params = new ArrayList<NameValuePair>();
    	
    	UrlEncodedFormEntity formentity;
    	try {
    		String auth = "{\"uid\":\"58\",\"platform\":\"\",\"version\":\"\",\"token\":\"543b49cdc5c3afe3bfc9042caf094ee6\",\"packageName\":\"\"}";
    		params.add(new BasicNameValuePair("tenantid", "58"));
    		params.add(new BasicNameValuePair("auth", auth));
			
			formentity = new UrlEncodedFormEntity(params, "utf-8");
			post.setEntity(formentity);
			doPost( post );
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
    }
    
    public static void activeEmail(){
    	//HttpGet get = new HttpGet("http://127.0.0.1:8080/rental/services/tenant/activeEmail?tenant=40&token=c341e1301e526d1c64fde66dafd29ec9");
    }
    
    public static void doPost( HttpPost post ){//post请求
    	HttpClient client = new DefaultHttpClient();
		try {
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
    
    
    public static void main2(String[] args) {
		/*Tenants tenant = new Tenants();
		tenant.setId(48);
		tenant.setId_card_valid("111111111111111111");
		tenant.setFull_name_valid("马涛涛");
		System.out.println( new Gson().toJson(tenant) );*/
    	new TestTenant().edit();
	}

}
