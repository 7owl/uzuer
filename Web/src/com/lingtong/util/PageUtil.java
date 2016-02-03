package com.lingtong.util;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;

import com.lingtong.model.Pagination;
import com.lingtong.vo.ContractVo;
import com.lingtong.vo.RoomVo;

/**
 * @author xqq
 * @date 2015-8-23 下午12:53:44
 * 
 */
public class PageUtil {
	private static PageUtil util;

	private PageUtil() {}
	
	public static PageUtil getInstance(){
		if( util == null ){
			util = new PageUtil();
		}
		return util;
	}
	
	/***
	 * 根据easyui的分页参数,获得分页sql
	 * @param pagination
	 * @param obj
	 * @param isAnd,是否要加and
	 * @return
	 */
	public String getQueryCondition(Pagination pagination, Class clazz, boolean isPage){
		StringBuilder sql = new StringBuilder();
		
		if( pagination == null || clazz == null ){
			return sql.toString();
		}
		
		String queryType = pagination.getQueryType();
		String queryWord = pagination.getQueryWord();
		
		Integer page = pagination.getPage();
		Integer rows = pagination.getRows();
		String sort = pagination.getSort();
		String order = pagination.getOrder();
		
		String where = getWhereSql(queryType, queryWord, clazz, pagination);
		
		if( StringUtils.isNotBlank( where ) ){
			sql.append( " and " + where );
		}
		
		//排序
		StringBuilder sortCondition = new StringBuilder(" order by ");
		if (StringUtils.isNotBlank( sort) ) {
			sortCondition.append( sort + " ");
			if ( "desc".equals( order ) && "asc".equals( order ) ) {
				sortCondition.append( order );
			}
			sql.append( " " + sortCondition.toString() + " " );
		}
		if( isPage ){
			//分页
			StringBuilder paginationCondition = new StringBuilder();
			if( page > 0 && rows > 0 ){
				paginationCondition .append(" limit ")
				.append( (page-1) * rows )
				.append(" , ").append( rows );
				
				sql.append( paginationCondition.toString() );
			}
		}
		
		return sql.toString();
	}
	
	
	/**
	 * 根据queryType和queryWord拼接where条件
	 * @param queryType
	 * @param queryWord
	 * @param Clazz
	 * @param pagination
	 * @return
	 */
	private String getWhereSql(String queryType, String queryWord, Class Clazz, Pagination pagination){
		StringBuilder where = new StringBuilder();
		
		if( StringUtils.isNotBlank( queryType ) && StringUtils.isNotBlank( queryWord ) ){
			BeanInfo beanInfo;
			try {
				beanInfo = Introspector.getBeanInfo( Clazz );
				PropertyDescriptor[] propertyDescriptors = beanInfo
						.getPropertyDescriptors();
				
				for (PropertyDescriptor property : propertyDescriptors) {
					String key = property.getName();
					
					Method getter = property.getReadMethod();
					Method setter = property.getWriteMethod();
					Class typeClazz = property.getPropertyType();
					//System.out.println( key + ":" + getField( queryType ) );
					if( setter != null && getter != null && key.equals(  getField( queryType )  ) ){//如果有set方法,当成是表字段
						if ( typeClazz.equals(Integer.class) ) {
							if( Clazz.getName().equals(RoomVo.class.getName()) ){
								if( isNull(key, queryWord, "price") && queryWord.indexOf(",") != -1){
									String[] vals = queryWord.split(",");
									if( vals.length == 2 ){
										Integer min = NumberUtils.isNumber( vals[0] ) ? Integer.valueOf( vals[0] ) : Integer.MIN_VALUE ; 
										Integer max = NumberUtils.isNumber( vals[1] ) ? Integer.valueOf( vals[1] ) : Integer.MAX_VALUE ;;
										
										
										where.append( " (price >= " + min + " and price <= " + max + ") ");
									}
								} 
							} else {
								if (NumberUtils.isNumber(String.valueOf( queryWord ))) {
									where.append( " " + queryType + " = " + queryWord + " " );
								}
							}
						} else if (typeClazz.equals(Long.class)) {
							if (NumberUtils.isNumber(String.valueOf( queryWord ))) {
								where.append( " " + queryType + " = " + queryWord + " " );
							}
						} else if (typeClazz.equals(Double.class)) {
							if (NumberUtils.isNumber(String.valueOf( queryWord ))) {
								where.append( " " + queryType + " = " + queryWord + " " );
							}
						} else if (typeClazz.equals(Float.class)) {
							if (NumberUtils.isNumber(String.valueOf( queryWord ))) {
								where.append( " " + queryType + " = " + queryWord + " " );
							}
						} else {
							if( Clazz.getName().equals(RoomVo.class.getName()) ){
								if( Clazz.getName().equals(RoomVo.class.getName()) && isNull(key, queryWord, "kind") ){//问题三室以上,怎么弄
									if( "三室以上".equals( queryWord ) ){
										where.append( " ( kind not like '%1室%' and kind not like '%2室%' and kind not like '%3室%' ) " );
									} else {
										where.append( " ( kind like '%" + queryWord + "%' ) " );
									}
								} else if( isNull(key, queryWord, "rental_end_time") ){//小于,大于由前台控制
									if( NumberUtils.isNumber( queryWord )){
										if( Integer.parseInt( queryWord ) > 31 ){
											where.append( " ( status = 0 or (Datediff(DATE_FORMAT( rental_end_time, '%Y-%m-%d'), now()) > " + queryWord + ") and  Datediff(DATE_FORMAT( rental_end_time, '%Y-%m-%d'), now() <= 60 ) )" );
										} else {
											where.append( " ( status = 0 or Datediff(DATE_FORMAT( rental_end_time, '%Y-%m-%d'), now()) < " + queryWord + ") " );
										}
									}
									
								} else if( isNull(key, queryWord, "decoration") ){
									where.append( " ( decoration like '%" + queryWord + " %' ) " );
								} else if( isNull(key, queryWord, "createtime") ){//房源登记在七天之内,creatTime有值的话,随便填
									where.append( " ( Datediff(now(), DATE_FORMAT(createtime, '%Y-%m-%d') ) < 7 ) " );
								} else {
									where.append( " " + queryType + " like '%" + queryWord + "%' ");
								}
							} else {
								if( Clazz.getName().equals(ContractVo.class.getName()) ){
									if( "sign_time".equals( queryType ) || "end_time".equals( queryType ) ){
										if( StringUtils.isNotBlank( queryWord ) && queryWord.split(",").length == 2){
											String[] times = queryWord.split(",");
											where.append( " (" + queryType + " >= '" + times[0] + "' and " + queryType + " < '" + times[1] + "') ");
										}
									}
								} else {
									where.append( " " + queryType + " like '%" + queryWord + "%' ");
								}
							}
						}
					}
				}
			} catch (IntrospectionException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} finally {
				return where.toString();
			}
		}
		return where.toString();
	}
	
	/***
	 * queryType允许.,即room.id,在反射时,会找不到room.id,拆开,获得id字段
	 * @param queryType
	 * @return
	 */
	private static String getField( String queryType ){
		if( StringUtils.isNotBlank( queryType ) ){
			if( queryType.contains( "." ) ){
				String[] fields = queryType.split("\\.");//正则表达式,.是特殊字段,要转义
				return fields[ fields.length - 1 ];
			}
			return queryType;
		}
		return "";
	}

	private boolean isNull( String key, String value, String filterFilter ){
		if( filterFilter.equals( key ) && StringUtils.isNotBlank( value ) ){
			return true;
		}
		return false;
	}
}
