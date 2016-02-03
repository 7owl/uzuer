(function(Handlebars) {
	Handlebars.registerHelper('getValue', function(value) {
				if (!value) {
					return "";
				}
				return value;
			});
	Handlebars.registerHelper('isSelected', function(value, defaultVal) {
				if (defaultVal == value) {
					return "selected";
				}
				return "";
			});
})(Handlebars);

$(function() {

	$('#w_Add').window('close');
	$('#w_idAuth').window('close');
	$('#sendKey').window('close');
	
	$("#layout").layout();

	// 表格控件
	$('#test').datagrid({
		width : 'auto',
		height : 'auto',
		nowrap : false,
		striped : true,
		collapsible : true,
		url : 'queryTenant',
		sortName : 'id',
		sortOrder : 'desc',
		remoteSort : false,
		queryParams : {
			// 关键字
			"queryWord" : "",
			// 关键字类型
			"queryType" : ""
		},
		loadMsg : '正在加载中.....',
		idField : 'id',
		frozenColumns : [[{
					field : 'c',
					title : '全选',
					checkbox : true,
					align : 'center'
				}]],
		columns : [[{
					field : 'username',
					title : '用户名',
					width : 80,
					sortable : true
				}, {
					field : 'fullname',
					title : '全名',
					width : 80,
					sortable : false,
					formatter : function(value, rec, index) {
						return rec["first_name"] + rec["last_name"];
					}
				}, {
					field : 'id_card',
					title : '身份证号码',
					width : 80,
					sortable : true
				}, {
					field : 'tel_number',
					title : '手机号码',
					width : 80,
					sortable : true
				}, {
					field : 'email',
					title : '邮箱',
					width : 80,
					sortable : true
				}, {
					field : 'native_place',
					title : '籍贯',
					width : 80,
					sortable : true
				}, {
					field : 'work_unit',
					title : '工作单位',
					width : 80,
					sortable : true
				}, {
					field : 'work_place',
					title : '单位地址',
					width : 100,
					sortable : true
				}, {
					field : 'work_place_number',
					title : '单位电话号码',
					width : 100,
					sortable : true
				}, {
					field : 'identity_valid',
					title : '是否认证通过',
					width : 100,
					sortable : true,
					formatter : function(value, rec, index) {
						if( value == 1 ){
							return '<span class="l-btn-left" style="padding-left: 20px;color:green;">已通过</span>';
						} else {
							return '<span class="l-btn-left" style="padding-left: 20px;color:red;">未通过</span>';
						}
					}
				}, {
					field : 're',
					title : '操作',
					width : 200,
					align : 'center',
					formatter : function(value, rec, index) {
						var str = "<a style='display:'';color:green' class='04' href='javascript:void(0)' onclick='openWindow("
								+ index
								+ ")'>修改</a>&nbsp;"
								+ "<a style='display:'';color:green' class='' href='javascript:void(0)' onclick='idAuth("
								+ index + ")'>身份认证</a>&nbsp;";
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
		"queryType" : $('#queryType').val() == "id" ? "room.id" : $('#queryType').val()
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

// 删除
function del() {
	var ids = [];
	var rows = $('#test').datagrid('getSelections');
	for (var i = 0; i < rows.length; i++) {
		ids.push(rows[i].id);
	}
	if (ids.join(',') == "")
		$.messager.alert('警告', '请选中至少一条记录！', 'warning');
	else {
		$.messager.confirm('警告', '确认删除？', function(r) {
					if (r) {
						$.ajax({
									url : 'deleteTenant',
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
										$("#test").datagrid("load");
									}
								});
					}
				});
	}
}

var Tenant = Backbone.Model.extend({
			validate : function(attrs, options) {
				if ($.trim(attrs.username) == "") {
					return "用户名不能为空...";
				}

				// if( $.trim(attrs.pwd) == "" ){ return "密码不能为空..."; }

				// if( attrs.pwd != attrs.repwd ){ return "用户密码不一致..."; }

				if ($.trim(attrs.first_name) == "") {
					return "姓氏不能为空...";
				}

				if ($.trim(attrs.last_name) == "") {
					return "名字不能为空...";
				}

				var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
				if (reg.test(attrs.id_card) === false) {
					return "身份证输入不合法...";
				}

				reg = /^1\d{10}$/;
				if (reg.test(attrs.tel_number) === false) {
					return "手机号码输入不合法...";
				}

				reg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
				if (reg.test(attrs.email) === false) {
					return "电子邮箱输入不合法...";
				}

				reg = /^0\d{2,3}-?\d{7,8}$/;
				if ($.trim(attrs.work_unit) != ""
						|| $.trim(attrs.work_place) != "") {
					if (reg.test(attrs.work_place_number) === false) {
						return "单位号码输入不合法...";
					}
				}
			}
		});

var WinView = Backbone.View.extend({
			el : '#saveForm',
			template : Handlebars.compile($("#tmp_save").html()),
			render : function() {
				// console.log( this.model.attributes );
				this.$el.html(this.template(this.model.attributes));
				// console.log( this.$el.html() );
				return this;
			},
			getModel : function() {// 序列化对象的值,返回model对象
				var obj = this.$el.serializeObject();
				// console.log(obj);
				this.model.set(obj);
				return this.model;
			}
		});
var tenant = new Tenant();
var winView = new WinView({
			model : tenant
		});

var IdAuthView = Backbone.View.extend({
			el : '#idAuthForm',
			template : Handlebars.compile($("#tmp_idInfo").html()),
			render : function() {
				this.$el.html(this.template(this.model.attributes));
				return this;
			}
		});
var idAuthView = new IdAuthView({
			model : tenant
		});

// 打开添加,修改窗口
function openWindow(index) {
	// console.log( index + ":" + _.isNumber(index) );
	if (_.isNumber(index)) {// 修改
		var rec = $('#test').datagrid('getRows');
		tenant.set(rec[Number(index)]);
		winView.model = tenant;
		winView.render();
		// console.log( tenant.get("id") + "修改");
		$('#w_Add').window({
					title : '修改信息',
					iconCls : 'icon-save',
					modal : true,
					height : 375
				});
		$('#w_Add').window('open');
		return;
	}
	tenant.clear();
	winView.model = tenant;
	winView.render();
	$('#w_Add').window({
				title : '添加信息',
				iconCls : 'icon-ok',
				modal : true,
				height : 425
			});
	$('#w_Add').window('open');
}

function openSendWindow(index){
	if (_.isNumber(index)) {// 修改
		var rec = $('#test').datagrid('getRows');
		tenant.set(rec[Number(index)]);
		$('#sendKey').window({
			title : '发送电子锁',
			iconCls : 'icon-save',
			modal : true,
			height : 480
		});
		$('#sendKey').window('open');
		return;
	}
}

function send(){
	//console.log(tenant.attributes.id);
	var recs = $('#keyTable').datagrid("getSelections");
	var rooms = _.map(recs, function(rec){
		return rec.roomid;
	});
	if( rooms.length == 0 ){
		$.messager.alert('信息', "请至少选择一个要发送的房源", 'info');
		return ;
	}
	$.ajax({
		type : "POST",
		dataType : 'json',// 接受数据格式
		url : 'sendKey',
		data : {
			tenantid : tenant.attributes.id,
			roomids  : rooms.join(",")
		},
		success : function(resp) {
			$.messager.alert('信息', resp.msg, 'info');
			$('#keyTable').datagrid('reload');
		}
	});
	console.log(rooms.join(","));
}

// 保存或修改操作
function save(index) {

	winView.getModel();

	if (!tenant.isValid()) {
		$.messager.alert("信息", tenant.validationError, "warning");
		return;
	}

	// 验证成功删除repwd属性
	var datas = tenant.toJSON();
	delete datas.repwd;
	// var rec = $('#test').datagrid('getRows');
	// var params=$("#form_add").serialize(); //序列化表单的值
	$.ajax({
				type : "POST",
				dataType : 'json',// 接受数据格式
				url : 'saveTenant',
				// url:'services/tenant/edit',
				data : {
					tenant : JSON.stringify(datas)
				},// 要传递的数据
				success : function(resp) {
					if (resp.success != "" && resp.success) {
						$("#test").datagrid("load");
						if (datas.id) {
							$.messager.confirm('信息', '修改成功!是否继续？', function(r) {
										if (!r) {
											$("#w_Add").window("close");
										}
									});
						} else {
							$.messager.confirm('信息', '添加成功!是否继续？', function(r) {
								if (!r) {
									$("#w_Add").window("close");
								}
									// clearup();
								});
						}

					} else if (resp.error != "" && resp.error) {
						$.messager.alert('信息', resp.error, 'info');
					}
				}
			});
}

function idAuth(index) {// 身份认证
	var rec = $('#test').datagrid('getRows');
	tenant.set(rec[Number(index)]);
	// alert("房客id:" + tenant.get("id") + ",是否通过:" +
	// tenant.get("identity_valid"));
	idAuthView.model = tenant;
	idAuthView.render();
	$('#w_idAuth').window({
				title : '身份认证',
				iconCls : 'icon-save',
				modal : true,
				height : 500
			});
	$("#idPictures")
			.html("<iframe src='idPictureView?id="
					+ tenant.get("id")
					+ "' id='iframepage' frameborder='0' scrolling='no' marginheight='0' marginwidth='0'  width='100%' height='100%' ></iframe>");
	$("#w_idAuth").window('open');
}

function idAuthChange(sel, tenant_id) {
	// alert("房客id:" + tenant_id + ",是否通过:" + $(sel).val());
	if ($(sel).val() == 1) {
		$.ajax({
					dataType : 'json',// 接受数据格式
					url : 'updateAuthState',
					data : {
						tenantid : tenant_id
					},// 要传递的数据
					success : function(resp) {
						if (resp.success != "" && resp.success) {
							$.messager.confirm('信息', '认证成功，已向APP发送通知？',
								function(r) {
									if (!r) {
										$("#w_idAuth").window("close");
									}
								});
						} else if (resp.error != "" && resp.error) {
							$.messager.alert('信息', resp.error, 'info');
							$('#test').datagrid('reload');
						}
					}
				});
	}
}

function freeze(index){//冻结用户
	if (_.isNumber(index)) {// 修改
		var rec = $('#test').datagrid('getRows');
		var tenant = rec[index];
		if( tenant ){
			var id = tenant.id;
			var sciener_is_freeze = tenant.sciener_is_freeze == 1 ? 0 : 1;
			$.ajax({
				type : "POST",
				dataType : 'json',// 接受数据格式
				url : 'freezeKey',
				data : {
					tenantid : id,
					isFreeze : sciener_is_freeze//1表示冻结,0表示解冻
				},
				success : function(resp) {
					$.messager.alert('信息', resp.msg, 'info');
					$('#keyTable').datagrid('reload');
				}
			});
		}
		return;
	}
}