package com.lingtong.interfaces.test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

import com.lingtong.util.FileUtils;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.model.FileInfo;
import com.qiniu.util.Auth;

/**
 * @author xqq
 * @date 2015-9-1 下午8:49:38
 * 
 */
public class Test7Niu {
	public static void main(String[] args) {
		List<String> keys = FileUtils.queryResources(100);

		for (String key : keys) {
			String url = FileUtils.downloadUrl(key);
			
			try {
				Test7Niu.download(url, key, "D://pic");
				File file = new File( "D://pic/" + key);
				FileUtils.upload(file);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	
	public static void download(String urlString, String filename,
			String savePath) throws Exception {
		// 构造URL
		URL url = new URL(urlString);
		// 打开连接
		URLConnection con = url.openConnection();
		// 设置请求超时为5s
		con.setConnectTimeout(5 * 1000);
		// 输入流
		InputStream is = con.getInputStream();

		// 1K的数据缓冲
		byte[] bs = new byte[1024];
		// 读取到的数据长度
		int len;
		// 输出的文件流
		File sf = new File(savePath);
		if (!sf.exists()) {
			sf.mkdirs();
		}
		OutputStream os = new FileOutputStream(sf.getPath() + "\\" + filename);
		// 开始读取
		while ((len = is.read(bs)) != -1) {
			os.write(bs, 0, len);
		}
		// 完毕，关闭所有链接
		os.close();
		is.close();
	}
}
