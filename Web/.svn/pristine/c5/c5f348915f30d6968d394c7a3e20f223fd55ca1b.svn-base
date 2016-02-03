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

import com.google.gson.Gson;
import com.lingtong.model.Tenants;
import com.lingtong.model.Unlock;
import com.ssqian.common.constant.CoreConstants;

public class TestUnlock {

	/**
	 * @MethodName : main
	 * @Description : JaxRs测试客户端
	 * @param args
	 */
	public static void main2(String[] args) {
		HttpPost post = new HttpPost(
				"http://localhost:8080/rental/services/unlock/create");
		// HttpPost post = new
		// HttpPost("http://localhost:8080/rental/services/contract/uploadAndSend");
		// HttpPost post = new
		// HttpPost("http://localhost:8080/rental/services/contract/sign");
		// HttpPost post = new
		// HttpPost("http://localhost:8080/rental/services/contract/view");

		// HttpPost post = new
		// HttpPost("http://120.26.115.220:8080/rental/services/unlock/create");
		// HttpPost post = new
		// HttpPost("http://120.26.115.220:8080/rental/services/contract/sign");
		// HttpPost post = new
		// HttpPost("http://120.26.115.220:8080/rental/services/contract/view");
		HttpClient client = new DefaultHttpClient();
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		// String auth =
		// "{\"uid\":\"47\",\"platform\":\"\",\"version\":\"\",\"token\":\"6f5b66620f59f2a6bdd8acba858f07a6\",\"packageName\":\"\"}";
		String auth = "{\"uid\":\"58\",\"platform\":\"\",\"version\":\"\",\"token\":\"44a334c484474425200608b9d6f72279\",\"packageName\":\"\"}";

		/*
		 * String tenantid = "48" ; String constractType = "1"; String roomid =
		 * "7"; params.add(new BasicNameValuePair("tenantid", tenantid));
		 * params.add(new BasicNameValuePair("roomid", roomid)); params.add(new
		 * BasicNameValuePair("constractType", constractType)); params.add(new
		 * BasicNameValuePair("auth", auth));
		 */

		Unlock unlock = new Unlock();
		unlock.setKid(1234561);
		unlock.setAdminKeyboardPs("AdminKeyboardPs");
		unlock.setAdminKeyboardPsTmp("AdminKeyboardPsTmp");
		unlock.setAseKey("asekey");
		unlock.setDate(100d);
		unlock.setDay10mPsIndex(10);
		unlock.setDay1PsIndex(1);
		unlock.setDay2PsIndex(2);
		unlock.setDay3PsIndex(3);
		unlock.setDay4PsIndex(4);
		unlock.setDay5PsIndex(5);
		unlock.setDay6PsIndex(6);
		unlock.setDay7PsIndex(7);
		unlock.setDeletePs("deleteps");
		unlock.setDeletePsTmp("deletePsTmp");
		unlock.setDesc1("desc1");
		unlock.setDoorName("doorName");
		unlock.setEndDate(12d);
		unlock.setVersion("version");
		unlock.setUsername("username");
		unlock.setUnlockFlag(0);
		unlock.setStartDate(2d);
		unlock.setRoomid(3106);
		unlock.setPassword("password");
		unlock.setMac("12");
		unlock.setLockName("lockName");
		unlock.setLockmac("lockmac");

		

		unlock.setIsShared(0);
		unlock.setIsAdmin(1);
		unlock.setHasbackup(1);
		unlock.setUz_room_seq("uz000600300017");
		unlock.setKey("key");

		System.out.println(new Gson().toJson(unlock));
		// params.add(new BasicNameValuePair("unlock", new
		// Gson().toJson(unlock)));
		params.add(new BasicNameValuePair("kid", 3234567 + ""));
		params.add(new BasicNameValuePair("auth", auth));

		UrlEncodedFormEntity formentity;
		try {
			formentity = new UrlEncodedFormEntity(params, "utf-8");
			post.setEntity(formentity);

			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT,
					CoreConstants.REQUESTTIMEOUTINMILLIS);
			HttpResponse status = client.execute(post);
			System.out.println(status.getStatusLine().getStatusCode());
			if (status.getStatusLine().getStatusCode() == 200) {
				boolean flag = true;

				HttpEntity entity = status.getEntity();
				InputStream in = entity.getContent();
				if (in != null) {
					int l = -1;
					byte[] tmp = new byte[1024];
					while ((l = in.read(tmp)) != -1) {
						System.out.println(new String(tmp, 0, l));
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

	public static void main(String[] args) {
		HttpPost post = new HttpPost(
				"http://localhost:8080/rental/services/unlock/create");
		// HttpPost post = new
		// HttpPost("http://localhost:8080/rental/services/contract/uploadAndSend");
		// HttpPost post = new
		// HttpPost("http://localhost:8080/rental/services/contract/sign");
		// HttpPost post = new
		// HttpPost("http://localhost:8080/rental/services/contract/view");

		
		/*HttpPost post = new
		HttpPost("http://120.26.115.220:8080/rental/services/unlock/create");*/
		 
		// HttpPost post = new
		// HttpPost("http://120.26.115.220:8080/rental/services/contract/sign");
		// HttpPost post = new
		// HttpPost("http://120.26.115.220:8080/rental/services/contract/view");
		HttpClient client = new DefaultHttpClient();
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("kid", 32345673 + ""));
		params.add(new BasicNameValuePair("adminKeyboardPs", "AdminKeyboardPs"));
		params.add(new BasicNameValuePair("adminKeyboardPsTmp",
				"AdminKeyboardPsTmp"));//无
		params.add(new BasicNameValuePair("aseKey", "1Vx54QvGkCydaq2+MpdvrQ=="));//无
		params.add(new BasicNameValuePair("date", 100 + ""));
		params.add(new BasicNameValuePair("day10mPsIndex", 10 + ""));
		params.add(new BasicNameValuePair("day1PsIndex", "1"));
		params.add(new BasicNameValuePair("day2PsIndex", "2"));
		params.add(new BasicNameValuePair("day3PsIndex", "3"));
		params.add(new BasicNameValuePair("day4PsIndex", "4"));
		params.add(new BasicNameValuePair("day5PsIndex", "5"));
		params.add(new BasicNameValuePair("day6PsIndex", "6"));
		params.add(new BasicNameValuePair("day7PsIndex", "7"));
		params.add(new BasicNameValuePair("deletePs", "deleteps"));//无
		params.add(new BasicNameValuePair("deletePsTmp", "deletePsTmp"));
		params.add(new BasicNameValuePair("desc1", "desc1"));
		params.add(new BasicNameValuePair("doorName", "doorName"));
		params.add(new BasicNameValuePair("endDate", "12"));
		params.add(new BasicNameValuePair("version", "5.4.260.0.0"));
		params.add(new BasicNameValuePair("username", "username"));
		params.add(new BasicNameValuePair("unlockFlag", "0"));
		params.add(new BasicNameValuePair("startDate", "2"));
		params.add(new BasicNameValuePair("roomid", "3107"));
		params.add(new BasicNameValuePair("password", "password"));
		params.add(new BasicNameValuePair("mac", "12"));
		params.add(new BasicNameValuePair("lockName", "5.4.260.0.0"));
		params.add(new BasicNameValuePair("lockmac", "lockmac"));
		params.add(new BasicNameValuePair("isShared", "0"));
		params.add(new BasicNameValuePair("isAdmin", "1"));
		params.add(new BasicNameValuePair("hasbackup", "1"));
		params.add(new BasicNameValuePair("uz_room_seq", "uz000600100007"));
		params.add(new BasicNameValuePair("key", "key"));
		// params.add(new BasicNameValuePair("auth", auth));

		UrlEncodedFormEntity formentity;
		try {
			formentity = new UrlEncodedFormEntity(params, "utf-8");
			post.setEntity(formentity);

			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT,
					CoreConstants.REQUESTTIMEOUTINMILLIS);
			HttpResponse status = client.execute(post);
			System.out.println(status.getStatusLine().getStatusCode());
			if (status.getStatusLine().getStatusCode() == 200) {
				boolean flag = true;

				HttpEntity entity = status.getEntity();
				InputStream in = entity.getContent();
				if (in != null) {
					int l = -1;
					byte[] tmp = new byte[1024];
					while ((l = in.read(tmp)) != -1) {
						System.out.println(new String(tmp, 0, l));
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

	public static void main1(String[] args) {
		/*HttpPost post = new HttpPost(
				"http://localhost:8080/rental/services/unlock/getLockAndKey");*/
		
		HttpPost post = new HttpPost(
				"http://192.157.220.203:8080/rental/services/unlock/getLockAndKey");
		HttpClient client = new DefaultHttpClient();
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("tenantid", 58 + ""));
		UrlEncodedFormEntity formentity;
		try {
			formentity = new UrlEncodedFormEntity(params, "utf-8");
			post.setEntity(formentity);

			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT,
					CoreConstants.REQUESTTIMEOUTINMILLIS);
			HttpResponse status = client.execute(post);
			System.out.println(status.getStatusLine().getStatusCode());
			if (status.getStatusLine().getStatusCode() == 200) {
				boolean flag = true;

				HttpEntity entity = status.getEntity();
				InputStream in = entity.getContent();
				if (in != null) {
					int l = -1;
					byte[] tmp = new byte[1024];
					while ((l = in.read(tmp)) != -1) {
						System.out.println(new String(tmp, 0, l));
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
