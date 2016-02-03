package com.lingtong.util;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.LinkedHashMap;
import java.util.Map;

public class URLUtil
{
	public static void main(String [] args){
		Map kvMap;
		try {
			kvMap = URLUtil.splitQuery("http://www.phpcode8.com/?code=1222&id=888&xx=yy");

	        System.out.println(kvMap.get("code"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
	}
    public static Map splitQuery(URL url) throws UnsupportedEncodingException {
        Map query_pairs = new LinkedHashMap();
        String query = url.getQuery();
        String[] pairs = query.split("&");
        for (String pair : pairs) {
            int idx = pair.indexOf("=");
            query_pairs.put(URLDecoder.decode(pair.substring(0, idx), "UTF-8"), URLDecoder.decode(pair.substring(idx + 1), "UTF-8"));
        }
        return query_pairs;
    }
    
    public static Map splitQuery(String url0) throws UnsupportedEncodingException, MalformedURLException {
        URL url = new URL(url0);
        Map query_pairs = new LinkedHashMap();
        String query = url.getQuery();
        String[] pairs = query.split("&");
        if(null!=pairs && pairs.length>0){
            for (String pair : pairs) {
                //System.out.println("pair:"+pair);
                if(null!=pair && !"".equals(pair)){
                    int idx = pair.indexOf("=");
                    query_pairs.put(URLDecoder.decode(pair.substring(0, idx), "UTF-8"), URLDecoder.decode(pair.substring(idx + 1), "UTF-8"));
                }
                
            }
        }
       
        return query_pairs;
    }
    
    public static Map splitQueryString(String query)  {
        
        Map query_pairs = new LinkedHashMap();
        
        String[] pairs = query.split("&");
        for (String pair : pairs) {
            int idx = pair.indexOf("=");
            query_pairs.put(pair.substring(0, idx), pair.substring(idx + 1));
        }
        return query_pairs;
    }
}
