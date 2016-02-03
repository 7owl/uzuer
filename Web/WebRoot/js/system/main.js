(function(Handlebars) {
	Handlebars.registerHelper('updateMenu', function(menu) {
		return menu.substring(1);
	});
})(Handlebars);

var Menu = Backbone.Model.extend({});

var Menus = Backbone.Collection.extend({
	model: Menu
});

/**************************初始化菜单项,开始****************************/
var menus = new Menus();
/*
var menuArr = [
	{id:'mb1', menu:'#mm1', text:'待售球员信息', children:[
	                                                  { id:'01', tab: '待售球员信息', url:'common/player!skip.action', text:'待售球员信息' }
	                                                  ]},
	{id:'mb2', menu:'#mm2', text:'系统管理', children:[
	                                                  { id:'02', tab: '用户管理', url:'common/player!skip.action', text:'用户管理' },
	                                                  { id:'03', tab: '角色管理', url:'common/player!skip.action', text:'角色管理' }
	                                                  ]}, 
	{id:'mb3', menu:'#mm3', text:'俱乐部管理', children:[
	                                                  { id:'04', tab: '俱乐部管理', url:'common/club!skip.action', text:'俱乐部管理' }
	                                                  ]},
	{id:'mb4', menu:'#mm4', text:'球员管理', children:[
	                                               	  { id:'04', tab: '球员管理', url:'common/club!skip.action', text:'球员管理' }
	                                                  ]}
];
*/
var menuArr = [{
	id: 'mb1',
	menu: '#mm1',
	text: '房客管理',
	children: [{
		id: '01',
		tab: '房客信息',
		url: 'viewTenant',
		text: '房客信息'
	}]
}, {
	id: 'mb2',
	menu: '#mm2',
	text: '小区管理',
	children: [{
			id: '02_2',
			tab: '房源管理',
			url: 'viewRoom',
			text: '房源信息'
		}/*,{
			id: '02_2',
			tab: '锁管理',
			url: 'viewUnlock',
			text: '锁信息'
		}*/,{
			id: '02_3',
			tab: '钥匙管理',
			url: 'viewKey',
			text: '钥匙信息'
		}, {
			id: '02_4',
			tab: '房东管理',
			url: 'viewHost',
			text: '房东信息'
		}, {
			id: '02_5',
			tab: '小区管理',
			url: 'viewCommunity',
			text: '小区信息'
		},

	]
}, {
	id: 'mb3',
	menu: '#mm3',
	text: '管家管理',
	children: [{
		id: '03_1',
		tab: '管家管理',
		url: 'viewHomeMaker',
		text: '管家信息'
	}, ]
}, {
	id: 'mb4',
	menu: '#mm4',
	text: '公司管理',
	children: [{
		id: '04_1',
		tab: '公司管理',
		url: 'viewCompany',
		text: '公司信息'
	},{
		id: '04_2',
		tab: '银行账号管理',
		url: 'viewBankInfo',
		text: '银行账号信息'
	},{
		id: '04_3',
		tab: '合同管理',
		url: 'viewContractInfo',
		text: '合同信息'
	}]
}, {
	id: 'mb10',
	menu: '#mm10',
	text: '系统管理',
	children: [{
		id: '05_1',
		tab: '角色管理',
		url: 'viewRole',
		text: '角色信息'
	}, ]
}, ];
_.each(menuArr, function(ele) {
	var menu = new Menu(ele);
	menus.push(menu);
});
/**************************初始化菜单项,结束****************************/

var MenusView = Backbone.View.extend({
	el: '#myMenus',
	template: Handlebars.compile($("#tmp_menu").html()),
	render: function() {
		this.$el.html(this.template({
			menus: this.collection.toJSON()
		}));

		var template_item = Handlebars.compile($("#tmp_menu_item").html());
		$("div[region='north']").children('div:eq(0)').append(template_item({
			menus: this.collection.toJSON()
		}));

		return this;
	}
});

var menusView = new MenusView({
	collection: menus
});
menusView.render();

function addTab(name, src) {
	if ($('#main').tabs('exists', name)) {
		$('#main').tabs('select', name);
	} else {
		var content = '<iframe scrolling="auto" frameborder="0"  src=' + src + ' style="width:100%;height:100%;"></iframe>';
		$('#main').tabs('add', {
			title: name,
			content: content,
			closable: true,
			selected: true
		});
	}
};

//绑定tab的双击事件、右键事件   
function bindTabEvent() {
	$(".tabs-inner").live('dblclick', function() {
		var subtitle = $(this).children("span").text();
		if ($(this).next().is('.tabs-close')) {
			$('#main').tabs('close', subtitle);
		}
	});
	$(".tabs-inner").live('contextmenu', function(e) {
		$('#mm').menu('show', {
			left: e.pageX,
			top: e.pageY
		});
		var subtitle = $(this).children("span").text();
		$('#mm').data("currtab", subtitle);
		return false;
	});
}