package com.ssqian.signature.open.action.sign;

import java.io.IOException;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;
import  java.net.Socket;
public class GetSignPage {
	public static void excute() throws IOException {
		//String fsid = "1439886484660PLXR2";
		String fsid = "1442500371130DGDC2";
		//String email = "13706532684@nomail.visual";
		String email = "252089721@qq.com";
		String pagenum = "1";
		String signx = "0.5";
		String signy = "0.3";
		String typedevice = "1";
		String returnurl = "http://www.baidu.com";
		String returnadress="http://www.baidu.com";
		String openflagString="1";
		String url = CoreConstants.HOST;
		//int urltype = 7;
		int urltype = 1;//不需要数字证书
		//int signpagetype = 10;
		int signpagetype = 1;
		switch (urltype) {
		case 1:// 普通接口1.2.2
			url = url + "openpage2/";
			break;

		case 2:// 量化派接口
			url = url + "openpage2lhp/";
			break;
		case 3:// 蚂蚁天使接口
			url = url + "openpagemy/";
			break;
		case 4:// 股权通
			url = url + "openpage2gqt/";
			break;
		case 5:// 蚂蚁天使接口
			url = url + "openpageyfy/";
			break;
		case 6:// 证书签名接口
			url = url + "openpagec/";
			break;
		case 7:// 手机贷接口
			url = url + "openpagecsjd/";
			break;
		default:
			break;
		}
		switch (signpagetype) {
		case 1:// （甲方指定位置，不生成默认签名，不允许乙方拖动）1.2
			String action1 = "getSignPageSignimagePc.json";
			getsignurl1(url, action1, fsid, email, pagenum, signx, signy,
					typedevice, returnurl);
			break;

		case 2:// （甲方不指定位置，不生成默认签名，允许乙方拖动）
			String action2 = "getSignPageSignimagePc.json";
			getsignurl2(url, action2, fsid, email, typedevice, returnurl);
			break;

		case 3:// （甲方不指定位置，不生成默认签名，允许乙方拖动）
			String action3 = "getSignPagePc.json";
			getsignurl3(url, action3, fsid, email, typedevice, returnurl);
			break;

		case 4:// （甲方指定位置，生成默认签名，不允许乙方拖动）
			String action4 = "getSignPagePc.json";
			getsignurl4(url, action4, fsid, email, pagenum, signx, signy,
					typedevice, returnurl);
			break;

		case 5:// （甲方指定初始化位置，不生成默认签名，允许乙方拖动）

			String action5 = "getDragSignPageSignimagePc.json";
			getsignurl5(url, action5, fsid, email, pagenum, signx, signy,
					typedevice, returnurl);
			break;
		case 6:
			String action6 = "getDragNoSignPagePc.json";
			getsignurl6(url, action6, fsid, email, pagenum, signx, signy,
					typedevice, returnurl);
			break;

		case 7:// 量化派

			String action7 = "getSignPageSignimagePc.json";
			getsignurl1(url, action7, fsid, email, pagenum, signx, signy,
					typedevice, returnurl);
			break;

		case 8:// 蚂蚁天使

			String action8 = "getSignPageSignimagePc.json";
			getsignurl8(url, action8, fsid, email, pagenum, signx, signy,
					typedevice, returnurl);
			break;
		case 9:// 蚂蚁天使
			String action9 = "getSignPageSignimagePc.json";
			//getsignurl2(url, action9, fsid, email, typedevice, returnurl);
			getsignurl9(url, action9, fsid, email,
					typedevice, returnurl,returnadress);
			break;
		case 10:// （甲方指定位置，不生成默认签名，不允许乙方拖动）手机贷接口
			String action10 = "getSignPageSignimagePc.json";
			getsignurl10(url, action10, fsid, email, pagenum, signx, signy,
					typedevice, returnurl,openflagString);
			break;
		default:
			break;
		}

	}

	public static void getsignurl6(String url, String action, String fsid,
			String email, String pagenum, String signx, String signy,
			String typedevice, String returnurl)

	{
		url = url + action;
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
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
		String geturl = url + "?fsid=" + fsid + "&pagenum=" + pagenum
				+ "&signx=" + signx + "&signy=" + signy + "&typedevice="
				+ typedevice + "&returnurl=" + returnurl + "&email=" + email
				+ "&mid=" + CoreConstants.MID + "&sign=" + sign;
		System.out.println(geturl);

	}

	public static void getsignurl5(String url, String action, String fsid,
			String email, String pagenum, String signx, String signy,
			String typedevice, String returnurl) {// （甲方指定初始化位置，不生成默认签名，允许乙方拖动）
		url = url + action;
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
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
		String geturl = url + "?fsid=" + fsid + "&pagenum=" + pagenum
				+ "&signx=" + signx + "&signy=" + signy + "&typedevice="
				+ typedevice + "&returnurl=" + returnurl + "&email=" + email
				+ "&mid=" + CoreConstants.MID + "&sign=" + sign;
		System.out.println(geturl);

	}

	public static void getsignurl4(String url, String action, String fsid,
			String email, String pagenum, String signx, String signy,
			String typedevice, String returnurl) {
		url = url + action;
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
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
		String geturl = url + "?fsid=" + fsid + "&pagenum=" + pagenum
				+ "&signx=" + signx + "&signy=" + signy + "&typedevice="
				+ typedevice + "&returnurl=" + returnurl + "&email=" + email
				+ "&mid=" + CoreConstants.MID + "&sign=" + sign;
		System.out.println(geturl);

	}

