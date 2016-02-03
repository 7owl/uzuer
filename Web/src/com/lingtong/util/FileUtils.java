package com.lingtong.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.BatchStatus;
import com.qiniu.storage.model.FileInfo;
import com.qiniu.util.Auth;



/**
 * @author xqq
 * @date 2015-8-10 下午8:36:08
 * 
 */
public class FileUtils {
	private static final String AK = SystemConfiguration.getString("img.7niu.ak");
	private static final String SK = SystemConfiguration.getString("img.7niu.sk");
	private static final String DOMAIN = SystemConfiguration.getString("img.7niu.domain");
	private static final String BUCKET_NAME = SystemConfiguration.getString("img.7niu.bucket_name"); 
	
    /**
     * 上传图片到七牛云存储
     * @param reader
     * @param fileName
     */
    public static boolean upload(File file) {
		UploadManager upManager = new UploadManager();

		Auth auth = Auth.create(AK, SK);
		String token = auth.uploadToken( BUCKET_NAME );
		try {
			//文件内容,文件名,token
			Response r = upManager.put(file, file.getName(), token);
			System.err.println( r.bodyString() );
			return r.statusCode == 200 ? true : false;
		} catch (QiniuException e) {
			e.printStackTrace();
			return false;
		} finally {
			if(file.exists()){
				file.delete();
			}
		}

    }
    
    /***
     * 获得下载路径
     * @param fileName
     * @return
     */
    public static String downloadUrl( String fileName ){
    	Auth auth = Auth.create(AK, SK);
    	String data = auth.privateDownloadUrl( DOMAIN + "/" + fileName, 3600 * 24);
    	System.out.println(data);
    	return data;
    	
    }
    
    /***
     * 获得永久的下载路径
     * @return
     */
    public static String downloadUrl2( String fileName ){
    	return DOMAIN + "/" + fileName;
    }
    
    /***
	 * 将流转成文件
	 * @param is
	 * @param filePath
	 * @return
	 */
	public static File stream2File( InputStream is, String filePath ){
		FileOutputStream fos = null;
		File file = new File( filePath );
		try {
			fos = new FileOutputStream(file);
			byte[] buffer = new byte[1024];
			int len;
			while( ( len = is.read(buffer) ) > 0 ){
				fos.write(buffer, 0, len);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			try {
				is.close();
				fos.close();
			} catch (Exception e2) {
				e2.printStackTrace();
				throw new RuntimeException(e2);
			}
		}
		
		return file;
	}
    /***
     * 上传用户证件照
     * @param bytes
     * @param fileName
     * @return
     */
	public static boolean upload(byte[] bytes, String fileName) {
		UploadManager upManager = new UploadManager();

		Auth auth = Auth.create(AK, SK);
		String token = auth.uploadToken( BUCKET_NAME );
		try {
			//文件内容,文件名,token
			Response r = upManager.put(bytes, fileName, token);
			System.err.println( r.bodyString() );
			return r.statusCode == 200 ? true : false;
		} catch (QiniuException e) {
			e.printStackTrace();
			return false;
		}
    }
	
	/***
	 * 7牛,根据文件名批量删除文件
	 * @param keys
	 */
	public static boolean deleteFile( String keys ){
		Auth auth = Auth.create(AK,	SK);
		BucketManager bucketManager = new BucketManager(auth);
		int flag = 1;
		try {
			if( StringUtils.isNotBlank( keys ) ){
				String[] tmps = keys.split(",");
				BucketManager.Batch ops = new BucketManager.Batch().delete(BUCKET_NAME, tmps);
				
				Response r = bucketManager.batch(ops);
				BatchStatus[] bs = r.jsonToObject(BatchStatus[].class);
			    for (BatchStatus b : bs) {
			    	flag |= (b.code == 200) ? 1 : 0;
			        System.out.println( b.code + ":" + b.toString() );
			    }
			} else {
				flag =0;
			}
		} catch (QiniuException e) {
			e.printStackTrace();
			return false;
		}
		return flag == 1 ? true : false;
	}

	public static List<String> queryResources(Integer maxResource){
		if( maxResource <= 0 ){
			maxResource = 100;//默认最多显示100条
		}
		List<String> keys = new ArrayList<String>();
		
		Auth auth = Auth.create(AK,	SK);
		BucketManager bucketManager = new BucketManager(auth);
		
		BucketManager.FileListIterator it = bucketManager.createFileListIterator(BUCKET_NAME, "", maxResource, null);

		while (it.hasNext()) {
		    FileInfo[] items = it.next();
		    if (items.length > 1) {
		        for( FileInfo info : items ){
		        	System.out.println(info.key);
		        	keys.add( info.key );
		        }
		    }
		}
		
		return keys;
	}
}
