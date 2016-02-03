package com.ssqian.signature.open.action.template;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.util.WebUtils;
import com.ssqian.signature.util.SignUtil;

public class SimpleClient {

	
    public static String Utf8URLencode(String text) {
        StringBuffer result = new StringBuffer();
        for (int i = 0; i < text.length(); i++) {
        char c = text.charAt(i);
        if (c >= 0 && c <= 255) {
        result.append(c);
        }else {
        byte[] b = new byte[0];
        try {
        b = Character.toString(c).getBytes("UTF-8");
        }catch (Exception ex) {
        }
        for (int j = 0; j < b.length; j++) {
        int k = b[j];
        if (k < 0) k += 256;
        result.append("%" + Integer.toHexString(k).toUpperCase());
        }
        }
        }
        return result.toString();
        }
	public static void main(String[] args) throws IOException {
		String action = "getSignPagemobile.json";
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);

		String sign = null;

		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println(sign);
	    String s1 = sign.replace('+','*');
		//sign = new String(sign.getBytes(CoreConstants.CHARSET_ENCODING), CoreConstants.CHARSET_ENCODING);
		
		System.out.println(s1);
		String url = "http://localhost:8080/api/getSignPagemobile.json?fsid=1427348791528SXG72&email=252089721@qq.com&mid=E0000000000000000009&sign="
				+ s1;
		
		
		
		HttpClient client = new DefaultHttpClient();
		HttpGet request = new HttpGet(url);

		HttpResponse response = client.execute(request);
		System.out.println("Response Code: "
				+ response.getStatusLine().getStatusCode());

		BufferedReader rd = new BufferedReader(new InputStreamReader(response
				.getEntity().getContent()));
		String line = "";
		while ((line = rd.readLine()) != null) {
			System.out.println(line);
		}

	}
}