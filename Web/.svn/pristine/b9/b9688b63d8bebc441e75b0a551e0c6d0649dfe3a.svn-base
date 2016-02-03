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
		<title>管理房源图片</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!-- 使用 bootstrap 管理图片  -->
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bootstrap.css">
		<style>
			body { 
				overflow-x : hidden; 
			}
		</style>
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
 		<script type="text/javascript" src="<%=basePath%>js/bootstrap.js"></script>
 		<script type="text/javascript" src="<%=basePath%>js/system/uploadpic.js"></script>

	</head>

	<body>
		<input type="hidden" id="room_id_pic" value="${room_id}" />
        <!-- 首部 start -->
        <div class="row">
        	<div class="col-xs-8 col-xs-offset-2">
			  	<div class="btn-group  pull-right" style="margin-bottom: 10px"  role="group" aria-label="房源：图片操作">
					<button type="button" class="btn btn-default" data-toggle="modal"  data-target="#myModa2">上传</button>
					<button type="button" class="btn btn-default" data-toggle="modal"  data-target="#myModa3">删除</button>
					<button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModa4">退出</button>
				</div>
            </div>
        </div>
        <!-- 显示图片列表 -->
        <c:forEach items="${imageList}" varStatus="status" var="image">
            <c:choose>
                <c:when test="${status.first or status.index % 4 eq 0}">
                <c:choose>
                	<c:when test="${status.index  eq 0}">
                		<div class="row">
                    	<div class="col-xs-2 col-xs-offset-2 imgDrag" draggable="true">
                    		<a href="javascript:void(0);" class="thumbnail text-center">  
                            	<img name="${image.picname}" value=" ${image.pictime}"
                             		style="width: 140px; height: 130px;" src="${image.url}">
                            	<input class="pull-left" type="checkbox" value="${image.id}" url="${image.url}"  sort="${status.index}"/><span>${status.index}(首选)</span>
                          	</a>
                        </div>
                	</c:when>
                	<c:otherwise>
                    	<div class="row">
                    	<div class="col-xs-2 col-xs-offset-2 imgDrag" draggable="true">
                    		<a href="javascript:void(0);" class="thumbnail text-center">  
                            	<img name="${image.picname}" value=" ${image.pictime}"
                             		style="width: 140px; height: 130px;" src="${image.url}">
                            	<input class="pull-left" type="checkbox" value="${image.id}" url="${image.url}"  sort="${status.index}"/><span>${status.index}</span>
                          	</a>
                        </div>
                    </c:otherwise>
                 </c:choose>
                </c:when>
                <c:when test="${status.index % 4 eq 3 and not status.last }">
	                	<div class="col-xs-2 imgDrag"  draggable="true">
	                    	<a href="javascript:void(0);" class="thumbnail text-center">  
	                            <img name="${image.picname}"  value="${image.pictime}"  style="width: 140px; height: 130px;" src="${image.url}">
	                            <input class="pull-left" type="checkbox" value="${image.id}" url="${image.url}" sort="${status.index}"/><span>${status.index}</span>
	                        </a>
	                        </div>
	                    </div>
                	</div>
                </c:when>
                <c:otherwise>
                    <div class="col-xs-2 imgDrag" draggable="true">
                        <a href="javascript:void(0);" class="thumbnail text-center">  
	                        <img name="${image.picname}" value=" ${image.pictime}" style="width: 140px; height: 130px;" src="${image.url}">
	                        <input class="pull-left" type="checkbox" value="${image.id}" url="${image.url}" sort="${status.index}"/><span>${status.index}</span>
                        </a> 
                    </div>
                </c:otherwise>
            </c:choose>
            <c:if test="${status.last}">
                </div>
            </c:if>
        </c:forEach>
        <!-- 显示图片列表 end -->
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="myModalLabel"></h4>
          </div>
          <div class="modal-body" id="modal-content">
          </div>
        </div>
      </div>
    </div>
    <!-- 显示图片对话框 end -->
    <!-- 上传图片对话框 start -->
    <div class="modal fade" id="myModa2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title" id="myModalLabe2">图片上传</h4>
          </div>
          <div class="modal-body">
              <form class="form-horizontal" role="form" id="form">
              <div class="form-group">
                <div class="col-xs-4">
                    <input type="file" id="image" name="image" multiple="multiple"/>
                </div>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="button" class="btn btn-primary" id="upload">上传</button>
          </div>
        </div>
      </div>
    </div>
    <!-- 上传图片对话框 end -->
    <!-- 删除图片对话框 start -->
    <div class="modal fade" id="myModa3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title" id="myModalLabe3">确定删除吗？</h4>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="button" class="btn btn-danger" id="delete">确定</button>
          </div>
        </div>
      </div>
    </div>
    <!-- 删除图片对话框 end -->
    <!-- 退出对话框 start -->
    <div class="modal fade" id="myModa4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title" id="myModalLabe4">确定退出吗？</h4>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="button" class="btn btn-danger" onclick="pagecancel()" >确定</button>
          </div>
        </div>
      </div>
 	
 	<script type="text/javascript" src="<%=basePath%>js/underscore.js"></script>
	</body>
</html>
