/**
 * MD5Utils.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2011
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on Sep 5, 2011 2:50:35 PM
 * @author lijianhang
 * @version 1.0
 */

package com.ssqian.common.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;

public class MD5Utils {

	private static final String ALGORITHM = "MD5";
	private static final String CHARSET = "UTF-8";
	private static final int BUFFERSIZE = 8192;

	public static String md5(String input) {

		try {
			MessageDigest md5 = MessageDigest.getInstance(ALGORITHM);

			byte[] md5Bytes = md5.digest(input.getBytes(CHARSET));
			return byte2hex(md5Bytes);
		} catch (Exception e) {
			System.err.println(e.getMessage());
			return input;
		}
	}

	private static String byte2hex(byte[] b) {

		String str = "";
		String stmp = "";

		int length = b.length;

		for (int n = 0; n < length; n++) {
			stmp = (Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1) {
				str = str + "0" + stmp;
			} else {
				str = str + stmp;
			}
			if (n < length - 1) {
				str = str + "";
			}
		}

		return str.toLowerCase();
	}

	public static String md5File(String filename) {

		try {
			return md5(new FileInputStream(filename));
		} catch (FileNotFoundException e) {
//			log.error(e.getMessage());
			return "";
//			return null;
		}
	}

	public static String md5(InputStream inputStream) {

		BufferedInputStream bufferedInputStream = null;

		MessageDigest md = null;

		try {
			byte[] buffer = new byte[BUFFERSIZE];
			int i = 0;

			bufferedInputStream = new BufferedInputStream(inputStream, BUFFERSIZE);

			md = MessageDigest.getInstance(ALGORITHM);

			while ((i = bufferedInputStream.read(buffer)) != -1) { // >0
				md.update(buffer, 0, i);
			}

			buffer = null;

			byte[] md5Bytes = md.digest();
			return byte2hex(md5Bytes);
		} catch (Exception e) {
			System.err.println(e.getMessage());
			return "";
		} finally {
			if (bufferedInputStream != null) {
				try {
					bufferedInputStream.close();
				} catch (IOException e) {
					System.err.println(e.getMessage());
				}
				bufferedInputStream = null;
			}
		}
	}

}
