package com.ssqian.signature.testdemo;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class MutinContractdocUploadSendallsjd extends BaseAPIService {

	public static String execute() {//合同上传并发送 ，使用云文件
		action = "sjdsendcontractdocUpload.json";
		stype = 11;// 7表示合同发送
		uploadfile = "D:\\test.doc";
		String filename = "test.doc";
		
		List<Map<String, Object>> contractlist = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> contractlist2 = new ArrayList<Map<String, Object>>();
		Map<String, Object> contrinfoMap3 = new LinkedHashMap<String, Object>();
		String email[]={"1611491782@qq.com","wenji_lixx2@163.com","wenji_lixx3@163.com","wenji_lixx4@163.com","wenji_lixx5@163.com"};
		String name[]={"测试 九","测试二","测试三","测试四","测试五"};
		String mobile[]={"15215731373","18698237444","18698237445","18698237446","18698237447"};
		int lenth=1;
		for (int i = 0; i <lenth ; i++) {
			Map<String, Object> contrinfoMap = new LinkedHashMap<String, Object>();
			contrinfoMap.put("email", email[i]);
			contrinfoMap.put("name", name[i]);
			contrinfoMap.put("isvideo", "0");
			contrinfoMap.put("mobile", mobile[i]);
			contrinfoMap.put("usertype", "2");
			contrinfoMap.put("Signimagetype", "0");	
			contractlist.add(contrinfoMap);	
		}	
		contrinfoMap3.put("email", "supin_support@163.com");
		contrinfoMap3.put("name", "曾添");
		contrinfoMap3.put("mobile", "13758250080");
		contrinfoMap3.put("usertype", "2");
		contrinfoMap3.put("emailtitle", "公章未 审核通");
		contrinfoMap3.put("emailcontent", "公章未审核通过测试");
		contrinfoMap3.put("sxdays", "0");
		contrinfoMap3.put("selfsign", "0");
		contrinfoMap3.put("Signimagetype", "0");
		contrinfoMap3.put("filename", filename);
		contrinfoMap3.put("UserfileType", "1");//换成1
		contractlist2.add(contrinfoMap3);
		JSONArray jsonArray = JSONArray.fromObject(contractlist);
		JSONArray jsonArray1 = JSONArray.fromObject(contractlist2);
		System.out.println(jsonArray1.toString());
		userlist=jsonArray.toString();
		senduser=jsonArray1.toString();
		System.out.println(jsonArray.toString());
		
		
//		subdata = filename + CoreConstants.SIGN_SPLITSTR + userlist
//				+ CoreConstants.SIGN_SPLITSTR + senduser;
		
		subdata =userlist
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
