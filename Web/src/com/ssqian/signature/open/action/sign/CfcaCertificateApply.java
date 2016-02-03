package com.ssqian.signature.open.action.sign;

import com.ssqian.common.service.BaseAPIService;

public class CfcaCertificateApply extends BaseAPIService{


	public static String execute() {
		String tmpstring = "";
		action ="cfcaCertificateApply.json";
		stype=2;//合同信息查询
		//String signid="1439543105064ZTF41";//合同编号
		String userType="1";
		String name="测试";
		String password="123456";
		String certificateType="3";
		String identType="0";
		String identNo="110101200408019412";
		String duration="24";
		String address="杭州";
		String linkMobile="13706532684";
		String email="252089821@qq.com";
		reqcontent.put("userType", userType);
		reqcontent.put("name", name);
		reqcontent.put("password", password);
		reqcontent.put("certificateType", certificateType);
		reqcontent.put("identType", identType);
		reqcontent.put("identNo", identNo);
		reqcontent.put("duration", duration);
		reqcontent.put("address", address);
		reqcontent.put("linkMobile", linkMobile);
		reqcontent.put("email", email);
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
