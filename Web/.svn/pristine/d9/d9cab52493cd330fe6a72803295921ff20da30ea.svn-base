package com.lingtong.util;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;


/**
 * java bean的工具类
 * */
public class GetParams {
	private static GetParams utils = null;
	
	private GetParams(){}
	
	public static GetParams getInstance(){
		if( utils == null ){
			utils = new GetParams();
		}
		return utils;
	}
	
   public void getParam(HttpServletRequest req, Object obj){
	   if( obj == null ){
		   System.out.println("obj is null, so ...");
		   return;
	   }
       try {
    	   BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());  
           PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors(); 
	       for (PropertyDescriptor property : propertyDescriptors) {  
	           String key = property.getName();  
	           if ( StringUtils.isNotBlank( req.getParameter( key ) ) ) {  
	               Object value = req.getParameter( key );
	               // 得到property对应的setter方法  
	               Method setter = property.getWriteMethod();
	               
					Class clazz = property.getPropertyType();
					if (clazz.equals(Integer.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							setter.invoke(obj,
									Integer.parseInt(String.valueOf(value)));
						}
						// setter.invoke(obj, Integer.parseInt( String.valueOf(
						// value ) ));
					} else if (clazz.equals(Long.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							setter.invoke(obj,
									Long.parseLong(String.valueOf(value)));
						}
						// setter.invoke(obj, Integer.parseInt( String.valueOf(
						// value ) ));
					} else if (clazz.equals(Double.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							setter.invoke(obj,
									Double.parseDouble(String.valueOf(value)));
						}
						// setter.invoke(obj, Integer.parseInt( String.valueOf(
						// value ) ));
					} else if (clazz.equals(Float.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							setter.invoke(obj,
									Float.parseFloat(String.valueOf(value)));
						}
						// setter.invoke(obj, Integer.parseInt( String.valueOf(
						// value ) ));
					} else {
						setter.invoke(obj, value);
					}
	           }  
	       }  
	   } catch (Exception e) {  
	       System.out.println("getParam is error: " + e);  
	   }  
       return ;
   }
}
