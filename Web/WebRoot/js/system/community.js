(function(Handlebars) {
	Handlebars.registerHelper('getValue', function( value ) {
		if( !value ){
			return "";
		}
		return value;
	});
	
	Handlebars.registerHelper('getValue2', function( value, value2 ) {//经纬度拼接
		if( value && value2){
			return value + "," + value2;
		}
		if( !value ){
			return "";
		}
		return value;
	});
	
	Handlebars.registerHelper('isSelected', function( value1, value2 ) {
		if( value1 == value2 ){
			return "seletected";
		}
		return "";
	});
})(Handlebars);

$(function(){
	//窗口控件初始化
	$('#w_Add').window('close');
	
	//表格控件
	$('#test').datagrid({
		width:'auto',
		height:'auto',
		nowrap: false,
		striped: true,
		collapsible:true,
		url:'queryCommunity',
		sortName: 'comm.id',
		sortOrder: 'desc',
		remoteSort: false,
		queryParams : {
			//关键字
			"queryWord" : "",
			//关键字类型
			"queryType" : ""
		},
		loadMsg : '正在加载中.....',
		idField:'id',
		frozenColumns:[[
            {field:'c',title:'全选',checkbox:true,align : 'center'}
		]],
		columns:[[
			{field:'comm_name',title:'小区名称',width:150,sortable:true},
			{field:'comm_address',title:'小区地址',width:300,sortable:true},
			{field:'busiCircle',title:'附近商圈',width:200,sortable:true},
			/*{field:'lonAndLat',title:'经纬度',width:100,sortable:false, 
				formatter:function(value,rec,index){
					if( rec.longitude && rec.latitude ){
						return rec.longitude + "," + rec.latitude; 
					} 
					return "";
				}
			},*/
			{field:'longitude',title:'经度',width:100,sortable:true},
			{field:'latitude',title:'纬度',width:100,sortable:true},
			{field:'hm_name',title:'管家',width:100,sortable:true},
			{field:'hm_number',title:'管家联系方式',width:200,sortable:true},
			{field:'re',title:'操作',width:100,align:'center',
				formatter:function(value,rec,index){
					var str =  "<a style='display:'';color:green' class='04' href='javascript:void(0)' onclick='openWindow("+index+")'>修改</a>" 
					return str;
				}
			}
		]],
		pagination:true,
		pageSize : 10,//页数
		pageList : [ 10, 15 ,20,25,30 ],//每页多少条记录
		rownumbers:true,
		onLoadSuccess : function(){
			//$.getScript("js/own/power.js");
		}
		
	});

});
//点击搜索
function searcher(){

	$("#test").datagrid('load',{
		//关键字内容
		"queryWord" : $('#queryWord').val(),
		//关键字类型
		"queryType" : $('#queryType').val()                                                         
	});
}

function cancel(){
	$('#w_Add').window('close');
}

function updatebuttonchage(){
	$('.button').linkbutton('enable');
}

//删除
function del(){
	var ids = [];
	var rows = $('#test').datagrid('getSelections');
	//alert(rows);
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}
	if(ids.join(',') == "")
		$.messager.alert('警告','请选中至少一条记录！','warning');
	else{
		$.messager.confirm('警告','确认删除？',function(r){
			if(r){
				$.ajax({
					url:'deleteCommunity',
		            type:'post',
		            dataType:'json',
		            data:"delIds="+ids.join(','),
		            success: function(resp){
		            	if( resp.success ){
		            		$.messager.alert('警告',resp.success,'info');
		            	} else {
		            		$.messager.alert('警告',resp.error,'info');
		            	}
		            	$("#test").datagrid("load");
		            }
				});
			}
		});
	}
}


