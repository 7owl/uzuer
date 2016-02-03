/**
 * UploadUtils.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2011
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on 2014-10-9 下午5:00:55
 * @author lijianhang
 * @version 1.0
 */

/**
 * 
 */
package com.ssqian.common.util;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * @author lijianhang
 *
 */
public class UploadUtils {

	private HttpServletRequest request = null;;

	public UploadUtils(HttpServletRequest request) {

		this.request = request;
	}

	@SuppressWarnings("rawtypes")
	public Iterator getIterator(long fileSizeMax, long sizeMax) {

		return getIteratorDO(fileSizeMax, sizeMax, DiskFileItemFactory.DEFAULT_SIZE_THRESHOLD, "UTF-8");
	}

	@SuppressWarnings("rawtypes")
	private Iterator getIteratorDO(long fileSizeMax, long sizeMax, int sizeThreshold, String encoding) {

		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
		diskFileItemFactory.setSizeThreshold(sizeThreshold);

        ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
        servletFileUpload.setFileSizeMax(fileSizeMax);
        servletFileUpload.setSizeMax(sizeMax);

        if (WebUtils.isNotEmpty(encoding)) {
        	servletFileUpload.setHeaderEncoding(encoding);
        }

        try {
			return servletFileUpload.parseRequest(request).iterator();
		} catch (FileUploadException e) {
		}

		return null;
	}

}