	public static void getsignurl3(String url, String action, String fsid,
			String email, String typedevice, String returnurl) {// （甲方不指定位置，生成默认签名，允许乙方拖动）
		url = url + action;
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
		signdata.append(CoreConstants.SIGN_SPLITSTR + returnurl);
		signdata.append(CoreConstants.SIGN_SPLITSTR + typedevice);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign = java.net.URLEncoder.encode(sign);
		String geturl = url + "?fsid=" + fsid + "&typedevice=" + typedevice
				+ "&returnurl=" + returnurl + "&email=" + email + "&mid="
				+ CoreConstants.MID + "&sign=" + sign;
		System.out.println(geturl);

	}

	public static void getsignurl2(String url, String action, String fsid,
			String email, String typedevice, String returnurl) {// （甲方不指定位置，不生成默认签名，允许乙方拖动）
		url = url + action;
		String sign = null;
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
		signdata.append(CoreConstants.SIGN_SPLITSTR + returnurl);
		signdata.append(CoreConstants.SIGN_SPLITSTR + typedevice);
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign = java.net.URLEncoder.encode(sign);
		String geturl = url + "?fsid=" + fsid + "&typedevice=" + typedevice
				+ "&returnurl=" + returnurl + "&email=" + email + "&mid="
				+ CoreConstants.MID + "&sign=" + sign;
		System.out.println(geturl);

	}
	public static void getsignurl9(String url, String action, String fsid,
			String email, 
			String typedevice, String returnurl,String returnadress) {// （甲方指定位置，不生成默认签名，不允许乙方拖动）蚂蚁天使
		// http://192.168.1.112:8080/openpage2lhp/getSignPageSignimagePc.json
		url = url + action;
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
		signdata.append(CoreConstants.SIGN_SPLITSTR + returnurl);
		signdata.append(CoreConstants.SIGN_SPLITSTR + returnadress);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign = java.net.URLEncoder.encode(sign);
		String geturl = url + "?fsid=" + fsid + "&returnurl=" + returnurl+"&email=" + email +"&returnadress="+returnadress
				+ "&mid=" + CoreConstants.MID + "&sign=" + sign;
		System.out.println(geturl);
	}

	public static void getsignurl8(String url, String action, String fsid,
			String email, String pagenum, String signx, String signy,
			String typedevice, String returnurl) {// （甲方指定位置，不生成默认签名，不允许乙方拖动）蚂蚁天使
		// http://192.168.1.112:8080/openpage2lhp/getSignPageSignimagePc.json
		url = url + action;
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
		signdata.append(CoreConstants.SIGN_SPLITSTR + pagenum);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signx);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signy);
		signdata.append(CoreConstants.SIGN_SPLITSTR + returnurl);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign = java.net.URLEncoder.encode(sign);
		String geturl = url + "?fsid=" + fsid + "&pagenum=" + pagenum
				+ "&signx=" + signx + "&signy=" + signy + "&returnurl=" + returnurl+"&email=" + email
				+ "&mid=" + CoreConstants.MID + "&sign=" + sign;
		System.out.println(geturl);
	}

	public static void getsignurl1(String url, String action, String fsid,
			String email, String pagenum, String signx, String signy,
			String typedevice, String returnurl) {// （甲方指定位置，不生成默认签名，不允许乙方拖动）
		// http://192.168.1.112:8080/openpage2lhp/getSignPageSignimagePc.json
		url = url + action;
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
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
		String geturl = url + "?fsid=" + fsid + "&pagenum=" + pagenum
				+ "&signx=" + signx + "&signy=" + signy + "&typedevice="
				+ typedevice + "&returnurl=" + returnurl + "&email=" + email
				+ "&mid=" + CoreConstants.MID + "&sign=" + sign;
		System.out.println(geturl);
	}
	
	public static void getsignurl10(String url, String action, String fsid,
			String email, String pagenum, String signx, String signy,
			String typedevice, String returnurl,String openflagString ) {// （甲方指定位置，不生成默认签名，不允许乙方拖动）
		// http://192.168.1.112:8080/openpage2lhp/getSignPageSignimagePc.json
		url = url + action;
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + email);
		signdata.append(CoreConstants.SIGN_SPLITSTR + pagenum);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signx);
		signdata.append(CoreConstants.SIGN_SPLITSTR + signy);
		signdata.append(CoreConstants.SIGN_SPLITSTR + returnurl);
		signdata.append(CoreConstants.SIGN_SPLITSTR + typedevice);
		signdata.append(CoreConstants.SIGN_SPLITSTR + openflagString);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign = java.net.URLEncoder.encode(sign);
		String geturl = url + "?fsid=" + fsid + "&pagenum=" + pagenum
				+ "&signx=" + signx + "&signy=" + signy + "&typedevice="
				+ typedevice + "&returnurl=" + returnurl + "&email=" + email+ "&openflagString=" + openflagString
				+ "&mid=" + CoreConstants.MID + "&sign=" + sign;
		System.out.println(geturl);
	}

	public static void main(String[] args) throws IOException {
		excute();
	}
}