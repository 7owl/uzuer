/**
 * Constant.java
 *
 * @Title:
 * @Description:
 * @Copyright:杭州尚尚签网络科技有限公司 Copyright (c) 2012
 * @Company:杭州尚尚签网络科技有限公司
 * @Created on 2012-3-27 下午05:20:00
 * @author lijianhang
 * @version 1.0
 */

package com.ssqian.common.constant;

import com.lingtong.util.SystemConfiguration;

public class CoreConstants {

	public static final String CHARSET_ENCODING = "UTF-8";

	public static final String SIGN_SPLITSTR = "\n";

	public static String HTTPVERSION = "1.1";
	public static int REQUESTTIMEOUTINMILLIS = 60000;

	public static final String HTTPMETHOD_POST = "POST";

	public static final String HTTPMETHOD_GET = "GET";

	public static final String CONTENTTYPE_JSON = "application/json";

	public static final String SUCCESS_CODE = "100000";

	/**
	 * 服务器地址 "http://192.168.30.194:8080/"
	 */
	//public static final String HOST = "http://192.168.30.176:8080/"; // "http://192.168.1.112:8080/"
	
	public static final String HOST = SystemConfiguration.getString("ssq.host");
	//public static final String HOST = "https://www.ssqian.com.cn/";																	// //"http://192.168.30.175:8080/";
	//public static final String HOST = "https://www.ssqsign.com/";																	// //"http://192.168.30.175:8080/";
																		// //、"https://www.ssqsign.com/";
																		// https://www.ssqian.com.cn
																		// http://192.168.30.193:8080/

	/**
	 * 接口地址
	 */
	public static final String OPENAPI = HOST + "open/";
	public static final String APIPATH = HOST + "api/";
	public static final String OPENPAGEAPI = HOST + "openpage/";

	/**
	 * 开发者编号
	 */
	// 测试开发者编号
	//public static String MID = "E0000000000000000199";//"E0000000000000000103";
	
	//原来的
	//public static String MID = "E0000000000000000009";
	//测试的
	//public static String MID = "E0000000000000000112";
	public static String MID = SystemConfiguration.getString("ssq.mid");
	
	// 测试开发者编号
	public static String accessid = "5ff2f435ca6620a0edd6a71c6ee38b48";
	/**
	 * RSA私钥	
	 */
	//原来的
	//public static String PRIVATEKEY = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMyxNwqvSr8MPt1TRjJUSl8NPL/y2cbWcuWvpUoRNoPMOiqV4Pq36ZASLmvjY9OCW3CkvINED/rWPP2ppZ+KYd5hxM9DZJE4wmou54KTCY/9z0XwpWE5Kat8bg9cKsZGS43Irf9U7Uk85aDRCA5bL55Y8QHVi6WOSG3woISUCeP3AgMBAAECgYB+inPPjCx2TRiz9J4p0QglGObcd0KAdOSU7/AMCPYdpmyzFPL/rCCc61B9bBazlBv5WC4eLD6AwF72JiF4rrDvEWDpp6d/4u7TO01wRzpKkbbbhiUUONYWkbGd6hqY33GIaKXxgh+wSRPbyw93zCrdKQNJpGN/wTEzG0GlKFZcQQJBAO2jm+hoBB8o/XyCYAgd9pwvF4zEWTVucIMMY+0ZSoVZ6yVkUVYpQ4Ocb5fI398z8axybWShwPRUgc+dLOz/ExcCQQDcge681gxZN5+f1TyYt3V9zECU3rkBufUvodthq2ZFIJ8ntjhsdmbJNtzZ6myUeFIFXQeuvz2/Lr2jyQzdd8IhAkA6ovM2bmwN8ERT86uUdShDs48BCfXlLEIQ4/7II0RzERPnnxA+zWG+WNxkPImY/q00WuvJN+xvnWaGfwb1156zAkEAx7DLWSum5yzeW8qqI8sQlanhWnAQryWOi2JS4DJuXW/bcgUtN9xJ3TLX8mi/h/0mmkDTckcyTe6wQqESC4YmwQJBALpmEvN42xTd9BapxqAQscrL51HOM1LzyleMu9qA5O+YDH66wQh3ICIPqwrtDKLVuUqkTaWQcpzRLAtUtwluykQ=";
	//测试的
	//public static String PRIVATEKEY = "MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBALYDfCItq0ilCQVERwtsGLtjnTa1+mdrE602vfb3EbPsgm4QOPisO1twjBq48fE6OKYdlYzdFO4uk3wRaIZt+qLvG5OEJgmGGpu9H035L1YWT6hl6JQLJCGUqUbhIwW3mCvx/r/l+Jp8uuQ0p8oJCjGvGOOVLcY/xtUWJgEKADtTAgMBAAECgYAhB67eMPV1YGWrrAFMhFhUoTYleI6xd9ABTf7ZM2rmANSGjrEYB4FaDamPK+LUCOHA23uJLZGfy5n+GNakFo819bkw+qM/9igX9DlA3Yp3/qYAZfT/hXOruOjFS7C3S3YntZkiGhzx47yLfhXIKLVncWRJYc2YFkPsQjiCMYs5QQJBAOWvqCunruyy+su95IGx0nmf0FktdwdmXLKjpC1NwiDJelA3vuqUyLTkKESol8BKVb7mPKtJrsYT4Ortstnpv/MCQQDK3apMzOiBrsnxEx9nGjTev33nHiQLL1UnfrX1KXifn4G+WENGRnr/YtvTChq/GtJXp3P2HitTICPjIweP888hAkEAzkHjnvBB4UUIepXX8a+h9p5RFwQA86A0dicFc7l0LsU/FXI5+6YIZojMsHtFauRWA8v1h0vvquiG/fDev1ltiQJBAJu2iYFpxw3DnD3u76uz8eEIGxvLht8O9c3a9M+5hV0AkhYIqZrHfqGIwDK9DsqhS9L8NYY0ogysHt+5g5R7EAECQQDfWCc83zKRbys1BNrZSKyijEilaz4cPc56I4KCe/RIPH58a6HEaZXHTEJZGSlAKgemV2WCsFZqzA5fNUTkkm7e";
	public static String PRIVATEKEY = SystemConfiguration.getString("ssq.privatekey");

	/*public static String email = "supin_support@163.com";
	public static String name = "杭州溯品信息科技有限公司";
	public static String needvideo = "";
	public static String mobile = "13758250080";
	public static String emailtitle = "杭州溯品信息科技有限公司";
	public static String emailcontent = "hello world";
	public static String sxdays = "";
	public static String selfsign = "";
	public static String filename = "";*/
	
	public static String email = SystemConfiguration.getString("ssq.email");
	public static String name = SystemConfiguration.getString("ssq.name");
	public static String needvideo = "";
	public static String mobile = SystemConfiguration.getString("ssq.mobile");
	public static String emailtitle = SystemConfiguration.getString("ssq.emailtitle");
	public static String emailcontent = SystemConfiguration.getString("ssq.emailcontent");
	public static String sxdays = "";
	public static String selfsign = "";
	public static String filename = "";

}