var Community = Backbone.Model.extend({
	validate: function(attrs, options) {
		if( !attrs.hm_id || $.trim( attrs.hm_id ) == "" ){ return "请选择小区管家...";}
		
		if( !attrs.comm_address || $.trim( attrs.comm_address ) == "" ){ return "请选择小区详细地址...";}
		
		if( !attrs.comm_name || $.trim( attrs.comm_name ) == "" ){ return "请选择小区名称...";}
		
//		if( $.trim( attrs.lonAndLat ) != "" ){
//			var reg = /\d+\.?\d*,\d+\.?\d*/;
//			if( reg.test( $.trim( attrs.lonAndLat ) )  == false ){
//				return "经纬度以逗号给开,如1,2";
//			}
//		}
	}
});

var province, city, country;//省市县
var hms;//管家
var address = new Array(3);//省市县中文名称
var address_code = new Array(3);//省市县id组合

var twoRegion = ['县', '市辖区'];//过滤掉第二级是县和市辖区

var WinView = Backbone.View.extend({
	el: '#saveForm',
	template: Handlebars.compile($("#tmp_save").html()),
	render: function(){
		var context = {
				comm: this.model.attributes
		};
		this.$el.html( this.template( context ) );
		//console.log( this.$el.html() );
		this.initView();
		return this;
	},
	getModel: function(){//序列化对象的值,返回model对象
		var obj = this.$el.serializeObject();
		//comm_address
		var pro = province.combobox('getValue');
		var cit = city.combobox('getValue');
		var cou = country.combobox('getValue');
		this.model.set( obj );
		if( address.join('') != ''){
			this.model.set('comm_address', address.join(''));
		}
		if( address_code.join(';') != ';;' ){
			this.model.set('comm_address_code', address_code.join(';'));
		}
		
		return this.model;
	},
	initView: function(){//初始化combobox
		//管家
		if( _.isNumber( this.model.attributes.hm_id ) ){
			var hm_id = this.model.attributes.hm_id;
			hms = $('#hm_id').combogrid({
				url: 'hms',
				//valueField:'id',
				idField:'id', 
				textField:'hm_name',
				width:300,
				columns:[[ 
					{field:'hm_name',title:'管家姓名',width:100}, 
					{field:'hm_number',title:'联系方式',width:180}
				]],
				onLoadSuccess: function(){//加载成功之后,
					$('#hm_id').combogrid( 'setValue', hm_id );
				},
				filter: function(q, row){
					var opts= $("#hm_id").combobox("options");
					return row[opts.textField].indexOf(q) > -1;
				}
			});
		} else {
			hms = $('#hm_id').combogrid({
				url: 'hms',
				//valueField:'id',
				idField:'id', 
				textField:'hm_name',
				width:300,
				columns:[[ 
					{field:'hm_name',title:'管家姓名',width:100}, 
					{field:'hm_number',title:'联系方式',width:180}
				]],
				filter: function(q, row){
					var opts= $("#hm_id").combobox("options");
					return row[opts.textField].indexOf(q) > -1;
				}
			});
		}
		
		
		var strs = [];
		if( _.isString( this.model.attributes.comm_address_code ) ){
			strs = this.model.attributes.comm_address_code.split(';');
		}
		//地市选择combobox
		province = $('#province').combobox({ 
			url:'regions/1', 
			valueField:'region_id', 
			textField:'region_name',
			onLoadSuccess: function(){//加载成功之后,
				if( strs.length > 0 ){
					$('#province').combobox( 'setValue', strs[0] );
				}
			},
			onSelect: function( rec ){
				if( rec ){
					//alert(rec.region_name);
					var pId = rec.region_id;
					//选中赋值
					address[0] = rec.region_name;
					address_code[0] = rec.region_id;
					//清空city和country
					city.combobox('setValue', '');
					country.combobox('setValue', '');
					strs = [];
					
					city.combobox({ 
						url:'regions/' + pId, 
						valueField:'region_id', 
						textField:'region_name',	
						onSelect: function( rec ){
							if( rec ){
								var pId = rec.region_id;
								//选中赋值
								if( _.indexOf(twoRegion, rec.region_name) == -1 ){
									address[1] = rec.region_name;
								} else {
									address[1] = '';
								}
								
								address_code[1] = rec.region_id;
								//清空country
								country.combobox('setValue', '');
								strs = [];
								
								country.combobox({ 
									url:'regions/' + pId, 
									valueField:'region_id', 
									textField:'region_name',
									onSelect: function( rec ){
										if( rec ){
											//选中赋值
											address[2] = rec.region_name;
											address_code[2] = rec.region_id;
										}
									},
									filter: function(q, row){
										var opts= $("#country").combobox("options");
										return row[opts.textField].indexOf(q) > -1;
									}
								});
							}
						},
						filter: function(q, row){
							var opts= $("#city").combobox("options");
							return row[opts.textField].indexOf(q) > -1;
						}
					});
				}
			},
			filter: function(q, row){
				var opts= $("#province").combobox("options");
				return row[opts.textField].indexOf(q) > -1;
			}
		}); 
		
		if( strs.length > 1 ){
			city = $('#city').combobox({  
				url:'regions/' + strs[0],
				valueField:'region_id', 
				textField:'region_name',
				onLoadSuccess: function(){//加载成功之后,
					$('#city').combobox( 'setValue', strs[1] );
				},
				filter: function(q, row){
					var opts= $("#city").combobox("options");
					return row[opts.textField].indexOf(q) > -1;
				}
			});
		} else {
			city = $('#city').combobox({  
				valueField:'region_id', 
				textField:'region_name',
				filter: function(q, row){
					var opts= $("#city").combobox("options");
					return row[opts.textField].indexOf(q) > -1;
				}
			});
		}
		
		if( strs.length > 2 ){
			country = $('#country').combobox({  
				url:'regions/' + strs[1],
				valueField:'region_id', 
				textField:'region_name',
				onLoadSuccess: function(){//加载成功之后,
					$('#country').combobox( 'setValue', strs[2] );
				},
				filter: function(q, row){
					var opts= $("#country").combobox("options");
					return row[opts.textField].indexOf(q) > -1;
				}
			});
		} else {
			country = $('#country').combobox({  
				valueField:'region_id', 
				textField:'region_name',
				filter: function(q, row){
					var opts= $("#country").combobox("options");
					return row[opts.textField].indexOf(q) > -1;
				}
			});
		}
		
	}
});
var comm = new Community();
var winView = new WinView({model: comm});

