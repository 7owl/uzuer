/**
 * MD5Utils.java
 *
 * @Title:
 * @Description:
 * @Copyright:鏉窞灏氬皻绛剧綉缁滅鎶�湁闄愬叕鍙�Copyright (c) 2014
 * @Company:鏉窞灏氬皻绛剧綉缁滅鎶�湁闄愬叕鍙�
 * @Created on 2014-9-18 涓嬪崍4:08:47
 * @author lijianhang
 * @version 1.0
 */

/**
 * 
 */
package com.ssqian.signature.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;



/**
 * @author lijianhang
 *
 */
public final class MD5Utils {

	private MD5Utils() {
	}

	private static final String ALGORITHM = "MD5";

	public static String md5(String input) {

		try {
			MessageDigest md5 = MessageDigest.getInstance(ALGORITHM);

			byte[] md5Bytes = md5.digest(input.getBytes(APIConstants.UTF_8));
			return StringUtils.byte2hex(md5Bytes);
		} catch (Exception e) {
			return "";
		}
	}

	public static String md5File(String filename) {

		try {
			return md5(new FileInputStream(filename));
		} catch (FileNotFoundException e) {
			return "";
		}
	}

	public static String md5(InputStream inputStream) {

		BufferedInputStream bufferedInputStream = null;

		MessageDigest md = null;

		try {
			byte[] buffer = new byte[10240];
			int i = 0;

			bufferedInputStream = new BufferedInputStream(inputStream, 10240);

			md = MessageDigest.getInstance(ALGORITHM);

			while ((i = bufferedInputStream.read(buffer)) != -1) {
				md.update(buffer, 0, i);
			}

			buffer = null;

			byte[] md5Bytes = md.digest();
			return StringUtils.byte2hex(md5Bytes);
		} catch (Exception e) {
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
