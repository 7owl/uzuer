package com.ssqian.signature.open.action.test;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class MutinContractdocUploadSendall extends BaseAPIService {

	public static String execute() {

		action = "jointsendcontractdocUploadall.json";
		stype = 7;// 1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名
		uploadfile = "D:\\demo.docx";
		String filename = "demo.docx";
		List<Map<String, Object>> contractlist = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> contractlist2 = new ArrayList<Map<String, Object>>();
		Map<String, Object> contrinfoMap = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap2 = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap4 = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap3 = new LinkedHashMap<String, Object>();
		contrinfoMap.put("email", "wenji_lixx@163.com");
		contrinfoMap.put("name", "测试一");
		contrinfoMap.put("needvideo", "0");
		contrinfoMap.put("mobile", "18698237497");
		contrinfoMap.put("emailtitle", "公章未审核通");
		contrinfoMap.put("emailcontent", "公章未审核通过测试");
		contrinfoMap.put("sxdays", "0");
		contrinfoMap.put("selfsign", "0");
		contrinfoMap.put("usertype", "1");
		contrinfoMap.put("Signimagetype", "0");	
		contractlist.add(contrinfoMap);		
		contrinfoMap2.put("email", "");
		contrinfoMap2.put("name", "测试2");
		contrinfoMap2.put("needvideo", "0");
		contrinfoMap2.put("mobile", "18698237444");
		contrinfoMap2.put("emailtitle", "张十二");
		contrinfoMap2.put("name", "张十一测试");
		contrinfoMap2.put("emailcontent", "邮件消息内容");
		contrinfoMap2.put("sxdays", "1");
		contrinfoMap2.put("selfsign", "1");
		contrinfoMap2.put("usertype", "1");
		contrinfoMap2.put("Signimagetype", "0");		
		contractlist.add(contrinfoMap2);
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
