/**
 * TemplatedocUpload.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2014
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on 2014-11-4 上午11:56:28
 * @author lijianhang
 * @version 1.0
 */

/**
 * 
 */
package com.ssqian.signature.open.action.template;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.json.JSONObject;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;
import com.ssqian.common.util.WebUtils;

/**
 * @author lijianhang
 *
 */
public class TemplatedocUpload extends BaseAPIService {

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

			action = "templatedocUpload.json";

			uploadfile = tempfile;

			String tid = request.getParameter("tid");
			String filename = fileItem.getName();

			upcontent.put("tid", tid);
			upcontent.put("filename", filename);

			subdata = tid + CoreConstants.SIGN_SPLITSTR + filename;

			return doUPService();
		} catch (Exception e) {
			return null;
		} finally {
			WebUtils.deleteFile(tempfile);
		}
	}


}
