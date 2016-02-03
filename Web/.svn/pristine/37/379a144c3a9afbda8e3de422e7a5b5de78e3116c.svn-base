(function(Handlebars) {
	Handlebars.registerHelper('getValue', function(value) {
				if (!value) {
					return "";
				}
				return value;
			});
})(Handlebars);

$(function() {
	// 窗口控件初始化
	$('#w_Add').window('close');
	$('#w_image').window('close');

	// 表格控件
	$('#test').datagrid({
		width : 'auto',
		height : 'auto',
		nowrap : false,
		striped : true,
		collapsible : true,
		url : 'queryRoom',
		sortName : 'room.id',
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
			field : 'price',
			title : '租金（元）',
			width : 60,
			sortable : true
		}, {
			field : 'rental_start_time',
			title : '开始出租时间',
			width : 100,
			sortable : true
		}, {
			field : 'rental_end_time',
			title : '结束出租时间',
			width : 100,
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
		}, {
			field : 'size',
			title : '面积',
			width : 50,
			sortable : true
		}, {
			//field : 'floor',
			//title : '楼层',
			field: 'decoration',
			title: '装修',
			width : 50,
			sortable : true
		}, {
			//field : 'orient',
			//title : '朝向',
			field: 'kind',
			title: '户型',
			width : 100,
			sortable : true
		}, {
			field : 'occupancy',
			title : '入住情况',
			width : 60,
			sortable : true
		}, {
			field : 'metro',
			title : '附近地铁情况',
			width : 100,
			sortable : true,
			hidden: true,
		}, {
			field : 're',
			title : '操作',
			width : 100,
			align : 'center',
			formatter : function(value, rec, index) {

				var str = "<a style='display:'';color:green' class='04' href='javascript:void(0)' onclick='openWindow("
						+ index
						+ ")'>修改</a>"
						+ "&nbsp;&nbsp;"
						+ "<a style='display:'';color:green' class='05' href='javascript:void(0)' onclick='openImage("
						+ rec.id + ")'>图片</a>";
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
	
	//房源查询条件类型
	$("#queryType").change(function(){
		val = $(this).val();
		$(".selCond").hide();
		if( val == "price" ){
			$("#min" + val).show();
			$("#max" + val).show();
			return;
		}
		
		if( $("#" + val + "-sel").length > 0 ){
			$("#" + val + "-sel").show();
		} else {
			$("#queryWord").show();
		}
	});
	
	// 点击图片
	$('img').click(function() {
		$('#myModalLabel').html($(this).attr('name') + '   <small>'
				+ $(this).attr('date') + '</small>');
		$('#modal-content').html('<img class=\'img-responsive\' src=\''
				+ $(this).attr('src') + '\'/>');
		$('#myModal').modal('show');
	});
	// 点击上传
	$('#upload').click(function() {
		if ($('#image_name').val() == '' || $('#image').val() == '') {
			alert('请输入上传的图片的名称');
		} else {
			var s = $('#showWin').data('roomid');
			$('#form').attr('action',
					'${pageContext.request.contextPath}' + '/uploadfile');
			$('#form').attr('enctype', 'multipart/form-data');
			$('#form').attr('method', 'post');
			$('#form').submit();
		}
	});
	// 点击确定退出
	$('#exit').click(function() {
				location.href = 'viewRoom';
			});
	// 点击确定删除图片
	$('#delete').click(function() {
		var ids = "";
		var urls = "";
		$('input[type=checkbox]:checked').each(function() {
					ids += $(this).val() + ',';
					urls += $(this).attr('url') + ',';
				});
		$.post('${pageContext.request.contextPath}' + '/deletepic', {
					ids : ids,
					urls : urls
				}, function(data, status) {
					$('#myModa3').modal('hide');
					location.href = '${pageContext.request.contextPath}'
							+ '/upload';
				});
	});

});

// 清空
function clearup() {
	$("#rental_start_time").datebox('setValue', '');
	$("#rental_end_time").datebox('setValue', '');
}

// 点击搜索
function searcher() {
	var val = "";
	var reg = /\d+$/;
	$("select.selCond").each(function(index){
		if( $(this).is(":visible") ){
			val = $(this).val();
		}
	});
	if( val == "" ){
		$("input.selCond").each(function(index){
			if( $(this).is(":visible") ){
				if( val != ""){
					if (reg.test(val) === false && val != "") {
						$.messager.alert('警告', "请输入整数的租金...", 'warning');
						return;
					}
					val += "," + $(this).val();
				} else {
					if( $('#queryType').val() != "price" ){
						val = $(this).val();
					} else {
						if (reg.test(val) === false && val != "") {
							$.messager.alert('警告', "请输入整数的租金...", 'warning');
							return;
						}
						val = $(this).val();
					}
				}
			}
		});
	}
	
	$("#test").datagrid('load', {
				// 关键字内容
				"queryWord" : val,
				// 关键字类型
				"queryType" : $('#queryType').val() == "id" ? "room.id" : $('#queryType').val() 
			});
}

function cancel() {
	$('#w_Add').window('close');
	$('#w_image').window('close');
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
									url : 'deleteRoom',
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

var Room = Backbone.Model.extend({
			validate : function(attrs, options) {
				if ($.trim(attrs.room_name) == "") {
					return "房源具体地址不能为空...";
				}
				if (!attrs.comm_id || $.trim(attrs.comm_id) == "") {
					return "请选择房源所在的小区...";
				}
				// if( $.trim(attrs.address) == "" ){ return "地址不能为空..."; }
				var reg = /\d+$/;
				if (reg.test(attrs.price) === false) {
					return "请输入整数的租金...";
				}
				if (reg.test(attrs.k1) === false) {
					return "请输入整数的室...";
				}
				if (reg.test(attrs.k2) === false) {
					return "请输入整数的厅...";
				}
				if (reg.test(attrs.k3) === false) {
					return "请输入整数的厨...";
				}
				if (reg.test(attrs.k4) === false) {
					return "请输入整数的卫...";
				}

				if (reg.test(attrs.size) === false) {
					return "请输入整数的面积...";
				}
			}
		});

var WinView = Backbone.View.extend({
	el : '#saveForm',
	template : Handlebars.compile($("#tmp_save").html()),
	render : function() {
		this.$el.html(this.template(this.model.attributes));
		// console.log(this.$el.html());
		// console.log(this.model.attributes);
		this.initView();
		return this;
	},
	getModel : function() {// 序列化对象的值,返回model对象
		var obj = this.$el.serializeObject();
		var r1 = obj.recommendTarget1;
		var r2 = obj.recommendTarget2;
		var r3 = obj.recommendTarget3;
		// allTar = '';
		var allTar = (r1 !== '' ? r1 + ',' : '') + (r2 !== '' ? r2 + ',' : '')
				+ (r3 !== '' ? r3 + ',' : '');
		obj.k1 + obj.k2 + obj.k3 + obj.k4;
		obj.kind = obj.k1 + obj.k2 + obj.k3 + obj.k4;
		obj.recommendTarget = allTar;
		this.model.set(obj);

		// room.attributes.recommendTarget = $('#recommendTarget1').val()!==''?
		// $('#recommendTarget1').val()+',':''
		// +$('#recommendTarget2').val()!==''?
		// $('#recommendTarget2').val()+',':''
		// +$('#recommendTarget3').val()!==''?
		// $('#recommendTarget3').val()+',':'';
		//			 
		// var r1 = this.model.attributes.recommendTarget1;
		// var r2 = this.model.attributes.recommendTarget2;
		// var r3 = this.model.attributes.recommendTarget3;
		return this.model;
	},
	initView : function() {
		// 小区
		$("#bed").get(0).checked = this.model.attributes.bed == 1
				? true
				: false;
		$("#wardrobe").get(0).checked = this.model.attributes.wardrobe == 1
				? true
				: false;
		$("#air_conditioning").get(0).checked = this.model.attributes.air_conditioning == 1
				? true
				: false;
		$("#tv").get(0).checked = this.model.attributes.tv == 1 ? true : false;
		$("#gasstove").get(0).checked = this.model.attributes.gasstove == 1
				? true
				: false;
		$("#washing").get(0).checked = this.model.attributes.washing == 1
				? true
				: false;
		$("#heater").get(0).checked = this.model.attributes.heater == 1
				? true
				: false;
		$("#refrigerator").get(0).checked = this.model.attributes.refrigerator == 1
				? true
				: false;
		$("#microwaveOven").get(0).checked = this.model.attributes.microwaveOven == 1
				? true
				: false;
		//下拉框赋值
		$('#status').val(this.model.attributes.status);//出租情况
		$('#smartlock').val(this.model.attributes.smartlock);//是否支持智能锁
		$('#isRecommend').val(this.model.attributes.isRecommend);//是否是推荐房源
		$('#rent_type').val(this.model.attributes.rent_type);//出租情况
		$('#decoration').val(this.model.attributes.decoration);//装修
		
		var rt = this.model.attributes.recommendTarget;

		if (rt !== null && rt != '' && rt !== undefined) {
			var attr = rt.split(",");
			for (var i = 0; i < attr.length; i++) {
				if (attr[i] !== null && attr[i] !== '' && attr[i] !== undefined) {
					var recid = '#recommendTarget' + (i + 1);
					$(recid).val(attr[i]);
				}
			}
			var kindstr = this.model.attributes.kind;
			$('#k1').val(kindstr.substring((kindstr.indexOf('室') - 1), kindstr
							.indexOf('室')));
			$('#k2').val(kindstr.substring((kindstr.indexOf('厅') - 1), kindstr
							.indexOf('厅')));
			$('#k3').val(kindstr.substring((kindstr.indexOf('厨') - 1), kindstr
							.indexOf('厨')));
			$('#k4').val(kindstr.substring((kindstr.indexOf('卫') - 1), kindstr
							.indexOf('卫')));
		}

		if (_.isNumber(this.model.attributes.room_host)) {
			var room_host = this.model.attributes.room_host;
			hosts = $('#room_host').combogrid({

						panelWidth : 450,
						// value:'id',
						idField : 'id',
						textField : 'first_name',
						width : 250,
						url : 'hosts',
						columns : [[{
									field : 'first_name',
									title : '房东姓名',
									width : 70
								}, {
									field : 'native_place',
									title : '籍贯',
									width : 120
								}, {
									field : 'tel_number',
									title : '联系方式',
									width : 120
								}]],
						onLoadSuccess : function() {// 加载成功之后,
							$('#room_host').combogrid('setValue', room_host);
						},
						filter : function(q, row) {
							var opts = $("#room_host").combogrid("options");
							return row[opts.textField].indexOf(q) > -1;
						}
					});
		} else {
			hosts = $('#room_host').combogrid({
						panelWidth : 450,
						// value:'id',
						idField : 'id',
						textField : 'first_name',
						width : 250,
						url : 'hosts',
						columns : [[{
									field : 'first_name',
									title : '房东姓名',
									width : 70
								}, {
									field : 'native_place',
									title : '籍贯',
									width : 120
								}, {
									field : 'tel_number',
									title : '联系方式',
									width : 120
								}]],
						filter : function(q, row) {
							var opts = $("#room_host").combogrid("options");
							return row[opts.textField].indexOf(q) > -1;
						}
					});
		}

		// ----------------- 新增的 公司信息 ---------------------
		if (_.isNumber(this.model.attributes.company_id)) {
			var company_id = this.model.attributes.company_id;
			hosts = $('#company_id').combogrid({

						panelWidth : 450,
						// value:'id',
						idField : 'id',
						textField : 'company_name',
						width : 250,
						url : 'companys',
						columns : [[{
									field : 'company_name',
									title : '公司名称',
									width : 70
								}, {
									field : 'company_address',
									title : '公司地址',
									width : 120
								}, {
									field : 'company_ceo',
									title : '公司负责人',
									width : 120
								}, {
									field : 'company_number',
									title : '联系方式',
									width : 120
								}]],
						onLoadSuccess : function() {// 加载成功之后,
							$('#company_id').combogrid('setValue', company_id);
						},
						filter : function(q, row) {
							var opts = $("#company_id").combogrid("options");
							return row[opts.textField].indexOf(q) > -1;
						}
					});
		} else {
			hosts = $('#company_id').combogrid({
						panelWidth : 450,
						// value:'id',
						idField : 'id',
						textField : 'company_name',
						width : 250,
						url : 'companys',
						columns : [[{
									field : 'company_name',
									title : '公司名称',
									width : 70
								}, {
									field : 'company_address',
									title : '公司地址',
									width : 120
								}, {
									field : 'company_ceo',
									title : '公司负责人',
									width : 120
								}, {
									field : 'company_number',
									title : '联系方式',
									width : 120
								}]],
						filter : function(q, row) {
							var opts = $("#company_id").combogrid("options");
							return row[opts.textField].indexOf(q) > -1;
						}
					});
		}

		// --------------------------------------

		if (_.isNumber(this.model.attributes.comm_id)) {
			var comm_id = this.model.attributes.comm_id;
			var comm_address = this.model.attributes.comm_address;

			comms = $('#comm_id').combogrid({
						url : 'comms',
						idField : 'id',
						// valueField:'id',
						textField : 'comm_name',
						width : 250,
						columns : [[{
									field : 'comm_name',
									title : '小区名',
									width : 60
								}, {
									field : 'comm_address',
									title : '小区地址',
									width : 180
								},]],
						onLoadSuccess : function() {// 加载成功之后,
							$('#comm_id').combogrid('setValue', comm_id);
							// $('#address').text(comm_address);
						},
						filter : function(q, row) {
							var opts = $("#comm_id").combogrid("options");
							return row[opts.textField].indexOf(q) > -1;
						}
					});
		} else {
			comms = $('#comm_id').combogrid({
						url : 'comms',
						idField : 'id',
						// valueField:'id',
						textField : 'comm_name',
						width : 250,
						columns : [[{
									field : 'comm_name',
									title : '小区名',
									width : 60
								}, {
									field : 'comm_address',
									title : '小区地址',
									width : 180
								},]],
						filter : function(q, row) {
							var opts = $("#comm_id").combogrid("options");
							return row[opts.textField].indexOf(q) > -1;
						}
					});
		}
	}

});
var room = new Room();
var winView = new WinView({
			model : room
		});

var dateBoxOpt = {
	panelWidth : 180,// 弹出日期选择面板的宽度
	width : 250,
	formatter : function(date) {
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		var d = date.getDate();
		return y + "-" + (m < 10 ? ("0" + m) : m) + "-"
				+ (d < 10 ? ("0" + d) : d);
	}
};

// 打开图片上传窗口
function updatePic(index) {

}

// 打开添加,修改窗口
function openWindow(index) {
	// console.log( index + ":" + _.isNumber(index) );

	if (_.isNumber(index)) {// 修改
		var rec = $('#test').datagrid('getRows');
		room.set(rec[Number(index)]);
		winView.model = room;
		winView.render();
		// console.log( tenant.get("id") + "修改");
		$('#w_Add').window({
					title : '修改信息',
					iconCls : 'icon-save',
					modal : true,
					height : 525
				});
		$('#w_Add').window('open');
		// 日期控件初始化
		$("#rental_start_time").datebox(dateBoxOpt);
		$("#rental_end_time").datebox(dateBoxOpt);
		return;
	}
	room.clear();
	winView.model = room;
	winView.render();
	$('#w_Add').window({
				title : '添加信息',
				iconCls : 'icon-ok',
				modal : true,
				height : 525
			});
	$('#w_Add').window('open');
	// 日期控件初始化
	$("#rental_start_time").datebox(dateBoxOpt);
	$("#rental_end_time").datebox(dateBoxOpt);
}
function iFrameHeight() {
	var ifm = $("#iframepage");
	var subWeb = document.frames
			? document.frames["iframepage"].document
			: ifm.contentDocument;
	if (ifm != null && subWeb != null) {
		ifm.height = subWeb.body.scrollHeight;
		ifm.width = subWeb.body.scrollWidth;
	}
}
// 打开图片窗口
function openImage(id) {
	$("#w_image")
			.html("<iframe src='fileUpView?id="
					+ id
					+ "' id='iframepage' frameborder='0' marginheight='0' marginwidth='0'  width='100%' height='100%' ></iframe>");

	$('#w_image').window({
				title : '房源图片信息',
				iconCls : 'icon-save',
				modal : true,
				height : 500
			});
	$("#w_image").window('open');
}

// 保存或修改操作
function save(index) {
	// console.log($("#rental_start_time").datebox('getValue'));
	// console.log($("#rental_end_time").datebox('getValue'));

	winView.getModel();
	room.attributes.bed = $("#bed").get(0).checked == true ? 1 : 0;
	room.attributes.wardrobe = $("#wardrobe").get(0).checked == true ? 1 : 0;
	room.attributes.air_conditioning = $("#air_conditioning").get(0).checked == true
			? 1
			: 0;
	room.attributes.tv = $("#tv").get(0).checked == true ? 1 : 0;
	// room.attributes.kitchen = $("#kitchen").get(0).checked==true?1:0;
	// room.attributes.bashroom = $("#bashroom").get(0).checked==true?1:0;
	room.attributes.gasstove = $("#gasstove").get(0).checked == true ? 1 : 0;
	room.attributes.washing = $("#washing").get(0).checked == true ? 1 : 0;
	room.attributes.heater = $("#heater").get(0).checked == true ? 1 : 0;
	room.attributes.refrigerator = $("#refrigerator").get(0).checked == true
			? 1
			: 0;
	room.attributes.microwaveOven = $("#microwaveOven").get(0).checked == true
			? 1
			: 0;
	// room.attributes.balcony = $("#balcony").get(0).checked==true?1:0;

	room.attributes.recommendTarget = ($('#recommendTarget1').val() !== ''
			? $('#recommendTarget1').val() + ','
			: '')
			+ ($('#recommendTarget2').val() !== '' ? $('#recommendTarget2')
					.val()
					+ ',' : '')
			+ ($('#recommendTarget3').val() !== '' ? $('#recommendTarget3')
					.val()
					+ ',' : '');

	room.attributes.kind = ($('#k1').val !== '' ? $('#k1').val() : '0') + '室'
			+ ($('#k2').val !== '' ? $('#k2').val() : '0') + '厅'
			+ ($('#k3').val !== '' ? $('#k3').val() : '0') + '厨'
			+ ($('#k4').val !== '' ? $('#k4').val() : '0') + '卫';

	console.log(room.toJSON());
	if (!room.isValid()) {
		$.messager.alert("信息", room.validationError, "warning");
		return;
	}
	// 验证成功删除repwd属性
	var datas = room.toJSON();
	// var rec = $('#test').datagrid('getRows');
	// var params=$("#form_add").serialize(); //序列化表单的值
	$.ajax({
				type : "POST",
				dataType : 'json',// 接受数据格式
				url : 'saveRoom',
				data : {
					room : JSON.stringify(datas)
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