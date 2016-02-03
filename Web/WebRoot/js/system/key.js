$(function() {
	$('#sendKey').window('close');
	
	$("#layout").layout();
	
	$('#start_date').datetimebox({
	    showSeconds: true
	});
	
	$('#end_date').datetimebox({
	    showSeconds: true
	});
	
	$('#tenant_id').combogrid({
		panelWidth : 350,
		// value:'id',
		idField : 'sciener_openid',
		textField : 'fullname',
		remoteSort : false,
		queryParams : {
			// 关键字
			"queryWord" : "",
			// 关键字类型
			"queryType" : ""
		},
		width : 250,
		url : 'queryTenant',
		columns : [[{
					field : 'username',
					title : '用户名',
					width : 70
				}, {
					field : 'first_name',
					title : '姓名',
					width : 120,
					formatter : function(value, rec, index) {
						return rec["first_name"] + rec["last_name"];
					}
				}, {
					field : 'tel_number',
					title : '联系方式',
					width : 120
				}]],
		filter : function(q, row) {
			var opts = $("#id").combogrid("options");
			return row[opts.textField].indexOf(q) > -1;
		},
		pagination : true,
		pageSize : 10,// 页数
		pageList : [10, 15, 20, 25, 30]// 每页多少条记录
	});
	
	// 表格控件
	$('#test').datagrid({
		width : 'auto',
		height : 'auto',
		nowrap : false,
		striped : true,
		collapsible : true,
		url : 'queryKey',
		sortName : 'key_id',
		sortOrder : 'desc',
		remoteSort : false,
		queryParams : {
			// 关键字
			"queryWord" : "",
			// 关键字类型
			"queryType" : "",
			//是否调用接口,查询数据
			isInvocated: "no"
		},
		loadMsg : '正在加载中.....',
		idField : 'key_id',
		frozenColumns : [[{
					field : 'c',
					title : '全选',
					checkbox : true,
					align : 'center'
				}]],
		columns : [[{
			field : 'roomSeq',
			title : '房源编号',
			width : 110,
			sortable : true
				}, {
					field : 'comm_address',
					title : '小区地址',
					width : 160,
					sortable : false
				}, {
					field : 'comm_name',
					title : '小区名称',
					width : 100,
					sortable : false
				}, {
					field : 'room_name',
					title : '房源详细地址',
					width : 110,
					sortable : false
				}, {
					field : 'fullname',
					title : '接收人',
					width : 50,
					sortable : false
				},	{
					field : 'room_id',
					title : '锁编号',
					width : 50,
					sortable : true
				}, {
					field : 'key_id',
					title : '钥匙编号',
					width : 60,
					sortable : true
				}, {
					field : 'date',
					title : '钥匙发送时间',
					width : 100,
					sortable : true,
					formatter : function(value, rec, index) {
						console.log(value);
						console.log(new Date().getTime());
						var now = new Date();
						now.setTime(value);
						return moment(now).format("YYYY-MM-DD HH:mm:ss");
					}
				}, {
					field : 'start_date',
					title : '有效开始时间',
					width : 100,
					sortable : true,
					formatter : function(value, rec, index) {
						if( value == 0 ){
							return "永久";
						} else {
							var now = new Date();
							now.setTime(value);
							return moment(now).format("YYYY-MM-DD HH:mm:ss");
						}
					}
				}, {
					field : 'end_date',
					title : '有效结束时间',
					width : 100,
					sortable : true,
					formatter : function(value, rec, index) {
						if( value == 0 ){
							return "永久";
						} else {
							var now = new Date();
							now.setTime(value);
							return moment(now).format("YYYY-MM-DD HH:mm:ss");
						}
					}
				}, {
					field : 'sciener_is_freeze',
					title : '科技侠冷/解冻',
					width : 100,
					sortable : true,
					formatter : function(value, rec, index) {
						if( value == 1 ){//已冻结,
							return '<span class="l-btn-left" style="padding-left: 20px;color:red;">已冻结</span>';
						} else {
							return '<span class="l-btn-left" style="padding-left: 20px;color:green;">未冻结</span>';
						}
					}
				}, {
					field : 're',
					title : '操作',
					width : 200,
					align : 'center',
					formatter : function(value, rec, index) {
						var str = "<a style='display:'';color:green' class='' href='javascript:void(0)' onclick='del("
							+ index + ")'>删除</a>&nbsp;"; 
						if( rec["sciener_is_freeze"] == 1 ){
							str += "<a style='display:'';color:green' class='' href='javascript:void(0)' onclick='freeze("
								+ index + ")'>解冻</a>&nbsp;"; 
						} else {
							str += "<a style='display:'';color:red' class='' href='javascript:void(0)' onclick='freeze("
								+ index + ")'>冻结</a>&nbsp;"; 
						}
						return str;
					}
				}]],
		pagination : true,
		pageSize : 10,// 页数
		pageList : [10, 15, 20, 25, 30],// 每页多少条记录
		rownumbers : true,
		onLoadSuccess : function() {
			// $.getScript("js/own/power.js");
		}
	});
	
	//房源控件
	$('#keyTable').datagrid({
		width : 'auto',
		height : '370',
		nowrap : false,
		striped : true,
		collapsible : true,
		url : 'queryLockRoom',
		sortName : 'room.id',
		sortOrder : 'desc',
		remoteSort : false,
		queryParams : {
			// 关键字
			"queryWordRoom" : "",
			// 关键字类型
			"queryTypeRoom" : ""
		},
		loadMsg : '正在加载中.....',
		idField : 'id',
		frozenColumns : [[{
					field : 'c',
					title : '全选',
					width : 10,
					checkbox : true,
					align : 'center'
				}]],
		columns : [[
				// {field:'id',title:'',width:0,sortable:true},
				{
			field : 'roomSeq',
			title : '房源编号',
			width : 110,
			sortable : true
		}, {
			field : 'comm_address',
			title : '小区地址',
			width : 160,
			sortable : false
		}, {
			field : 'comm_name',
			title : '小区名称',
			width : 100,
			sortable : false
		}, {
			field : 'room_name',
			title : '房源详细地址',
			width : 110,
			sortable : false
		}, {
			field : 'fullname',
			title : '房东名称',
			width : 60,
			sortable : true
		}, {
			field : 'companyname',
			title : '公司名称',
			width : 60,
			sortable : true
		}, {
			field : 'status',
			title : '状态',
			width : 50,
			sortable : true,
			formatter : function(value, rec, index) {
				if( value == 1 ){
					return '<span class="l-btn-left" style="padding-left: 2px;color:green;">已出租</span>';
				} else {
					return '<span class="l-btn-left" style="padding-left: 2px;color:red;">未出租</span>';
				}
			}
		}]],
		pagination : true,
		pageSize : 10,// 页数
		pageList : [10, 15, 20, 25, 30],// 每页多少条记录
		rownumbers : true,
		onLoadSuccess : function() {
		}
	});
	
});

