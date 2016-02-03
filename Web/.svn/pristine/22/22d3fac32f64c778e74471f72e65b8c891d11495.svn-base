<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>查看房源信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<!-- <meta http-equiv="description" content="This is my page"> -->
		<link type="text/css" href="<%=basePath%>css/index.css" rel="Stylesheet" />
	 	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/icon.css">
		<%-- <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bootstrap.css"> --%>
		<%-- <script type="text/javascript" src="<%=basePath%>js/jquery-1.11.3.min.js"></script> --%>
 		<script type="text/javascript" src="<%=basePath%>js/easyui/jquery-1.4.4.min.js"></script> 
		<script type="text/javascript" src="<%=basePath%>js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/easyui/easyui-lang-zh_CN.js"></script>
		<%-- <script type="text/javascript" src="<%=basePath%>js/bootstrap.js"></script> --%>
		
		<style type="text/css">
			#w_Add label {
 				 display: inline-block;
 				 width: 80px;
 				 font-size: 10px
			}
			#w_Add input {
 				 width: 250px;
			}
		</style>
		
	</head>

	<body>
		<div>
			<table id="test" toolbar="#tb"></table>
			<div id="tb" style="padding: 2px 0">
				<table cellpadding="0" cellspacing="0" style="width: 100%">
					<tr>
						<td>
							<select id="queryType">
								<option value="">
									--请选择--
								</option>
								<option value="room.roomSeq">
									房源编号
								</option>
								<option value="room_name">
									房源名
								</option>
								<option value="comm_name">
									所在小区
								</option>
								<option value="kind">
									户型
								</option>
								<option value="rental_end_time">
									入住时间
								</option>
								<option value="decoration">
									精装修
								</option>
								<option value="price">
									价格
								</option>
							</select>
							<input id="queryWord" type="text" name="queryWord" class="selCond"/>
							<select id="kind-sel" style="display:none;" class="selCond">
								<option value="1室">一室</option>
								<option value="2室">二室</option>
								<option value="3室">三室</option>
								<option value="三室以上">三室以上</option>
							</select>
							<select id="rental_end_time-sel" style="display:none;" class="selCond">
								<option value="8">七天内</option>
								<option value="16">十五天内</option>
								<option value="30">三十天内</option>
								<option value="31">三十天后</option>
							</select>
							<select id="decoration-sel" style="display:none;" class="selCond">
								<option value="毛坯">毛坯</option>					
								<option value="简修">简修</option>					
								<option value="中等">中等</option>					
								<option value="精装">精装</option>					
								<option value="豪华">豪华</option>	
							</select>
							<input id="minprice" type="text" placeholder="请输入租金(低)" style="display:none;" class="selCond"/>&nbsp;&nbsp;
							<input id="maxprice" type="text" placeholder="请输入租金(高)" style="display:none;" class="selCond"/>
							<%--<select>
								<option></option>
							</select>
							--%><a href="javascript:void(0)" onclick="searcher()"
								class="easyui-linkbutton 05" iconCls="icon-search" plain="true" style="display:'';color:green;">搜索</a>
							<a href="javascript:void(0)" onclick="openWindow()"  
    							class="easyui-linkbutton 02" iconCls="icon-add" plain="true" style="display:'';color:green;">添加</a>
							<a href="javascript:void(0)" onclick="del()"  
    							class="easyui-linkbutton 03" iconCls="icon-cut" plain="true" style="display:'';color:green;">删除</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 添加,修改窗口 -->
	    <div id="w_Add" class="easyui-window" title="" iconCls="icon-save"
	    	 style="width:1200px;height:540px;padding:5px;">
	    	<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
	    	<form id="saveForm"></form> 
	    	</div>
	    	<div region="south" border="false" style="text-align:right;padding:5px 0;">
	    		<a class="easyui-linkbutton button" iconCls="icon-ok"
						href="javascript:void(0)" onclick="save()">保存</a>
				<a class="easyui-linkbutton" iconCls="icon-cancel"
						href="javascript:void(0)" onclick="cancel()">取消</a>
	    	</div>
	    </div>
	    	
		<!-- 图片 -->
	    <div id="w_image" class="easyui-window" title="" iconCls="icon-save"
	    	 style="width:1000px;height:500px;padding:5px; ">
		</div>
 
    
		
		
		<script type="text/x-handlebars-template" id="tmp_save">
	
		<table style="width:99%">
			<tr style="width:99%">
				<td style="width:30%; margin-left:5px;border-right:1px solid #000;vertical-align:top;">
					<span style="color:red;">基本信息</span><br><br>
					
					<label for="comm_id">所在小区</label>
    				<select name="comm_id" id="comm_id">
						<option>---请选择---</option>
					<select><br><br>				

					<label for="company_id">公司名称</label>
					<select name="company_id" id="company_id"></select><br><br>					

					<label for="room_host">房东姓名</label>
					<select name="room_host" id="room_host"></select><br><br>

					<label for="room_name">房源地址</label>
    				<input type="text" name="room_name" id="room_name" placeholder="请输入详细地址（单元/幢等）" value="{{getValue room_name}}">
					
					<input type="hidden" name="address" id="address" value="{{getValue comm_address}}"><br><br>
					<label for="size">面积</label>
    				<input type="text" name="size" id="size" placeholder="请输入面积" value="{{getValue size}}"><br><br>
					
					<label for="floor">楼层</label>
    				<input type="text" name="floor" id="floor" placeholder="请输入楼层" value="{{getValue floor}}"><br><br>
					
					<label for="orient">朝向</label>
    				<input type="text" name="orient" id="orient" placeholder="请输入朝向" value="{{getValue orient}}"><br><br>
				
					<label for="price">租金</label>
    				<input type="text" name="price" id="price" placeholder="请输入租金" value="{{getValue price}}"><br><br>
				
				</td>
				<td style="width:30%; padding-left:15px;border-right:1px solid #000;vertical-align:top;" > 
					<span style="color:red;">房源配置信息</span><br><br>
				
						<label for="metro">附近地铁情况</label>
    					<input type="text" name="metro" id="metro" placeholder="请输入附近地铁情况" value="{{getValue metro}}"><br><br>
					
						<label for="occupancy">居住情况</label>
    					<input type="text" name="occupancy" id="email" placeholder="请输入居住情况" value="{{getValue occupancy}}"><br><br>
						
						<label for="smartlock">支持智能锁</label>
						<select name="smartlock" id="smartlock" style="width:250px">
						<option value='0'>不支持</option>
						<option value='1'>支持</option>
						<select><br><br>

						<label for="bed" style="width:11%;">床&nbsp&nbsp</label>
    					<input type="checkbox" name="bed" id="bed"  style="width:5%;"/>|
		
						<label for="wardrobe" style="width:11%;">衣柜</label>
    					<input type="checkbox" name="wardrobe" id="wardrobe" style="width:5%;">|

						<label for="air_conditioning" style="width:11%;">空调</label>
    					<input type="checkbox" name="air_conditioning" id="air_conditioning" style="width:5%;">|
	
						<label for="tv" style="width:11%;">电视</label>
    					<input type="checkbox" name="tv" id="tv" style="width:5%;"><br>

						<label for="gasstove" style="width:11%;">燃气灶</label>
    					<input type="checkbox" name="gasstove" id="gasstove" style="width:5%;">|

						<label for="washing" style="width:11%;">洗衣机</label>
    					<input type="checkbox" name="washing" id="washing" style="width:5%;">|

						<label for="heater" style="width:11%;">热水器</label>
    					<input type="checkbox" name="heater" id="heater" style="width:5%;">|

						<label for="refrigerator" style="width:11%;">冰箱</label>
    					<input type="checkbox" name="refrigerator" id="refrigerator" style="width:5%;"><br>
						
						<label for="microwaveOven" style="width:11%;">微波炉</label>
    					<input type="checkbox" name="microwaveOven" id="microwaveOven" style="width:5%;"><br><br>
						
						<!--
						<label for="balcony" style="width:11%;">阳台</label>
    					<input type="checkbox" name="balcony" id="balcony" style="width:5%;"><br><br>
						-->
					<label for="desc">房源描述</label>
    				<textarea style="height:150px;width:250px;vertical-align:top;" name="desc" id="desc" placeholder="请输入房源描述" >{{getValue desc}}</textarea>
				</td>

				<td style="width:30% ;padding-left:15px;vertical-align:top;">
					<span style="color:red;">app信息</span><br><br>

					<label for="rental_start_time">开始出租时间</label>
    				<input type="text" name="rental_start_time" id="rental_start_time" value="{{getValue rental_start_time}}"><br><br>
					
					<label for="rental_end_time">结束出租时间</label>
    				<input type="text" name="rental_end_time" id="rental_end_time"value="{{getValue rental_end_time}}"><br><br>

					<label for="rental_end_time">装修</label>
    				<select style="width:250px;" name="decoration" id="decoration" value="{{getValue decoration}}">
						<option value="毛坯">毛坯</option>					
						<option value="简修">简修</option>					
						<option value="中等">中等</option>					
						<option value="精装">精装</option>					
						<option value="豪华">豪华</option>					
					</select><br><br>

					<label for="rental_end_time">出租类型</label>
    				<select style="width:250px;" name="rent_type" id="rent_type"value="{{getValue rent_type}}">
						<option value="整租">整租</option>					
					</select><br><br>

					<label for="status">出租情况</label>
					<select name="status" id="status" style="width:250px">
						<option value='0'>未出租</option>
						<option value='1'>已出租</option>
					<select><br><br>
	
					<div style="width:100%;">
						<label for="kind">房间类型</label>
						<input type="hidden" name="kind" id="kind" value="{{getValue kind}}">
						<select name="k1" id="k1" style="width:35px">
							<option value='1'>1</option>
							<option value='2'>2</option>
							<option value='3'>3</option>
							<option value='4'>4</option>
							<option value='5'>5</option>
						<select>室
						<select name="k2" id="k2" style="width:35px">
							<option value='1'>1</option>
							<option value='2'>2</option>
							<option value='3'>3</option>
							<option value='4'>4</option>
							<option value='5'>5</option>
						<select>厅
						<select name="k3" id="k3" style="width:35px">
							<option value='1'>1</option>
							<option value='2'>2</option>
							<option value='3'>3</option>
							<option value='4'>4</option>
							<option value='5'>5</option>
						<select>厨
						<select name="k4" id="k4" style="width:35px">
							<option value='1'>1</option>
							<option value='2'>2</option>
							<option value='3'>3</option>
							<option value='4'>4</option>
							<option value='5'>5</option>
						<select>卫
					</div>
					<br>

					<label for="recommend">推荐名称</label>
					<input type="text" name="recommend" id="recommend" placeholder="推荐名称" value="{{getValue recommend}}"><br><br>
					
					<div>
						<label for="recommendTarget">推荐标签</label>
						<input type="hidden" name="recommendTarget" id="recommendTarget" value="{{getValue recommendTarget}}">		
						<input type="text"  style="width:70px;" name="recommendTarget1" placeholder="Target1" id="recommendTarget1" value="">	||			
						<input type="text"  style="width:70px;" name="recommendTarget2" placeholder="Target2" id="recommendTarget2" value="">	||			
						<input type="text"  style="width:70px;" name="recommendTarget3" placeholder="Target3" id="recommendTarget3" value="">				
					</div><br>
					
					<label for="isRecommend">推荐房源</label>
					<select name="isRecommend" id="isRecommend" style="width:250px" value="{{getValue isRecommend}}">
						<option value='1'>推荐</option>
						<option value='0'>不推荐</option>
					<select>
				</td>
			</tr>


		</table>

      			
		</script>
		<script type="text/javascript" src="<%=basePath%>js/handlebars.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/underscore.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/backbone.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common/common.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/json2.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/system/room.js"></script>
	</body>
</html>
