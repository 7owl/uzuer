package com.ssqian.signature.open.action.test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;
import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;

public class GetSignPagepcDrag {

	public static void excute() throws IOException {//（甲方指定初始化位置，不生成默认签名，允许乙方拖动）  getDragNoSignPagePc.json
		String action = "getDragSignPageSignimagePc.json";
		String pagenum="1";
		String signx="0.5";
		String signy="0.5";
		String typedevice="1";
		String returnurl="http://www.baidu.com";
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + "1432031166978ONPQ2");
		signdata.append(CoreConstants.SIGN_SPLITSTR + "362021204@qq.com");
		signdata.append(CoreConstants.SIGN_SPLITSTR + pagenum);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signx);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signy);
		signdata.append(CoreConstants.SIGN_SPLITSTR + returnurl);
		signdata.append(CoreConstants.SIGN_SPLITSTR + typedevice);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign = java.net.URLEncoder.encode(sign);
		String url = "http://192.168.30.193:8080/openpage2/getDragSignPageSignimagePc.json?fsid=1432031166978ONPQ2&pagenum="+pagenum+"&signx="+signx+"&signy="+signy+"&typedevice="+typedevice+"&returnurl="+returnurl+"&email=362021204@qq.com&mid=E0000000000000000009&sign="
				+ sign;
		System.out.println(url);
	}

	public static void main(String[] args) throws IOException {
		excute();
	}
}