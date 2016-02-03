
package com.ssqian.signature.open.action.test;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class MutinContractdocUploadSend extends BaseAPIService {

	public static String execute() {

		action = "contractdocUploadsend.json";
		stype = 5;// 1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名
		uploadfile = "D:\\demo.doc";
		String filename = "demo.doc";

 //userlist= "[{\"email\":\"362021204@qq.com\",\"name\":\"张五\",\"needvideo\":\"0\"," +
	//	 "\"mobile\":\"18106532682\",\"emailtitle\":\"张五测试\",\"emailcontent\":\"邮件消息内容\",\"sxdays\":\"1\",\"selfsign\":\"0\"},"+"{\"email\":\"362021205@qq.com\",\"name\":\"李四\",\"needvideo\":\"0\"," + "\"mobile\":\"18106532682\",\"emailtitle\":\"张五测试\",\"emailcontent\":\"邮件消息内容\",\"sxdays\":\"1\",\"selfsign\":\"0\"}]";
// userlist= "[{\"email\":\"362021208@qq.com\",\"name\":\"张十二\",\"needvideo\":\"0\"," +
//		 "\"mobile\":\"18106532682\",\"emailtitle\":\"张十一测试\",\"emailcontent\":\"邮件消息内容\",\"sxdays\":\"1\",\"selfsign\":\"0\"},]";///+"{\"email\":\"362021205@qq.com\",\"name\":\"李四\",\"needvideo\":\"0\"," + "\"mobile\":\"18106532682\",\"emailtitle\":\"张五测试\",\"emailcontent\":\"邮件消息内容\",\"sxdays\":\"1\",\"selfsign\":\"0\"}]";
//		
//		String email = "362021204@qq.com";
//		String name = "张五";
//		String needvideo = "0";
//        String mobile="18106532682";
//		String emailtitle = "张五";
//		String emailcontent = "210";
//		String sxdays = "2";
     	String Signimagetype = "0";
     	
     	
     	List<Map<String, Object>> contractlist = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> contractlist2 = new ArrayList<Map<String, Object>>();
		Map<String, Object> contrinfoMap = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap2 = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap4 = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap3 = new LinkedHashMap<String, Object>();
		contrinfoMap.put("email", "liwxyx@163.com");
		contrinfoMap.put("name", "测试一");
		contrinfoMap.put("needvideo", "0");
		contrinfoMap.put("mobile", "18106532682");
		contrinfoMap.put("emailtitle", "公章未审核通");
		contrinfoMap.put("emailcontent", "公章未审核通过测试");
		contrinfoMap.put("sxdays", "0");
		contrinfoMap.put("selfsign", "0");
		contrinfoMap.put("usertype", "1");
		contrinfoMap.put("Signimagetype", "0");	
		contractlist.add(contrinfoMap);		
//		contrinfoMap2.put("email", "liwxyxz@163.com");
//		contrinfoMap2.put("name", "测试2");
//		contrinfoMap2.put("needvideo", "0");
//		contrinfoMap2.put("mobile", "18106532682");
//		contrinfoMap2.put("emailtitle", "张十二");
//		contrinfoMap2.put("name", "张十一测试");
//		contrinfoMap2.put("emailcontent", "邮件消息内容");
//		contrinfoMap2.put("sxdays", "1");
//		contrinfoMap2.put("selfsign", "1");
//		contrinfoMap2.put("usertype", "1");
//		contrinfoMap2.put("Signimagetype", "0");		
//		contractlist.add(contrinfoMap2);
     	
     	
     	
     	
		JSONArray jsonArray = JSONArray.fromObject(contractlist);
		JSONArray jsonArray1 = JSONArray.fromObject(contractlist2);
		userlist=jsonArray.toString();
		
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
     	
		 
		subdata = filename + CoreConstants.SIGN_SPLITSTR+Signimagetype+CoreConstants.SIGN_SPLITSTR +userlist;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
				
//				email
//				+ CoreConstants.SIGN_SPLITSTR + name
//				+ CoreConstants.SIGN_SPLITSTR + needvideo
//				+ CoreConstants.SIGN_SPLITSTR + mobile
//				+ CoreConstants.SIGN_SPLITSTR + emailtitle
//				+ CoreConstants.SIGN_SPLITSTR + emailcontent
//				+ CoreConstants.SIGN_SPLITSTR + sxdays 
//				+ CoreConstants.SIGN_SPLITSTR + selfsign;
		
		String tmpstring = "";
		tmpstring = doService(stype).toString();
		System.out.println(tmpstring);
		return tmpstring;

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		execute();

	}

}
