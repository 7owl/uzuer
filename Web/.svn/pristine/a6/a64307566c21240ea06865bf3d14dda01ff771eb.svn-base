/**
 * Copyright(c) 2005 zjhcsoft Techonologies, Ltd.
 *
 * History:
 *   2010-3-4 14:10:33 Created by Tiwen
 */
package com.lingtong.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.lingtong.util.SystemConfiguration;



/**
 * 系统配置文件参获取类
 *
 */
public class SystemConfigurationTest
{
    public  static void main(String []args){
    	ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
    	System.out.println("properties config. key master=" + SystemConfiguration.getString("master"));
//    	System.out.println("properties config. key abc=" + SystemConfiguration.getString("abc"));
    }
}
