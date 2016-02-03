package com.ssqian.signature.demo;

import org.json.JSONObject;

import com.ssqian.common.constant.CoreConstants;
import com.ssqian.common.service.BaseAPIService;

public class ContractdocUploadSend  extends BaseAPIService{
	
	public static JSONObject execute(String MID, String PRIVATEKEY,String uploadfilepar, String filenamepar,
			String emailpar, String needvideopar, String namepar,
			String mobilepar, String emailtitlepar, String emailcontentpar,String sxdayspar,String selfsignpar ) {
		
		action = "contractdocUploadsend.json";
		stype = 3;// 1：合同列表查询 、2：合同信息查询、3：合同发起 4：合同签名
		uploadfile = uploadfilepar;
		CoreConstants.filename =filenamepar;
		CoreConstants.MID=MID;
		CoreConstants.PRIVATEKEY=PRIVATEKEY;
		CoreConstants.email = emailpar;
		CoreConstants.name = namepar;
		CoreConstants.needvideo =needvideopar;
		CoreConstants.mobile=mobilepar;
		CoreConstants.emailtitle =emailtitlepar;
		CoreConstants.emailcontent = emailcontentpar;
		CoreConstants.sxdays =sxdayspar;
		CoreConstants.selfsign = selfsignpar;

		subdata = filenamepar + CoreConstants.SIGN_SPLITSTR + emailpar
				+ CoreConstants.SIGN_SPLITSTR + namepar
				+ CoreConstants.SIGN_SPLITSTR + needvideopar
				+ CoreConstants.SIGN_SPLITSTR + mobilepar
				+ CoreConstants.SIGN_SPLITSTR + emailtitlepar
				+ CoreConstants.SIGN_SPLITSTR + emailcontentpar
				+ CoreConstants.SIGN_SPLITSTR + sxdayspar 
				+ CoreConstants.SIGN_SPLITSTR + selfsignpar;
		
		
		
		
		
		return doService(stype);
		
		
	}
	
	

}
