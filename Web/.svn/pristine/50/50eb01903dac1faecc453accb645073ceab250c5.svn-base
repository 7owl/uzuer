package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.lingtong.model.Image;

/**
 * @author xqq
 * @date 2015-8-11 下午9:24:38
 * 
 */
public interface ImageDao {
	/**
	 * 
	 * @param myfiles,上传的文件
	 * @param dir,临时存放的路径
	 * @param roome_id,关联的房源
	 * @return
	 */
	public Map<String, Object> upload(MultipartFile[] myfiles, String dir, Integer room_id);
	
	/***
	 * 逻辑上删除图片,status置0
	 * @param delids
	 * @return
	 */
	public Map<String , Object> delete(String delids);
	
	/***
	 * 根据房源获得图片
	 * @param delids
	 * @return
	 */
	public Map<String , Object> queryByRoomId(String room_id);

	public Object getImageListById(String id);
	
	public Map<String, Object>  getIdAuthPic(String id);

	/**
	 * @param list
	 * @return
	 */
	public Map<String, Object> updateImageSort(List<Image> list);

	public List<Image> getPicByRoomNo(String parameter);
	
}
