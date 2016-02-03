
package com.ssqian.signature.open.action.sign;

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
		uploadfile = "D:\\demo.docx";
		String filename = "demo.docx";
     	String Signimagetype = "0";
     	List<Map<String, Object>> contractlist = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> contractlist2 = new ArrayList<Map<String, Object>>();
		Map<String, Object> contrinfoMap = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap2 = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap4 = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap3 = new LinkedHashMap<String, Object>();
		contrinfoMap.put("email", "296132@qq.com");
		contrinfoMap.put("name", "测试二");
		contrinfoMap.put("needvideo", "0");
		contrinfoMap.put("mobile", "13979105113");
		contrinfoMap.put("emailtitle", "公章未审核通");
		contrinfoMap.put("emailcontent", "公章未审核通过测试");
		contrinfoMap.put("sxdays", "0");
		contrinfoMap.put("selfsign", "0");
		contrinfoMap.put("usertype", "1");
		contrinfoMap.put("Signimagetype", "0");	
		contractlist.add(contrinfoMap);		     	
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
