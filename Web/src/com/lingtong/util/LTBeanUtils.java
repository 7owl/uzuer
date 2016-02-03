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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;

import com.lingtong.model.Tenants;

/**
 * java bean的工具类
 * */
public class LTBeanUtils {
	private static LTBeanUtils utils = null;

	private LTBeanUtils() {
	}

	public static LTBeanUtils getInstance() {
		if (utils == null) {
			utils = new LTBeanUtils();
		}
		return utils;
	}
	
	/**
	 * 将Map对象转成Java Bean
	 * @param map
	 * @param obj
	 */
	public void Map2Bean(Map<String, Object> map, Object obj) {
		try {
			BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
			PropertyDescriptor[] propertyDescriptors = beanInfo
					.getPropertyDescriptors();

			for (PropertyDescriptor property : propertyDescriptors) {
				String key = property.getName();
				if (map.containsKey(key)) {
					Object value = map.get(key);
					//System.out.println("key:"+key);
					// System.out.println(key + ":" +
					// property.getPropertyType().getName());
					// 得到property对应的setter方法
					Method setter = property.getWriteMethod();
					Class clazz = property.getPropertyType();
					if (clazz.equals(Integer.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							setter.invoke(obj,
									Integer.parseInt(String.valueOf(value)));
						} else {//设置默认值
							setter.invoke(obj,0);
						}
						// setter.invoke(obj, Integer.parseInt( String.valueOf(
						// value ) ));
					} else if (clazz.equals(Long.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							setter.invoke(obj,
									Long.parseLong(String.valueOf(value)));
						} else {//设置默认值
							setter.invoke(obj,0);
						}
						// setter.invoke(obj, Integer.parseInt( String.valueOf(
						// value ) ));
					} else if (clazz.equals(Double.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							setter.invoke(obj,
									Double.parseDouble(String.valueOf(value)));
						} else {//设置默认值
							setter.invoke(obj,0);
						}
						// setter.invoke(obj, Integer.parseInt( String.valueOf(
						// value ) ));
					} else if (clazz.equals(Float.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							setter.invoke(obj,
									Float.parseFloat(String.valueOf(value)));
						} else {//设置默认值
							setter.invoke(obj,0);
						}
						// setter.invoke(obj, Integer.parseInt( String.valueOf(
						// value ) ));
					} else {
						if( value != null ){
							setter.invoke(obj, value);
						} else {
							setter.invoke(obj, "");
						}
						
					}
				}
			}
		} catch (Exception e) {
			System.out.println("transMap2Bean Error " + e);
		}
		return;
	}

	/***
	 * 获得Java Bean中的表字段信息
	 * @param obj
	 */
	public void getFieldInfo( Object obj, List<String> fields, List<Object> values ){
		BeanInfo beanInfo;
		try {
			beanInfo = Introspector.getBeanInfo(obj.getClass());
			PropertyDescriptor[] propertyDescriptors = beanInfo
					.getPropertyDescriptors();
			
			for (PropertyDescriptor property : propertyDescriptors) {
				String key = property.getName();
				
				Method setter = property.getWriteMethod();
				Method getter = property.getReadMethod();
				Class clazz = property.getPropertyType();
				
				if( setter != null && getter != null ){//如果有set方法,当成是表字段
					Object value = getter.invoke(obj, new Object[]{});
					
					if ( clazz.equals(Integer.class) ) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							fields.add( key );
							values.add( Integer.parseInt(String.valueOf(value)) );
						}
					} else if (clazz.equals(Long.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							fields.add( key );
							values.add( Long.parseLong(String.valueOf(value)) );
						}
					} else if (clazz.equals(Double.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							fields.add( key );
							values.add( Double.parseDouble(String.valueOf(value)) );
						}
					} else if (clazz.equals(Float.class)) {
						if (NumberUtils.isNumber(String.valueOf(value))) {
							fields.add( key );
							values.add( Float.parseFloat(String.valueOf(value)) );
						}
					} else {
						fields.add( key );
						values.add( value );
					}
				}
			}
		} catch (IntrospectionException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
	}
}
