/**
 * WebUtils.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2011
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on 2011-9-16 下午01:46:12
 * @author lijianhang
 * @version 1.0
 */

package com.ssqian.common.util;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;

import com.ssqian.common.constant.CoreConstants;

public class WebUtils {

    public static boolean isEmpty(String str) {

    	return str == null || str.trim().length() == 0;
    }

    public static boolean isNotEmpty(String str) {

    	return str != null && str.trim().length() > 0;
    }

    public static String nullToStrTrim(String str) {

    	if (str == null) {
        	str = "";
        }

        return str.trim();
    }

	public static String encode(String str) {

		String strEncode = "";

		try {
			strEncode = URLEncoder.encode(str, CoreConstants.CHARSET_ENCODING);
		} catch (UnsupportedEncodingException e) {
		}

		return strEncode;
	}

	public static String decode(String str) {

		String strDecode = "";

		try {
			if (str != null)
				strDecode = URLDecoder.decode(str, CoreConstants.CHARSET_ENCODING);
		} catch (UnsupportedEncodingException e) {
		}

		return strDecode;
	}

	@SuppressWarnings("rawtypes")
	public static FileItem getFileItem(HttpServletRequest request) {

    	Iterator iterator = new UploadUtils(request).getIterator(104857600, 1073741824);
    	if (iterator == null) {
    		return null;
    	}

    	while (iterator.hasNext()) {
    		FileItem fileItem = (FileItem) iterator.next();

			if (!fileItem.isFormField()) {
				return fileItem;
			}
    	}

    	return null;
    }

	public static String getTempfile(HttpServletRequest request) {

		return request.getSession().getServletContext().getRealPath("") + File.separator + "WEB-INF" + File.separator 
					+ "temp" + File.separator + UUID.randomUUID().toString() + ".data";
	}

	public static boolean upload(FileItem fileItem, String fileName) {

		File file = new File(fileName);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}

		try {
			fileItem.write(file);
		} catch (Exception e) {
			return false;
		}

		return true;
	}

	public static boolean deleteFile(String filename) {

		File file = new File(filename);

		if (file.exists()) {
			return file.delete();
		}

		return true;
	}

	public static Map<String, String> strToMap(String str) {

		Map<String, String> map = new HashMap<String, String>();

		String[] strs = str.split("&");
		for (String s : strs) {
			String[] ss = s.split("=", 2);
			map.put(ss[0], ss[1]);
		}

		return map;
	}

}
