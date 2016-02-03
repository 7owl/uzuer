package com.lingtong.dao.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.lingtong.dao.ImageDao;
import com.lingtong.model.IdImage;
import com.lingtong.model.Image;
import com.lingtong.model.Tenants;
import com.lingtong.util.FileUtils;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.SpringManage;
import com.lingtong.vo.RoomVo;

/**
 * @author xqq
 * @date 2015-8-11 下午9:25:51
 * 
 */
@Component("imageDaoImpl")
public class ImageDaoImpl implements ImageDao {
	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> upload(MultipartFile[] myfiles, String dir,
			Integer room_id) {
		Map<String, Object> results = new HashMap<String, Object>();
		StringBuilder errors = new StringBuilder();
		String[] fileTypes = new String[] { "gif", "jpg", "jpeg", "png", "bmp" };
		List<Image> imgs = new ArrayList<Image>();
		for (MultipartFile myfile : myfiles) {
			Image img = new Image();
			String oldFileName = myfile.getOriginalFilename();
			String ext = FilenameUtils.getExtension(oldFileName);// 扩展名
			if (StringUtils.isNotBlank(ext)
					&& ArrayUtils.indexOf(fileTypes, ext.toLowerCase()) != -1) {
				
				String partname = System.currentTimeMillis() +"" ; 
				
				String newFileName = partname + "." + ext;
				String newthumbFileName = partname + ".thumb." + ext;
				try {
					File imgfile=  FileUtils.stream2File(myfile.getInputStream(),
							FilenameUtils.concat(dir, newFileName));
					System.out.println("imgfile.getName() : " + imgfile.getName());	
					File thumbimgfile= FileUtils.stream2File(myfile.getInputStream(),
							FilenameUtils.concat(dir, newthumbFileName));
					System.out.println("thumbimgfile.getName() : " + thumbimgfile.getName());
				} catch (IOException e) {
					e.printStackTrace();
				}
				Boolean isSuccess = FileUtils.upload(new File(FilenameUtils
						.concat(dir, newFileName)));
				Boolean isSuccess1 = FileUtils.upload(new File(FilenameUtils
						.concat(dir, newthumbFileName)));
				if (isSuccess && isSuccess1) {
					String[] fields = new String[] { "url", "picname",
							"pictime", "room_id" };
					String[] values = new String[] { "?", "?", "?", "?" };
					Object[] vals = new Object[] { newFileName, oldFileName,
							img.getPictime(), room_id };
					Object[] vals2 = new Object[] { newthumbFileName, oldFileName,
							img.getPictime(), room_id };
					String insert = "insert into " + Image.TABLENAME + "("
							+ StringUtils.join(fields, ",") + ") values("
							+ StringUtils.join(values, ",") + ")";
					String insertthumb = "insert into " + Image.TABLENAME + "("
							+ StringUtils.join(fields, ",") + ") values("
							+ StringUtils.join(values, ",") + ")";
					int affected = jdbcTemplate.update(insert, vals);
					int affected1 = jdbcTemplate.update(insertthumb, vals2);
					System.out.println("图片插入语句:" + insert);

					if (affected > 0) {
						String query = "select last_insert_id() as id from "
								+ Image.TABLENAME + " limit 1";
						System.out.println("图片id查询语句:" + query);
						int id = jdbcTemplate.queryForInt(query);
						img.setId(id);
						String url = FileUtils.downloadUrl2(newFileName);
						img.setUrl(url);
						imgs.add(img);
					} else {
						errors.append("文件:" + oldFileName + " 保存失败...");
					}
				} else {
					errors.append("文件:" + oldFileName + " 上传失败...");
				}
			} else {
				errors.append("文件:" + oldFileName + " 不是图片...\n");
			}
		}
		if (imgs.size() > 0) {
			// 往房源表的picture冗余字段,更新图片名字
			results.put("success", imgs);
		}
		if (StringUtils.isNotBlank(errors.toString())) {
			results.put("error", errors.toString());
		}
		return results;
	}

