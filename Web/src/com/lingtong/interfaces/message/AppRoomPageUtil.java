package com.lingtong.interfaces.message;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;

import com.lingtong.util.CalDistance;

/**
 * @author xqq
 * @date 2015-8-23 下午1:05:25
 * 
 */
public class AppRoomPageUtil {
	private static AppRoomPageUtil app = null;
	
	private AppRoomPageUtil() {}
	
	public static AppRoomPageUtil getInstance(){
		if( app == null ){
			app = new AppRoomPageUtil();
		}
		return app;
	} 
	
	public String getPageSql( AppRoomPage page, String lonAndLat, boolean isPage){
		StringBuilder where = new StringBuilder();
		StringBuilder order  = new StringBuilder();
		/********************************************筛选开始**************************************************/
		List<String> conds = new ArrayList<String>();
		if( page == null ){
			return " limit 0, 20";
		}
		
		Map<String, String> filter = page.getFilter();
		if( filter != null){
			Iterator<String> iter = filter.keySet().iterator();
			
			while( iter.hasNext() ){
				String key = iter.next();
				String value = filter.get(key);
				
				if( isNull(key, value, "price") && value.indexOf(",") != -1){
					String[] vals = value.split(",");
					if( vals.length == 2 &&NumberUtils.isNumber( vals[0] ) && NumberUtils.isNumber( vals[1] ) ){
						Integer min = Integer.valueOf( vals[0] );
						Integer max = Integer.valueOf( vals[1] );
						
						conds.add( " (price >= " + min + " and price <= " + max + ") ");
					}
				} else if( isNull(key, value, "kind") ){//问题三室以上,怎么弄
					if( "三室以上".equals( value ) ){
						conds.add( " ( kind not like '%1室%' and kind not like '%2室%' and kind not like '%3室%' ) " );
					} else {
						conds.add( " ( kind like '%" + value + "%' ) " );
					}
				} else if( isNull(key, value, "rental_end_time") ){//小于,大于由前台控制
					if( NumberUtils.isNumber( value )){
						if( Integer.parseInt( value ) > 31 ){
							conds.add( " ( status = '0' or (Datediff(DATE_FORMAT( rental_end_time, '%Y-%m-%d'), now()) > " + value + ") and  Datediff(DATE_FORMAT( rental_end_time, '%Y-%m-%d'), now() <= 60 ) )" );
						} else {
							conds.add( " ( status = '0' or Datediff(DATE_FORMAT( rental_end_time, '%Y-%m-%d'), now()) < " + value + ") " );
						}
					}
					
				} else if( isNull(key, value, "decoration") ){
					conds.add( " ( decoration like '%" + value + " %' ) " );
				} else if( isNull(key, value, "createtime") ){//房源登记在七天之内,creatTime有值的话,随便填
					conds.add( " ( Datediff(now(), DATE_FORMAT(createtime, '%Y-%m-%d') ) < 7 ) " );
				}  
			}
		}
		
		if( conds.size() > 0){
			//where.append( " where " + StringUtils.join( conds.toArray(new String[]{}) , "and") );
			//page.setCurPage(0);
			where.append( " and " + StringUtils.join( conds.toArray(new String[]{}) , "and") );
		} else {//默认条件,60天之内
			where.append( " and ( status = '0' or Datediff(DATE_FORMAT( rental_end_time, '%Y-%m-%d'), now() <= 60 ) )" );
		}
		/********************************************筛选结束**************************************************/
		
		if( isPage == false ){
			return where.toString();
		}
		/********************************************排序开始**************************************************/
		if( page.getSort() == null ){
			if( where.toString().equals("")){
				return " limit " + page.getCurPage() * page.getRows() + ", " + page.getRows();
			}
			return where.toString();
		}
		
		List<String> sorts = new ArrayList<String>();
		
		Map<String, String> sort = page.getSort();
		if( sort != null){
			Iterator<String> iter = sort.keySet().iterator();
			
			while( iter.hasNext() ){
				String key = iter.next();
				String value = sort.get(key);
				
				if( isNull(key, value, "price") ){//"1"是升序,"0"是降序
					if( "1".equals( value ) ){
						sorts.add( " price asc " );
					} else if( "0".equals( value ) ){
						sorts.add( " price desc " );
					}
				} else if( isNull(key, value, "size") ){//"1"是升序,"0"是降序
					if( "1".equals( value ) ){
						sorts.add( " size asc " );
					} else if( "0".equals( value ) ){
						sorts.add( " size desc " );
					}
				} else if( isNull(key, value, "distance") && StringUtils.isNotBlank( lonAndLat ) && lonAndLat.indexOf(",") != -1 ){//"1"是升序,"0"是降序
					String[] pos = lonAndLat.split(",");
					if( pos.length == 2 && NumberUtils.isNumber( pos[0] ) && NumberUtils.isNumber( pos[1] ) ){
						Double lon = Double.valueOf( pos[0] );//经度
						Double lat = Double.valueOf( pos[1] );//纬度
						String tmp = CalDistance.getDistanceBylonAndLat(lon, lat);
						if( "1".equals( value ) ){
							sorts.add( " " + tmp + " asc " );
						} else if( "0".equals( value ) ){
							sorts.add( " " + tmp + " desc " );
						}
					}
				} else if( isNull(key, value, "createtime") ){//creatTime,"1"是升序,"0"是降序
					if( "1".equals( value ) ){
						sorts.add( " createtime asc " );
					} else if( "0".equals( value ) ){
						sorts.add( " createtime desc " );
					}
					
				}  
			}
		}
		if( sorts.size() > 0){
			order.append( " order by  " + StringUtils.join( sorts.toArray(new String[]{}) , ",") );
		}
		/********************************************排序结束**************************************************/
		Integer start = page.getCurPage() * page.getRows();
		return where.append( order.toString() ).append( "limit " + start + " ," + page.getRows() ).toString();
	}
	
	private boolean isNull( String key, String value, String filterFilter ){
		if( filterFilter.equals( key ) && StringUtils.isNotBlank( value ) ){
			return true;
		}
		return false;
	}
	
}