// 点击搜索
function searcher() {
	if( $('#queryType').val() == "identity_valid" ){
		var val = $('#queryWord').val();
		if( val != "0" && val != "1" && $.trim(val) != ""){
			return $.messager.alert('警告', '请输入0,表示未通过;或输入1,表示通过', 'warning');
		}
	}
	$("#test").datagrid('load', {
		// 关键字内容
		"queryWord" : $('#queryWord').val(),
		// 关键字类型
		"queryType" : $('#queryType').val() == "id" ? "room.id" : $('#queryType').val(),
		"isInvocated": "no"
	});
}

//点击搜索
function searcherRoom() {
	$("#keyTable").datagrid('load', {
		// 关键字内容
		"queryWord" : $('#queryWordRoom').val(),
		// 关键字类型
		"queryType" : $('#queryTypeRoom').val() == "id" ? " room.id" : $('#queryTypeRoom').val() 
	});
}

function cancel() {
	$('#w_Add').window('close');
	$('#w_idAuth').window('close');
	$('#sendKey').window('close');
}

function updatebuttonchage() {
	$('.button').linkbutton('enable');
}

function openSendWindow(){
	$('#sendKey').window({
		title : '发送电子锁',
		iconCls : 'icon-save',
		modal : true,
		height : 480
	});
	$('#sendKey').window('open');
}

