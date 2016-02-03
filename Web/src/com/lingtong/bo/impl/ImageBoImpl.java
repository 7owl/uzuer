package com.lingtong.bo.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.lingtong.bo.ImageBo;
import com.lingtong.dao.ImageDao;
import com.lingtong.model.Image;
import com.lingtong.model.Pagination;
import com.lingtong.model.Hosts;

/**
 * @author xqq
 * @date 2015-8-2 上午11:49:07
 * 
 */
@Component("imageBoImpl")
public class ImageBoImpl implements ImageBo{
	@Resource(name="imageDaoImpl")
	private ImageDao imageDao;
	
	public Map<String, Object> upload( MultipartFile[] myfiles, String dir, Integer room_id){
		return imageDao.upload(myfiles, dir, room_id);
	}

	public Map<String, Object> delete(String delids) {
		return imageDao.delete(delids);
	}

	public Map<String, Object> queryByRoomId(String room_id) {
		return imageDao.queryByRoomId(room_id);
	}

	public Object getImageListById(String id) {
		return imageDao.getImageListById(id);
	}

	public Map<String, Object>  getIdAuthPic(String id) {
		return imageDao.getIdAuthPic(id);
	}

	public Map<String, Object> updateImageSort(List<Image> list) {
		return imageDao.updateImageSort(list);
	}
}
