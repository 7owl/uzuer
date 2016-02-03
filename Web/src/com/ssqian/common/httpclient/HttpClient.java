/**
 * HttpClient.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2011
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on Sep 5, 2011 9:45:51 AM
 * @author lijianhang
 * @version 1.0
 */

package com.ssqian.common.httpclient;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.Map;

import org.apache.http.Header;
import org.apache.http.HttpException;
import org.apache.http.client.ClientProtocolException;

public interface HttpClient {

	public void setUrl(String urlStr) throws MalformedURLException;

	public void setHttpVersion(String httpVersion);

	public void setHttpContentCharset(String encoding);

	public void setRequestTimeoutInMillis(int requestTimeoutInMillis);

	public void setHttpMethod(String httpMethod) throws HttpException;

	public void addHeader(String name, String value);

	public void addHeaderObj(Map<String, Object> header_data);

	public void setEntity(String content, String contentType, String charset) throws IOException;

	public void setEntity(String fileName) throws IOException;

	public void execute() throws ClientProtocolException, IOException;

	public String getStatusLine();

	public int getStatusCode();

	public String getContentType();

	public Header[] getAllHeaders();

	public String getContentStr() throws IOException;

	public void abortExecution();

	public void shutdown();

}
