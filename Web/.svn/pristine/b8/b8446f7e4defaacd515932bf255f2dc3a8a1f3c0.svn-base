/**
 * HttpClientImpl.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2011
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on Sep 5, 2011 10:17:06 AM
 * @author lijianhang
 * @version 1.0
 */

package com.ssqian.common.httpclient;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.charset.IllegalCharsetNameException;
import java.nio.charset.UnsupportedCharsetException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpEntityEnclosingRequest;
import org.apache.http.HttpException;
import org.apache.http.HttpResponse;
import org.apache.http.ProtocolVersion;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpHead;
import org.apache.http.client.methods.HttpOptions;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpTrace;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.AbstractHttpEntity;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.message.AbstractHttpMessage;
import org.apache.http.message.BasicHeader;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.CoreProtocolPNames;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.wiztools.commons.StreamUtil;

import com.ssqian.common.util.WebUtils;
import com.sun.xml.internal.messaging.saaj.soap.impl.HeaderImpl;

public class HttpClientImpl implements HttpClient {

	private URL url = null;
	private String urlStr = "";

    private DefaultHttpClient httpclient = null;
    private HttpParams httpParams = null;
    private HttpContext httpContext = null;

    private AbstractHttpMessage method = null;

    private HttpResponse http_res = null;

    private boolean interruptedShutdown = false;
    private boolean isRequestCompleted = false;

	public HttpClientImpl(String url) throws Exception {

		if (url.toLowerCase().startsWith("https://")) {
			httpclient = wrapClient();
		} else {
			httpclient = new DefaultHttpClient();
		}
		httpParams = httpclient.getParams();
	}

