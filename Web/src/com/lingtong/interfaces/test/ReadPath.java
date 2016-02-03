package com.lingtong.interfaces.test;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class ReadPath {
	private static ReadPath readPath;
	
	private ReadPath(){}
	
	public static ReadPath getIntance(){
		if(readPath == null){
			readPath = new ReadPath();
		}
		return readPath;
	}
	
	public String getServerAndPort(){
		SAXReader reader = new SAXReader();
		Document document = null;
		try {
			document = reader.read(this.getClass().getClassLoader().getResourceAsStream("/com/lingtong/interfaces/test/path.xml"));
			Element root = document.getRootElement();
			Element server = root.element("server");
			Element port = root.element("port");
			String url = "http://" + server.getTextTrim() + ":" + port.getTextTrim() + "/";
			return url;
		} catch (DocumentException e) {
			e.printStackTrace();
			return "";
		}
	}
	
	public String getAuth(){
		SAXReader reader = new SAXReader();
		Document document = null;
		try {
			document = reader.read(this.getClass().getClassLoader().getResourceAsStream("com/lingtong/interfaces/test/path.xml"));
			Element root = document.getRootElement();
			Element auth = root.element("auth");
			return auth.getTextTrim();
		} catch (DocumentException e) {
			e.printStackTrace();
			return "";
		}
	}
}	
