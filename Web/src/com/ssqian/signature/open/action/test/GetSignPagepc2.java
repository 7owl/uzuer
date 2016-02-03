

package com.ssqian.signature.open.action.test;
import java.io.IOException;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;
public class GetSignPagepc2 {
	public static void excute() throws IOException {//（甲方不指定位置，不生成默认签名，允许乙方拖动）	
		String action = "getSignPageSignimagePc.json";
		String typedevice="1";
		String returnurl="http://www.baidu.com";
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + "1434532428129HPNL2");
		signdata.append(CoreConstants.SIGN_SPLITSTR + "liwxyx@163.com");
//		signdata.append(CoreConstants.SIGN_SPLITSTR + pagenum);
//		signdata.append(CoreConstants.SIGN_SPLITSTR + signx);
//		signdata.append(CoreConstants.SIGN_SPLITSTR + signy);
		//signdata.append(CoreConstants.SIGN_SPLITSTR + returnurl);
	//	signdata.append(CoreConstants.SIGN_SPLITSTR + typedevice);
		
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign=java.net.URLEncoder.encode(sign);	
//		String url = "http://192.168.30.193:8080/openpage2/getSignPageSignimagePc.json?fsid=1433229916635MPXC2"+"&typedevice="+typedevice+"&returnurl="+returnurl+"&email=362021204@qq.com&mid=E0000000000000000009&sign="
//				+ sign;
		
		
			String url = "https://www.ssqsign.com/openpage/getSignPageSignimagePc.json?fsid=1434532428129HPNL2"+"&typedevice="+typedevice+"&returnurl="+returnurl+"&email=liwxyx@163.com&mid=E0000000000000000009&sign="
			+ sign;
		
		System.out.println(url);
	}

	public static void main(String[] args) throws IOException {
		excute();
	}
}