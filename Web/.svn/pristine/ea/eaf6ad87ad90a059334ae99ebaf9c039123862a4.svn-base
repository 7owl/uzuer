package com.ssqian.signature.open.action.test;
import java.io.IOException;
import com.ssqian.common.constant.CoreConstants;
import com.ssqian.signature.util.SignUtil;

public class GetSignPagemobile {
	@SuppressWarnings("deprecation")
	public static void excute() throws IOException {

		String action = "getSignPagemobile.json";
		StringBuilder signdata = new StringBuilder();
		signdata.append(action);
		signdata.append(CoreConstants.SIGN_SPLITSTR + CoreConstants.MID);
		signdata.append(CoreConstants.SIGN_SPLITSTR + "14284639349986AIJ2");
		signdata.append(CoreConstants.SIGN_SPLITSTR + "362021204@qq.com");
		String sign = null;
		try {
			sign = SignUtil.sign(signdata.toString()).trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sign=java.net.URLEncoder.encode(sign);
		String url = "http://localhost:8080/api/getSignPagemobile.json?fsid=1427964974447TDJ42&email=362021204@qq.com&mid=E0000000000000000009&sign="
				+ sign;
		System.out.println(url);
	}

	public static void main(String[] args) throws IOException {
		excute();
	}
}