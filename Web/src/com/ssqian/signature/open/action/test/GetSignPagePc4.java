


package com.ssqian.signature.open.action.test;
import java.io.IOException;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;
public class GetSignPagePc4 {//（甲方不指定位置，生成默认签名，允许乙方拖动）
	public static void excute() throws IOException {
		
		String action = "getSignPagePc.json";
		StringBuilder signdata = new StringBuilder();
		String typedevice="1";
		String returnurl="http://www.baidu.com";
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + "1432031046031C6VC2");
		signdata.append(CoreConstants.SIGN_SPLITSTR + "362021204@qq.com");
		signdata.append(CoreConstants.SIGN_SPLITSTR + returnurl);
		signdata.append(CoreConstants.SIGN_SPLITSTR + typedevice);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign=java.net.URLEncoder.encode(sign);
		String url = "https://www.ssqsign.com/openpage2/getSignPagePc.json?fsid=1432031046031C6VC2"+"&typedevice="+typedevice+"&returnurl="+returnurl+"&email=362021204@qq.com&mid=E0000000000000000009&sign="
				+ sign;
		System.out.println(url);
	}

	public static void main(String[] args) throws IOException {
		excute();
	}
}