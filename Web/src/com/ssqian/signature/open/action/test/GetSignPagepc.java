package com.ssqian.signature.open.action.test;

import java.io.IOException;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;
public class GetSignPagepc {//（甲方指定位置，不生成默认签名，不允许乙方拖动）
	public static void excute() throws IOException {//指定位置，生成默认图片		
		String action = "getSignPageSignimagePc.json";
		String pagenum="1";
		String signx="0.5";
		String signy="0.6";
		String typedevice="1";
		String returnurl="http://www.baidu.com";
		
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + "1435837072772F9FG2");
		signdata.append(CoreConstants.SIGN_SPLITSTR + "18698237444@nomail.visual");
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
		sign=java.net.URLEncoder.encode(sign);
		
//		String url = "https://www.ssqsign.com/openpage2/getSignPageSignimagePc.json?fsid=1434532428129HPNL2&pagenum="+pagenum+"&signx="+signx+"&signy="+signy+"&typedevice="+typedevice+"&returnurl="+returnurl+"&email=liwxyxz@163.com&mid=E0000000000000000009&sign="
//				+ sign;
		
		String url = "http://192.168.1.112:8080/openpage2lhp/getSignPageSignimagePc.json?fsid=1435837072772F9FG2&pagenum="+pagenum+"&signx="+signx+"&signy="+signy+"&typedevice="+typedevice+"&returnurl="+returnurl+"&email=18698237444@nomail.visual&mid=E0000000000000000009&sign="
				+ sign;
//		String url = "http://192.168.30.193:8080/openpage/getSignPageSignimagePc.json?fsid=143531998756389SQ2&pagenum="+pagenum+"&signx="+signx+"&signy="+signy+"&email=liwxyx@163.com&mid=E0000000000000000009&sign="
//			+ sign;
		System.out.println(url);
	}

	public static void main(String[] args) throws IOException {
		excute();
	}
}