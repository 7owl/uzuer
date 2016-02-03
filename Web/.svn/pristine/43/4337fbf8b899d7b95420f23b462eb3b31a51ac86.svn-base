package com.lingtong.interfaces;

import java.util.Map;

import javax.ws.rs.core.Response;

import com.lingtong.interfaces.interceptor.BmobSmsUtil;
import com.lingtong.interfaces.interceptor.ReturnJSON;

/**
 * @author xqq
 * @date 2015-8-16 上午10:28:08
 * 
 */
public class SmsServiceImpl implements SmsService{

	public Response requestSmsCode(String tel_number) {
		Map<String, Object> result = BmobSmsUtil.getInstance().requestSmsCode(tel_number);
		return ReturnJSON.getInstance().ret(result);
	}
}
