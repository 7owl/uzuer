/**
 * ContractdocUpload.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2015
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on 2015-1-5 下午5:26:41
 * @author lijianhang
 * @version 1.0
 */

/**
 * 
 */
package com.ssqian.signature.open.action.contract;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.json.JSONObject;

import com.ssqian.common.service.BaseAPIService;
import com.ssqian.common.util.WebUtils;

/**
 * @author lijianhang
 *
 */
public class ContractdocUpload extends BaseAPIService {

	public static JSONObject execute(HttpServletRequest request) {

		String tempfile = WebUtils.getTempfile(request);

		try {
			FileItem fileItem = WebUtils.getFileItem(request);

			if (fileItem == null) {
				return null;
			}

			if (!WebUtils.upload(fileItem, tempfile)) {
				return null;
			}

			action = "contractdocUpload.json";

			uploadfile = tempfile;

			String filename = fileItem.getName();

			upcontent.put("filename", filename);

			subdata = filename;

			return doUPService();
		} catch (Exception e) {
			return null;
		} finally {
			WebUtils.deleteFile(tempfile);
		}
	}

}
