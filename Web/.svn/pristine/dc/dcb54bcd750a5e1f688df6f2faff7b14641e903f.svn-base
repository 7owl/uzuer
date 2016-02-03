package com.ssqian.signature.open.action.test;
import java.io.IOException;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;
public class ViewContract {
	public static void excute() throws IOException {
		String action = "ViewContract.page";
		String fsdid="1430380557067F8Y32";
		String docid="1430380557075ALZ91";
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + fsdid);
		signdata.append(CoreConstants.SIGN_SPLITSTR + docid);
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign=java.net.URLEncoder.encode(sign);	
		String url = "http://localhost:8080/openpage/ViewContract.page?mid=E0000000000000000009&fsdid="+fsdid+"&docid="+docid+"&sign="
				+ sign;
		System.out.println(url);
	}

	public static void main(String[] args) throws IOException {
		excute();
	}
}