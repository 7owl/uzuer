package com.uzuser.thirdparty.sciener;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;

import com.lingtong.util.SystemConfiguration;

/**
 * @author xqq
 * @date 2015-9-25 下午10:11:47
 * 
 */
public class PasswordMD5 {
	private static PasswordMD5 util;
	
	private PasswordMD5 (){}
	
	public static PasswordMD5 getInstance(){
		if( util == null ){
			util = new PasswordMD5();
		}
		return util;
	}
	
	public String getPassword(String password){
        try {
        	ScriptEngineManager engineManager = new ScriptEngineManager();  
            ScriptEngine engine = engineManager.getEngineByName("JavaScript"); //得到脚本引擎
			engine.eval(new java.io.FileReader(SystemConfiguration.getString("passwordFilePath")));
			Invocable inv = (Invocable)engine;  
		    Object a = inv.invokeFunction("md5", password );
		    return a.toString();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (ScriptException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		}  finally {
			return "";
		}
       
	}
	
	public static void main(String[] args) throws ScriptException, NoSuchMethodException, IOException {
		//System.out.println(new PasswordMD5().md5("123456", "", ""));
        ScriptEngineManager engineManager = new ScriptEngineManager();  
        ScriptEngine engine = engineManager.getEngineByName("JavaScript"); //得到脚本引擎
        engine.eval(new java.io.FileReader("D://haha/password.js"));  
        Invocable inv = (Invocable)engine;  
        Object a = inv.invokeFunction("md5", "123456" );  
        System.out.println(a.toString());
	}
}
