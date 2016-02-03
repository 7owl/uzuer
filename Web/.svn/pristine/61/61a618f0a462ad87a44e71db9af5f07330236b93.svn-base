package com.ssqian.signature.open.action.sign;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class MutinContractdocUploadSendallsjd extends BaseAPIService {

	public static String execute() {//合同上传并发送1.2
		action = "sjdsendcontractdocUpload.json";
		stype = 11;// 7表示合同发送
		uploadfile = "D:\\demo.docx";
		String filename = "demo.docx";
		List<Map<String, Object>> contractlist = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> contractlist2 = new ArrayList<Map<String, Object>>();
		Map<String, Object> contrinfoMap3 = new LinkedHashMap<String, Object>();
		String email[]={"252089721@qq.com","wenji_lixx2@163.com","wenji_lixx3@163.com","wenji_lixx4@163.com","wenji_lixx5@163.com"};
		String name[]={"测试 九","测试二","测试三","测试四","测试五"};
		String mobile[]={"18106532682","18698237444","18698237445","18698237446","18698237447"};
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
		contrinfoMap3.put("email", "liwenjixxxx@163.com");
		contrinfoMap3.put("name", "张十二");
		contrinfoMap3.put("mobile", "18106532682");
		contrinfoMap3.put("usertype", "2");
		contrinfoMap3.put("emailtitle", "公章未 审核通");
		contrinfoMap3.put("emailcontent", "公章未审核通过测试");
		contrinfoMap3.put("sxdays", "0");
		contrinfoMap3.put("selfsign", "0");
		contrinfoMap3.put("Signimagetype", "0");
		contrinfoMap3.put("UserfileType", "2");
		contractlist2.add(contrinfoMap3);
		JSONArray jsonArray = JSONArray.fromObject(contractlist);
		JSONArray jsonArray1 = JSONArray.fromObject(contractlist2);
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
