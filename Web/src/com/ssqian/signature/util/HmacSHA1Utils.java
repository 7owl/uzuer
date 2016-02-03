/**
 * HmacSHA1Utils.java
 *
 * @Title:
 * @Description:
 * @Copyright:鏉窞灏氬皻绛剧綉缁滅鎶�湁闄愬叕鍙�Copyright (c) 2014
 * @Company:鏉窞灏氬皻绛剧綉缁滅鎶�湁闄愬叕鍙�
 * @Created on 2014-9-18 涓嬪崍3:48:30
 * @author lijianhang
 * @version 1.0
 */

/**
 * 
 */
package com.ssqian.signature.util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;


/**
 * @author lijianhang
 *
 */
public final class HmacSHA1Utils {

	private HmacSHA1Utils() {
	}

	private static final String ALGORITHM = "HmacSHA1";

	public static byte[] signature(String data, String key, String charsetName)
			throws NoSuchAlgorithmException, InvalidKeyException, IllegalStateException, UnsupportedEncodingException {

		SecretKeySpec signingKey = new SecretKeySpec(key.getBytes(charsetName), ALGORITHM);   
        Mac mac = Mac.getInstance(ALGORITHM);
        mac.init(signingKey);

		return mac.doFinal(data.getBytes(charsetName));
	}

	public static String signatureString(String data, String key, String charsetName) 
			throws InvalidKeyException, NoSuchAlgorithmException, IllegalStateException, UnsupportedEncodingException {

		return StringUtils.nullToStrTrim(new String(Base64.encodeBase64(signature(data, key, charsetName)), charsetName));
	}

	public static String signatureString(String data, String key) 
			throws InvalidKeyException, NoSuchAlgorithmException, IllegalStateException, UnsupportedEncodingException {

		return signatureString(data, key, APIConstants.UTF_8);
	}

}
