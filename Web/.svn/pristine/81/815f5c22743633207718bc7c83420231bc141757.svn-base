package com.ssqian.signature.open.action.test;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.ssqian.common.service.BaseAPIService;

public class MultiApplyContractdocUploadsend extends BaseAPIService {
	public static String execute() {
		String tmpstring = "";
		action = "multiApplyContractdocUploadsend.json";
		stype = 1;// 1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名

		List<Map<String, Object>> contractlist = new ArrayList<Map<String, Object>>();
		Map<String, Object> contrinfoMap1 = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap2 = new LinkedHashMap<String, Object>();

		Map<String, Object> contrinfoMap3 = new LinkedHashMap<String, Object>();
		Map<String, Object> contrinfoMap4 = new LinkedHashMap<String, Object>();
		contrinfoMap1.put("fsdid", "14313220063579M562");
		contrinfoMap1.put("status", "2");
		contractlist.add(contrinfoMap1);
		contrinfoMap2.put("fsdid", "1431322006402QU7Z2");
		contrinfoMap2.put("status", "2");
		contractlist.add(contrinfoMap2);
		contrinfoMap3.put("fsdid", "1431322006472L9HW2");
		contrinfoMap3.put("status", "2");		
		contractlist.add(contrinfoMap3);
		contrinfoMap4.put("fsdid", "1431322006720UCC72");
		contrinfoMap4.put("status", "2");		
		contractlist.add(contrinfoMap4);
		reqcontent.put("fsdidlist", contractlist);
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