	public List<Image> getImageListById(String id) {
		List<Image> imageList = new ArrayList<Image>();
		String sql = "select * from " + Image.TABLENAME + " where room_id ="
				+ id + " and status = 1 and url like '%thumb%' order by picname asc";
		List result = jdbcTemplate.queryForList(sql);
		for (int i = 0; i < result.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) result.get(i);
			Image image = new Image();
			LTBeanUtils.getInstance().Map2Bean(map, image);
			/*if (!image.getUrl().contains(".thumb.")) {
				continue ;
			}*/
			image.setUrl(FileUtils.downloadUrl2(image.getUrl()));
			System.out.println(image.getUrl());
			imageList.add(image);
		}
		return imageList;
	}

	public Map<String, Object> updateImageByID(String ids) {
		Map<String, Object> result = new HashMap<String, Object>();
		String sql = " update " + Image.TABLENAME
				+ "set status = 0 where id in (" + ids + ")";
		String[] allId = ids.split(",");
		int afftected = jdbcTemplate.update(sql);
		if (afftected > 0) {
			result.put("success", "成功删除了" + afftected + " 条数据");
		} else {
			result.put("error", "删除失败");
		}
		return result;
	}

	public Map<String, Object> delete(String delids) {
		// 删除图片
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isBlank(delids)) {
			map.put("error", "请选中要删除的数据");
			return map;
		}
		/*String[] ids = delids.split(",");
		StringBuilder sb = new StringBuilder("update " + Image.TABLENAME
				+ " set status = 0 where id in(" +

				StringUtils.join(ids, ",") + ")");*/
		
		String[] urls = delids.split(",");
		String[] conds = new String[ urls.length ];
		for( int i = 0; i < urls.length; i++ ){
			String url = urls[i];
			conds[i] = "(url like '%" + url + "%')";
		}
		StringBuilder sb = new StringBuilder("update " + Image.TABLENAME
				+ " set status = 0 where " +
				StringUtils.join(conds, " or ") );

		System.out.println("ImageDaoImpl.delete() Sql : " + sb.toString());
		int affected = jdbcTemplate.update(sb.toString());
		if( affected > 0 ){
			affected = urls.length;
		}
		map.put("success", "已经成功删除" + affected + "张图片...");
		return map;
	}

	public Map<String, Object> queryByRoomId(String room_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (!NumberUtils.isNumber(room_id)) {
			map.put("error", "房源不存在...");
			return map;
		}
		StringBuilder sb = new StringBuilder("select * from " + Image.TABLENAME
				+ " where room_id = ? and status != 0"

		);
		System.out.println("ImageDaoImpl.queryByRoomId() Sql : "
				+ sb.toString());
		List list = jdbcTemplate.queryForList(sb.toString(),
				new Object[] { room_id });

		List<Image> imgs = new ArrayList<Image>();
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> row = (Map<String, Object>) list.get(i);
			Image img = new Image();
			LTBeanUtils.getInstance().Map2Bean(row, img);
			String url = FileUtils.downloadUrl2(img.getUrl());
			img.setUrl(url);
			System.out.println(img.getUrl());
			img = getThumbImg(img);
			imgs.add(img);
		}
		map.put("success", imgs);
		return map;
	}
	
	/**
	 * 调用七牛的接口处理 直接获取图片缩略图
	 */
	private Image getThumbImg (Image img) 
	{
		String[] oldUrl  = img.getUrl().split(",");
		
		StringBuilder newurl = new StringBuilder();
		for (int  i = 0;  i < oldUrl.length;  i++) {
			String url = oldUrl[i] ;
			if (oldUrl[i].contains(".thumb.")) {
				url += "?imageMogr2/thumbnail/750x374&";
			}
			newurl.append(",").append(url);
		}
		img.setUrl(newurl.toString().substring(1,newurl.length()));	
		System.out.println("处理之后的："+img.getUrl());
		return img ;
	}

	public Map<String, Object> getIdAuthPic(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (!NumberUtils.isNumber(id)) {
			map.put("error", "房客不存在...");
			return map;
		}
		StringBuilder sb = new StringBuilder("select * from " + IdImage.TABLENAME +" where tenant_id = ? and status != 0");
		System.out.println("ImageDaoImpl.Tenant() Sql : "
				+ sb.toString());
		List list = jdbcTemplate.queryForList(sb.toString(),
				new Object[] { id });
		List<IdImage> imgs = new ArrayList<IdImage>();
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> row = (Map<String, Object>) list.get(i);
			IdImage img = new IdImage();
			LTBeanUtils.getInstance().Map2Bean(row, img);
			String url = FileUtils.downloadUrl2(img.getUrl());
			img.setUrl(url);
			System.out.println(img.getUrl());
			imgs.add(img);
		}
		map.put("success", imgs);
		return map;
	}


	public Map<String, Object> updateImageSort(List<Image> list) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		if( list != null && list.size() > 0){
			for( int i = 0; list.size() > i; i++ ){
	        	Image img = list.get(i);
	        	StringBuilder sql = new StringBuilder();
	        	sql.append("update " + Image.TABLENAME + " set picname = ? where id = ?");
	        	jdbcTemplate.update(sql.toString(), new Object[]{img.getPicname(), img.getId()} );
	        }
		}
		result.put("code", "0");
		result.put("msg", "修改图片排序顺序成功...");
		return result;
	}

	public List<Image> getPicByRoomNo(String parameter) {
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		String sql= "select picture from "+ RoomVo.VIEWNAME +" where roomSeq = '"+parameter +"'";
		System.out.println(sql );
		String pic = jdbcTemplate.queryForObject(sql,String.class);
		String defaultpic="http://7xl031.com1.z0.glb.clouddn.com/11.jpg";
		List<Image> images = new ArrayList<Image>();
			if (StringUtils.isNotEmpty(pic)) {
				String[] room = pic.split(",");
				System.out.println(room.length+ "  pic " + pic );
				for (int i = 0; i < room.length; i++) {
					Image image = new Image();
					if (!StringUtils.isEmpty(room[i])&&room[i].contains("thumb")) {
						image.setUrl(FileUtils.downloadUrl2(room[i]));
						images.add(image);
					}
				}
				if (room.length==0) {
					Image image = new Image();
					image.setUrl(defaultpic);
					images.add(image);
//					roompics.add(defaultpic);
				}
			}else {
				Image image = new Image();
				image.setUrl(defaultpic);
				images.add(image);
			}
		return images;
	}
}