function send(){
	var g = $('#tenant_id').combogrid('grid');
	var r = g.datagrid('getSelected');
	var openid = r.sciener_openid;
	var tenant_id = r.id;
	if( openid == "" || !openid ){
		$.messager.alert('信息', "请至少选择一个要发送的对象", 'info');
		return;
	}
	var recs = $('#keyTable').datagrid("getSelections");
	var locks = _.map(recs, function(rec){
		return rec.roomid;
	});
	var rooms = _.map(recs, function(rec){
		return rec.id;
	}); 
	if( locks.length == 0 ){
		$.messager.alert('信息', "请至少选择一个要发送的房源", 'info');
		return ;
	}
	//console.log(moment(start_date).unix()*1000);
	//return;
	var start_date = $("#start_date").datetimebox('getValue');
	start_date = start_date == "" ? 0 : moment(start_date).unix()*1000;
	var end_date = $("#end_date").datetimebox('getValue');
	end_date = end_date == "" ? 0 : moment(end_date).unix()*1000;
	$.ajax({
		type : "POST",
		dataType : 'json',// 接受数据格式
		url : 'sendKey',
		data : {
			tenantid : tenant_id,
			roomids  : rooms.join(","),
			locks  : locks.join(","),
			start_date : start_date,
			end_date   : end_date,
			openid: openid
		},
		success : function(resp) {
			$.messager.alert('信息', resp.msg, 'info');
			$('#test').datagrid('reload');
		}
	});
	//console.log(rooms.join(","));
}


function freeze(index){//冻结钥匙
	if (_.isNumber(index)) {// 修改
		var rec = $('#test').datagrid('getRows');
		var key = rec[index];
		if( key ){
			var key_id = key.key_id;
			var room_id = key.room_id;
			var openid = key.openid;
			var sciener_is_freeze = key.sciener_is_freeze == 1 ? 0 : 1;
			$.ajax({
				type : "POST",
				dataType : 'json',// 接受数据格式
				url : 'freezeKey',
				data : {
					//tenantid : id,
					key_id: key_id,
					room_id: room_id,
					isFreeze : sciener_is_freeze,//1表示冻结,0表示解冻,
					openid: openid
				},
				success : function(resp) {
					$.messager.alert('信息', resp.msg, 'info');
					$('#test').datagrid('reload', {isInvocated: "no"});
				}
			});
		}
		return;
	}
}

function del(index) {//删除钥匙
	if (_.isNumber(index)) {// 修改
		var rec = $('#test').datagrid('getRows');
		var key = rec[index];
		if( key ){
			var key_id = key.key_id;
			var room_id = key.room_id;
			var openid = key.openid;
			$.ajax({
				url : 'deleteKey',
				type : 'post',
				dataType : 'json',
				data : {
					key_id: key_id,
					room_id: room_id,
					openid: openid
				},
				success : function(resp) {
					if (resp.success) {
						$.messager.alert('警告',
								resp.msg, 'info');
					} else {
						$.messager.alert('警告', resp.msg,
								'info');
					}
					$("#test").datagrid("reload");
				}
			});
		}
	}
}

function delUnlock(){
	var ids = [];
	var rows = $('#keyTable').datagrid('getSelections');
	for (var i = 0; i < rows.length; i++) {
		ids.push(rows[i].roomid);
	}
	//alert(ids);
	if (ids.join(',') == "")
		$.messager.alert('警告', '请选中至少一条记录！', 'warning');
	else {
		$.messager.confirm('警告', '确认删除？', function(r) {
			if (r) {
				$.ajax({
					url : 'deleteUnlock',
					type : 'post',
					dataType : 'json',
					data : "delIds=" + ids.join(','),
					success : function(resp) {
						if (resp.success) {
							$.messager.alert('警告',
									resp.success, 'info');
						} else {
							$.messager.alert('警告', resp.error,
									'info');
						}
						$("#keyTable").datagrid("load");
						$("#test").datagrid("load");
					}
				});
			}
		});
	}
}