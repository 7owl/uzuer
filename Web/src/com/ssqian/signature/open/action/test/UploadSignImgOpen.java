package com.ssqian.signature.open.action.test;

import java.io.File;
import java.io.FileInputStream;

import sun.misc.BASE64Encoder;

import com.ssqian.common.service.BaseAPIService;

public class UploadSignImgOpen extends BaseAPIService {

	public static String execute() {
		String tmpstring = "";
		action = "nonRegUploadSeal.json";
		stype = 6;// 1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名6签名图片上传
		String email = "测试";// 合同状态
		String phpont = "18106532682";// 合同状态
		String imapgpath="D:\\seal.jpg";
		String image=getimage(imapgpath);
		
		System.out.println(image);
		
		String imgType="jpg";
		String imgName="seal.jpg";
		reqcontent.put("companyName", email);
		reqcontent.put("mobile", phpont);
		reqcontent.put("image", image);
		reqcontent.put("imgType", imgType);
		reqcontent.put("imgName", imgName);
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

	public static String getimage(String filePath) {
		String base64Code = "";
		try {
			File file = new File(filePath);
			FileInputStream fileInputStream;
			fileInputStream = new FileInputStream(file);
			byte[] buffer = new byte[(int) file.length()];
			fileInputStream.read(buffer);
			fileInputStream.close();
			base64Code = new BASE64Encoder().encode(buffer);
		} catch (Exception e) {
		}
		return base64Code;

	}
}
