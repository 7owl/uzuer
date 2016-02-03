package com.ssqian.signature.testdemo;
import java.io.IOException;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;
public class ViewContract {
	public static void excute() throws IOException {//∫œÕ¨‘§¿¿
		String action = "ViewContract.page";
		String fsdid="1439629751984VTAW2";
		String docid="143962975198411WM1";
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + "E0000000000000000009");
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsdid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + docid);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign=java.net.URLEncoder.encode(sign);	
		String url = "https://www.ssqsign.com/openpage/ViewContract.page?mid=E0000000000000000009&fsdid="+fsdid+"&docid="+docid+"&sign="
				+ sign;
		System.out.println(url);
	}

	public static void main(String[] args) throws IOException {
		excute();
	}
}