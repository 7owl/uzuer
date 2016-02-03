package com.lingtong.util;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class SpringManage {
	private static SpringManage springManage;
	private static BeanFactory bf;
	
	private SpringManage(){}
	
	public static SpringManage getInstance(){
		if(springManage == null){
			springManage = new SpringManage();
		}
		
		return springManage;
	}
	
	private void init(){
		
		Resource res = new ClassPathResource("applicationContext.xml");  
		if(bf == null){
			bf = new XmlBeanFactory(res);
		}
	}
	
	public Object getObject(String objName){
		SpringManage.getInstance().init();
		return bf.getBean(objName);
	}
}
