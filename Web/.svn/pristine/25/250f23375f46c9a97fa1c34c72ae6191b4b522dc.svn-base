package com.ssqian.signature.open.action.sign;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;

import net.sf.json.JSONArray;

import com.lingtong.model.Tenants;
import com.lingtong.vo.ContractVo;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class MutinContractdocUploadSendall extends BaseAPIService {
	public static String execute(List<Tenants> tenants, String emailTitle,
			String emailContent, String filepath) {// 合同上传并发送1.2
		action = "jointsendcontractdocUploadall.json";
		stype = 7;// 7表示合同发送
		uploadfile = filepath;
		String filename = FilenameUtils.getName(filepath);
		List<Map<String, Object>> bSideList = new ArrayList<Map<String, Object>>();//乙方
		List<Map<String, Object>> aSideList = new ArrayList<Map<String, Object>>();//甲方
		Map<String, Object> aSideinfoMap = new LinkedHashMap<String, Object>();

		//int len = tenants.size();
		int len = 1;
		String email[] = new String[len];
		String name[] = new String[len];
		String mobile[] = new String[len];
		initBsideInfo(email, mobile, name, tenants);
//userType 1表示个人用户 2表示企业用户//个人用户不需要公章 验证
		for (int i = 0; i < len; i++) {//乙方
			Map<String, Object> contrinfoMap = new LinkedHashMap<String, Object>();
			contrinfoMap.put("email", email[i]);
			contrinfoMap.put("name", name[i]);
			contrinfoMap.put("isvideo", "0");
			contrinfoMap.put("mobile", mobile[i]);
			if( StringUtils.isNotBlank( emailTitle ) ){
				contrinfoMap.put("emailtitle", emailTitle);
			} else {
				contrinfoMap.put("emailtitle", CoreConstants.emailtitle);
			}
			if( StringUtils.isNotBlank( emailTitle ) ){
				contrinfoMap.put("emailtitle", emailTitle);
			} else {
				contrinfoMap.put("emailtitle", CoreConstants.emailtitle);
			}
			contrinfoMap.put("emailcontent", emailContent);
			contrinfoMap.put("sxdays", "0");
			contrinfoMap.put("selfsign", "0");
			contrinfoMap.put("usertype", "1");
			contrinfoMap.put("Signimagetype", "0");
			bSideList.add(contrinfoMap);
		}
		//甲方
		aSideinfoMap.put("email", CoreConstants.email);
		aSideinfoMap.put("name", CoreConstants.name);
		aSideinfoMap.put("mobile", CoreConstants.mobile);
		aSideinfoMap.put("usertype", "2");
		aSideinfoMap.put("Signimagetype", "0");
		aSideList.add(aSideinfoMap);
		JSONArray bSideArray = JSONArray.fromObject(bSideList);
		JSONArray aSideArray = JSONArray.fromObject(aSideList);
		userlist = bSideArray.toString();
		senduser = aSideArray.toString();
		System.out.println(bSideArray.toString());
		subdata = filename + CoreConstants.SIGN_SPLITSTR + userlist
				+ CoreConstants.SIGN_SPLITSTR + senduser;
		String tmpstring = "";
		if( doService(stype) != null ){
			tmpstring = doService(stype).toString();
		} else {
			tmpstring = "";
		}
		//删除本地的合同文件
		File file = new File(filepath);
		if( file.exists() ){
			file.delete();
		}
		System.out.println(tmpstring);
		return tmpstring;
	}

	/**
	 * 初始化乙方信息
	 */
	private static void initBsideInfo(String[] emails, String[] mobiles,
			String[] names, List<Tenants> tenants) {
		Iterator<Tenants> iter = tenants.iterator();
		int index = 0;
		while (iter.hasNext()) {
			Tenants tenant = iter.next();
			emails[index] = tenant.getEmail();
			mobiles[index] = tenant.getTel_number();
			names[index] = tenant.getFirst_name() + tenant.getLast_name();
			index += 1;
		}
	}

	public static String execute() {// 合同上传并发送1.2
		action = "jointsendcontractdocUploadall.json";
		stype = 7;// 7表示合同发送
		uploadfile = "D:\\test.doc";
		String filename = "test.doc";
		List<Map<String, Object>> contractlist = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> contractlist2 = new ArrayList<Map<String, Object>>();
		Map<String, Object> contrinfoMap3 = new LinkedHashMap<String, Object>();
		String email[] = { "1611491782@qq.com", "wenji_lixx2@163.com",
				"wenji_lixx3@163.com", "wenji_lixx4@163.com",
				"wenji_lixx5@163.com" };
		String name[] = { "xqq", "测试二", "测试三", "测试四", "测试五" };
		String mobile[] = { "15215731373", "18698237444", "18698237445",
				"18698237446", "18698237447" };
		int lenth = 1;
		for (int i = 0; i < lenth; i++) {
			Map<String, Object> contrinfoMap = new LinkedHashMap<String, Object>();
			contrinfoMap.put("email", email[i]);
			contrinfoMap.put("name", name[i]);
			contrinfoMap.put("isvideo", "0");
			contrinfoMap.put("mobile", mobile[i]);
			contrinfoMap.put("emailtitle", "公章未 审核通");
			contrinfoMap.put("emailcontent", "公章未审核通过测试");
			contrinfoMap.put("sxdays", "0");
			contrinfoMap.put("selfsign", "0");
			contrinfoMap.put("usertype", "2");
			contrinfoMap.put("Signimagetype", "0");
			contractlist.add(contrinfoMap);
		}
		/*
		 * contrinfoMap3.put("email", "liwenjixxxx@163.com");
		 * contrinfoMap3.put("name", "张十二"); contrinfoMap3.put("mobile",
		 * "18106532682");
		 */
		contrinfoMap3.put("email", CoreConstants.email);
		contrinfoMap3.put("name", CoreConstants.name);
		contrinfoMap3.put("mobile", CoreConstants.mobile);
		contrinfoMap3.put("usertype", "2");
		contrinfoMap3.put("Signimagetype", "0");
		contractlist2.add(contrinfoMap3);
		JSONArray jsonArray = JSONArray.fromObject(contractlist);
		JSONArray jsonArray1 = JSONArray.fromObject(contractlist2);
		userlist = jsonArray.toString();
		senduser = jsonArray1.toString();
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
