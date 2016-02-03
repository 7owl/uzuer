package com.lingtong.interfaces.interceptor;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.apache.cxf.attachment.AttachmentDeserializer;
import org.apache.cxf.interceptor.Fault;
import org.apache.cxf.jaxrs.ext.form.Form;
import org.apache.cxf.message.Message;
import org.apache.cxf.phase.AbstractPhaseInterceptor;
import org.apache.cxf.phase.Phase;

import com.lingtong.model.Tenants;

/**
 * @author xqq
 * @date 2015-8-13 下午9:12:39
 * 
 */
public class AuthInterceptor extends AbstractPhaseInterceptor<Message> {

	/**
	 * @param phase
	 */
	public AuthInterceptor() {
		super(Phase.PRE_INVOKE);
	}

	public void handleMessage(Message msg) throws Fault {
		String contentType = (String) msg.get(Message.CONTENT_TYPE);
		if (contentType != null && contentType.toLowerCase().indexOf("application/x-www-form-urlencoded") != -1) {
		}
		//String request_uri = (String) msg.get(Message.REQUEST_URI);
		//String path_info = (String) msg.get(Message.PATH_INFO);
		
		//System.out.println(request_uri);
		//System.out.println(path_info);
	}

}