	public DefaultHttpClient wrapClient() throws Exception {

		SSLContext ctx = SSLContext.getInstance("TLS");
		X509TrustManager tm = new X509TrustManager() {
			public X509Certificate[] getAcceptedIssuers() {
				return null;
			}

			public void checkClientTrusted(X509Certificate[] arg0, String arg1)
					throws CertificateException {
			}

			public void checkServerTrusted(X509Certificate[] arg0, String arg1)
					throws CertificateException {
			}
		};
		ctx.init(null, new TrustManager[] { tm }, null);
		SSLSocketFactory ssf = new SSLSocketFactory(ctx, SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
		SchemeRegistry registry = new SchemeRegistry();
		registry.register(new Scheme("https", 443, ssf));
		ThreadSafeClientConnManager mgr = new ThreadSafeClientConnManager(registry);

		return new DefaultHttpClient(mgr);
	}

	public void setUrl(String urlStr) throws MalformedURLException {

		setUrl(new URL(urlStr));
	}

	private void setUrl(URL url) {

		this.url = url;
		urlStr = url.toString();
	}

	public void setHttpVersion(String httpVersion) {

		ProtocolVersion protocolVersion = httpVersion.equals("1.1") 
				? new ProtocolVersion("HTTP", 1, 1)
				: new ProtocolVersion("HTTP", 1, 0);
		httpParams.setParameter(CoreProtocolPNames.PROTOCOL_VERSION, protocolVersion);
	}

	public void setHttpContentCharset(String encoding) {
		httpParams.setParameter(CoreProtocolPNames.HTTP_CONTENT_CHARSET, encoding);
	}

	public void setRequestTimeoutInMillis(int requestTimeoutInMillis) {
		HttpConnectionParams.setConnectionTimeout(httpParams, requestTimeoutInMillis);
	}

	public void setHttpMethod(String httpMethod) throws HttpException {

		if (httpMethod.equalsIgnoreCase("GET")) {
            method = new HttpGet(urlStr);
        } else if (httpMethod.equalsIgnoreCase("POST")) {
            method = new HttpPost(urlStr);
        } else if (httpMethod.equalsIgnoreCase("PUT")) {
            method = new HttpPut(urlStr);
        } else if (httpMethod.equalsIgnoreCase("DELETE")) {
            method = new HttpDelete(urlStr);
        } else if (httpMethod.equalsIgnoreCase("HEAD")) {
            method = new HttpHead(urlStr);
        } else if (httpMethod.equalsIgnoreCase("OPTIONS")) {
            method = new HttpOptions(urlStr);
        } else if (httpMethod.equalsIgnoreCase("TRACE")) {
            method = new HttpTrace(urlStr);
        } else {
        	throw new HttpException("No httpMethod");
        }
		
		Map<String ,Object> header=new  LinkedHashMap<String, Object>();;
	
		//Header header;
		//header.
//		HeaderImpl
//		method.setHeader(header);
        method.setParams(new BasicHttpParams().setParameter(urlStr, url));
	}

	
	public void addHeader(String name, String value) {

        Header header = new BasicHeader(name, WebUtils.encode(value));
		method.addHeader(header);
	}

	
	public void addHeaderObj(Map<String, Object> header_data) {

		if (header_data != null) {
	        List<String> keys = new ArrayList<String>(header_data.keySet());
			Collections.sort(keys);
			String key = "";
			String value = "";

			for (int i = 0; i < keys.size(); i++) {
				key = keys.get(i);
				value = String.valueOf(header_data.get(key));

	            Header header = new BasicHeader(key, WebUtils.encode(value));
	            method.addHeader(header);
			}
		}
	}

	
	public void setEntity(String content, String contentType, String charset)
			throws IOException {

        if (method instanceof HttpEntityEnclosingRequest) {

            HttpEntityEnclosingRequest eeMethod = (HttpEntityEnclosingRequest) method;

            if (content != null && content.trim().length() > 0) {
                try {
                    AbstractHttpEntity entity = new ByteArrayEntity(content.getBytes(charset));
                    entity.setContentType(getFormattedContentType(contentType, charset));
                    eeMethod.setEntity(entity);

                    EntityUtils.consume(entity);
                } catch (IOException e) {
                    throw new IOException(e.getMessage());
                }
            }
        }
	}

	/**
	 * Method formats content-type and charset for use as HTTP header value
	 * 
	 * @param contentType
	 * @param charset
	 * @return The formatted content-type and charset.
	 */
	private String getFormattedContentType(final String contentType,
			final String charset) {
		String charsetFormatted = WebUtils.isEmpty(charset) ? "" : "; charset=" + charset;
		return contentType + charsetFormatted;
	}

	
	public void setEntity(String fileName) throws IOException {

        if (method instanceof HttpEntityEnclosingRequest) {

            HttpEntityEnclosingRequest eeMethod = (HttpEntityEnclosingRequest) method;

            try {
            	InputStreamEntity inputStreamEntity = new InputStreamEntity(new FileInputStream(fileName), new File(fileName).length());

                eeMethod.setEntity(inputStreamEntity);
            } catch (IOException e) {
                throw new IOException(e.getMessage());
            }
        }
	}

	
	public void execute() throws ClientProtocolException, IOException {

		http_res = httpclient.execute((HttpUriRequest) method, httpContext);
	}


	
	public String getStatusLine() {

		return http_res.getStatusLine().toString();
	}

	
	public int getStatusCode() {

		return http_res.getStatusLine().getStatusCode();
	}

	
	public Header[] getAllHeaders() {

		return http_res.getAllHeaders();
	}

	private Charset getCharset() {

		return getCharset(getContentType());
	}

	private Charset getCharset(String contentType) {

		Charset charset = null;
	
		if (contentType != null && contentType.trim().length() > 0) {
			String charsetStr = getCharsetFromContentType(contentType);
			try {
				charset = Charset.forName(charsetStr);
			} catch (IllegalCharsetNameException ex) {
				charset = Charset.defaultCharset();
			} catch (UnsupportedCharsetException ex) {
				charset = Charset.defaultCharset();
			} catch (IllegalArgumentException ex) {
				charset = Charset.defaultCharset();
			}
		} else {
			charset = Charset.defaultCharset();
		}

		return charset;
	}

	private String getCharsetFromContentType(final String contentType) {
		Pattern p = Pattern.compile("^.+charset=([^;]+).*$");
		Matcher m = p.matcher(contentType);
		if (m.matches()) {
			return m.group(1).trim();
		}
		return null;
	}

	
	public String getContentType() {

		if (http_res.getHeaders("content-type").length > 0)
			return http_res.getHeaders("content-type")[0].getValue();
		else
			return "";
	}

	
	public String getContentStr() throws IOException {

		return getContentStr(getCharset());
	}

	private String getContentStr(Charset charset) throws IOException {

		HttpEntity entity = http_res.getEntity();

		if (entity != null) {
			InputStream is = entity.getContent();
			if (is != null) {
				try {
					return StreamUtil.inputStream2String(is, charset);
				} catch (IOException e) {
					throw new IOException(
							"Response body conversion to string using "
									+ charset.displayName()
									+ " encoding failed. Response body not set!");
				}
			}
		}

		return null;
	}

	
	public void abortExecution() {

		if (!isRequestCompleted) {
			ClientConnectionManager conMgr = httpclient.getConnectionManager();
			conMgr.shutdown();
		}

		interruptedShutdown = true;
	}

	
	public void shutdown() {

		if (!interruptedShutdown) {
			ClientConnectionManager conMgr = httpclient.getConnectionManager();
			conMgr.shutdown();
		}

		isRequestCompleted = true;
	}

}
