package com.ssqian.signature.demo;

import java.io.File;
import java.util.HashMap;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.util.Iterator;

public class MapContract {

	public static HashMap<String, Contractpar> getmap(String path) {
		HashMap mappare = new HashMap<String, Contractpar>();
		int index = 1;
		String xmlDoc = "<List><Contractpar><MID></MID><uploadfilepar></uploadfilepar><filenamepar></filenamepar><emailpar></emailpar><needvideopar></needvideopar><namepar></namepar><mobilepar></mobilepar><emailtitlepar></emailtitlepar><emailcontentpar></emailcontentpar><sxdayspar></sxdayspar><selfsignpar></selfsignpar><PRIVATEKEY></PRIVATEKEY></Contractpar></List>";
		Document doc = null;
	
		
		path=path+File.separator+"WEB-INF\\conf"+File.separator+"contractpare.xml";
		try {
			
			SAXReader saxReader=new SAXReader();
			
			doc=saxReader.read(new File(path));
			//doc = DocumentHelper.parseText(xmlDoc);
			Element rootElt = doc.getRootElement(); // 获取根节点
			Iterator iter = rootElt.elementIterator("Contractpar"); // 获取根节点下的子节点head
			// 遍历head节点
			while (iter.hasNext()) {
				Element recordEle = (Element) iter.next();
				Contractpar contractpar = new Contractpar();
				contractpar.setMID(recordEle.elementTextTrim("MID"));
				contractpar.setUploadfilepar(recordEle
						.elementTextTrim("uploadfilepar"));
				contractpar.setFilenamepar(recordEle
						.elementTextTrim("filenamepar"));
				contractpar.setEmailpar(recordEle.elementTextTrim("emailpar"));
				contractpar.setNeedvideopar(recordEle
						.elementTextTrim("needvideopar"));
				contractpar.setNamepar(recordEle.elementTextTrim("namepar"));
				contractpar
						.setMobilepar(recordEle.elementTextTrim("mobilepar"));
				contractpar.setEmailtitlepar(recordEle
						.elementTextTrim("emailtitlepar"));
				contractpar.setEmailcontentpar(recordEle
						.elementTextTrim("emailcontentpar"));
				contractpar
						.setSxdayspar(recordEle.elementTextTrim("sxdayspar"));
				contractpar.setSelfsignpar(recordEle
						.elementTextTrim("selfsignpar"));
				contractpar.setPRIVATEKEY(recordEle
						.elementTextTrim("PRIVATEKEY"));

				mappare.put(""+index++, contractpar);

			}

		} catch (DocumentException e) {
			e.printStackTrace();

		}

		return mappare;
	}

	public static void main(String aro[]){
		
		
		
		
	}
	
	
	
}
