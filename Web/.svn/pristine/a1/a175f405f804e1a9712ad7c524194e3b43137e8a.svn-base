package com.ssqian.signature.open.action.test;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.json.JSONUtils;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class MultiThreadcontractdocUploadsend extends BaseAPIService {

	public static String execute() {
		action = "MultiThreadcontractdocUploadsend.json";
		stype = 6;// 1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名
		uploadfile = "D:\\demo.docx";
		String filename = "demo.docx";
		List<Map<String, Object>> contractlist = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> contractlist2 = new ArrayList<Map<String, Object>>();
		Map<String, Object> contrinfoMap = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap2 = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap4 = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap5 = new LinkedHashMap<String, Object>();
		
		
		
		
		Map<String, Object> contrinfoMap3 = new LinkedHashMap<String, Object>();
//		contrinfoMap.put("email", "362021208@qq.com");
//		contrinfoMap.put("name", "张十二");
//		contrinfoMap.put("needvideo", "0");
//		contrinfoMap.put("mobile", "18106532682");
//		contrinfoMap.put("emailtitle", "张十二");
//		contrinfoMap.put("name", "张十一测试");
//		contrinfoMap.put("emailcontent", "邮件消息内容");
//		contrinfoMap.put("sxdays", "1");
//		contrinfoMap.put("selfsign", "0");
//		contrinfoMap.put("usertype", "1");
//		contrinfoMap.put("Signimagetype", "0");	
		
		
		
		for (int i = 0; i < 60; i++) {
			Map<String, Object> contrinfoMaph = new LinkedHashMap<String, Object>();
			
			String tmpid="11"+i;
			String email="36202"+tmpid+"@qq.com";
			contrinfoMaph.put("email", email);
			contrinfoMaph.put("name", "张十二");
			contrinfoMaph.put("needvideo", "0");
			contrinfoMaph.put("mobile", "18106532682");
			contrinfoMaph.put("emailtitle", "张十二");
			contrinfoMaph.put("name", "张十一测试");
			contrinfoMaph.put("emailcontent", "邮件消息内容");
			contrinfoMaph.put("sxdays", "1");
			contrinfoMaph.put("selfsign", "0");
			contrinfoMaph.put("usertype", "1");
			contrinfoMaph.put("Signimagetype", "0");
			
			contractlist.add(contrinfoMaph);
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
//		contractlist.add(contrinfoMap);		
//		contrinfoMap2.put("email", "362021209@qq.com");
//		contrinfoMap2.put("name", "张十二");
//		contrinfoMap2.put("needvideo", "0");
//		contrinfoMap2.put("mobile", "18106532682");
//		contrinfoMap2.put("emailtitle", "张十二");
//		contrinfoMap2.put("name", "张十一测试");
//		contrinfoMap2.put("emailcontent", "邮件消息内容");
//		contrinfoMap2.put("sxdays", "1");
//		contrinfoMap2.put("selfsign", "0");
//		contrinfoMap2.put("usertype", "2");
//		contrinfoMap2.put("Signimagetype", "0");		
//		contractlist.add(contrinfoMap2);
//		contrinfoMap4.put("email", "362021210@qq.com");
//		contrinfoMap4.put("name", "张十二");
//		contrinfoMap4.put("needvideo", "0");
//		contrinfoMap4.put("mobile", "18106532682");
//		contrinfoMap4.put("emailtitle", "张十二");
//		contrinfoMap4.put("name", "张十一测试");
//		contrinfoMap4.put("emailcontent", "邮件消息内容");
//		contrinfoMap4.put("sxdays", "1");
//		contrinfoMap4.put("selfsign", "0");
//		contrinfoMap4.put("usertype", "1");
//		contrinfoMap4.put("Signimagetype", "0");		
//		contractlist.add(contrinfoMap4);
//		
//		
//		contrinfoMap5.put("email", "362021212@qq.com");
//		contrinfoMap5.put("name", "张十二");
//		contrinfoMap5.put("needvideo", "0");
//		contrinfoMap5.put("mobile", "18106532682");
//		contrinfoMap5.put("emailtitle", "张十二");
//		contrinfoMap5.put("name", "张十一测试");
//		contrinfoMap5.put("emailcontent", "邮件消息内容");
//		contrinfoMap5.put("sxdays", "1");
//		contrinfoMap5.put("selfsign", "0");
//		contrinfoMap5.put("usertype", "1");
//		contrinfoMap5.put("Signimagetype", "0");		
//		contractlist.add(contrinfoMap4);
		contrinfoMap3.put("email", "liwenjixxxx@163.com");
		contrinfoMap3.put("name", "张十二");
		contrinfoMap3.put("mobile", "18106532682");
		contrinfoMap3.put("usertype", "2");
		contrinfoMap3.put("Signimagetype", "0");
		contractlist2.add(contrinfoMap3);
		
		JSONArray jsonArray = JSONArray.fromObject(contractlist);
		JSONArray jsonArray1 = JSONArray.fromObject(contractlist2);
		userlist=jsonArray.toString();
		senduser=jsonArray1.toString();
		System.out.println(jsonArray.toString());
		subdata = filename + CoreConstants.SIGN_SPLITSTR + userlist
				+ CoreConstants.SIGN_SPLITSTR + senduser;
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
