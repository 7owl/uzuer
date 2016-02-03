package com.lingtong.bo;

import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;

import com.lingtong.model.Hosts;
import com.lingtong.model.Image;
/**
 * @author xqq
 * @date 2015-8-2 上午11:49:07
 * 
 */
public interface ImageBo {
	/**
	 * 
	 * @param myfiles,上传的文件
	 * @param dir,临时存放的路径
	 * @param room_id,关联房源
	 * @return
	 */
	public Map<String, Object> upload( MultipartFile[] myfiles, String dir, Integer room_id);
	
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
	 * 更改图片的picname,作为排序的字段
	 * @param list
	 */
	public Map<String, Object> updateImageSort(List<Image> list);
}