//打开添加,修改窗口
function openWindow(index){
	//console.log( hms.toJSON() );
	if( _.isNumber(index) ){//修改
		var rec = $('#test').datagrid('getRows');
		comm.set( rec[Number(index)] );
		winView.model = comm;
		winView.render();
		$('#w_Add').window({title:'修改信息', iconCls:'icon-save', modal: true, height: 400});
		$('#w_Add').window('open');
		return;
	}
	comm.clear();
	winView.model = comm;
	winView.render();
	$('#w_Add').window({title:'添加信息', iconCls:'icon-ok', modal: true, height:400});
	$('#w_Add').window('open');
}
//保存或修改操作
function save(index){
	winView.getModel();
	//console.log( role.toJSON() );
	if (!comm.isValid()) {
		$.messager.alert("信息", comm.validationError, "warning");
		return ;
	}
	//验证成功删除repwd属性
	var datas = comm.toJSON();
    $.ajax({
    		type: "POST",
            dataType:'json',//接受数据格式
            url:'saveCommunity',
            data: { community: JSON.stringify(datas)},//要传递的数据
            success: function(resp){
            	if( resp.success != "" && resp.success ){
            		$("#test").datagrid("load");
            		if( datas.id ){
            			$.messager.confirm('信息','修改成功!是否继续？',function(r){
                			if (!r){
                				$("#w_Add").window("close");
                			}
                		});
            		} else {
            			$.messager.confirm('信息','添加成功!是否继续？',function(r){
                			if (!r){
                				$("#w_Add").window("close");
                			}
                		});
            		}
				}
            	else if(resp.error != "" && resp.error){
            		$.messager.alert('信息',resp.error,'info');
            	}
            }
    });
}