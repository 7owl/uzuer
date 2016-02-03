/**
 * SignUtil.java
 *
 * @Title:
 * @Description:
 * @Copyright:��������ǩ����Ƽ����޹�˾ Copyright (c) 2011
 * @Company:��������ǩ����Ƽ����޹�˾
 * @Created on 2014-10-30 ����3:22:29
 * @author lijianhang
 * @version 1.0
 */

/**
 * 
 */
package com.ssqian.signature.util;

import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;
import com.ssqian.common.constant.CoreConstants;

/**
 * @author lijianhang
 *
 */
public final class SignUtil {

	public static String sign(String content) throws Exception {

		try {
			
			
			
			String signtmp="";
			System.out.println(CoreConstants.PRIVATEKEY);
			signtmp= AlipaySignature.rsaSign(content, CoreConstants.PRIVATEKEY, CoreConstants.CHARSET_ENCODING);
			
//			boolean flag = AlipaySignature.rsaCheckContent(content, signtmp,
//					CoreConstants.publickey, "UTF-8");
			
			return signtmp;
		} catch (AlipayApiException e) {
			
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}

	public static String decrypt(String content) throws Exception {

		try {
			return AlipaySignature.rsaDecrypt(content, CoreConstants.PRIVATEKEY, CoreConstants.CHARSET_ENCODING);
		} catch (AlipayApiException e) {
			throw new Exception(e.getMessage());
		}
	}

}
