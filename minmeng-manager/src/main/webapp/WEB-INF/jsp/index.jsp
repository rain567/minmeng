<%/**
	用户邮箱首页
	2014-3-29创建@杨大江
*/%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html> 
<html>  
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${SITENAME_EDIT }</title>
<link rel="icon" href="favicon.ico" type="image/x-icon"/> 
<link rel="shortcut icon" href="favicon.ico" type="image/vnd.microsoft.icon">
<link rel="icon" href="favicon.ico" type="image/vnd.microsoft.icon">
<!-- 加载样式文件 -->
<link rel="stylesheet" href="${SITE_RESOURCE_PREFIX }/themes/default.css"/>
<link rel="stylesheet" href="${RESOURCE_PREFIX}/fixwork/src/tabhost/css/tabs.all.css"/>
<link rel="stylesheet" href="${RESOURCE_PREFIX}/fixwork/src/menus/css/gray.css"/>
<link rel="stylesheet" href="${RESOURCE_PREFIX}/fixwork/src/button/css/default.css"/>
 <style type="text/css">
 body{overflow:hidden;margin:0;padding:0;border:0;}
 </style>
</head>
<body scroll="no">
<!-- body start -->
<div  id="frame"></div>
<!-- body end -->
<script type="text/javascript" src="${RESOURCE_PREFIX}/jquery/jquery.min.js"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/lhgdialog/lhgdialog.min.js?self=true&skin=mdiscuz"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/fixwork/fixwork.js"></script>
<script type="text/javascript">
/**
 * 全局变量定义
 */
var sourceRequest = null,
	getMenusRequest = null,
	getContentsRequest = null,
	tabHost = null,
	path='${path}',
	navid, // 当前导航ID
	menuid; // 当前菜单ID

$(window).unload(function(){
	if(sourceRequest && sourceRequest!=null){
		sourceRequest.abort();
	}
	if(getMenusRequest && getMenusRequest!=null){
		getMenusRequest.abort();
	}
});


/**
 * 设置地址栏状态
 */ 
function setUrlState(navid,menuid,from,title){
	if(urlState.enable()){
		// 支持地址栏改变
		var params = [{
			name:'navid',
			value:navid
		},{
			name:'menuid',
			value:menuid	
		},{
			name:'from',
			value:from
		}];
		urlState.pushState(params, window.location.pathname, title);
	}
}

/**
 * 解析当前URL参数数组
 */ 
function loadParams(response){
	urlState.parseUrl(function(data){
		var params = data.params;
		var request = {};
		if($.isArray(params) && params.length>0){
			$.grep(params,function(param){
				if(param.value && param.value!=''){
					if(param.name == 'navid' ){
						request.navid = param.value;
					}else if(param.name == 'menuid'){
						request.menuid = param.value;
					}else if(param.name == 'from'){
						request.from = param.value;
					}
				}
			});
		}
		response (request);
	});
}

/**
 * 获取指定导航的菜单组及所有菜单项
 */
function getSource(navid,response){
	if(getMenusRequest!=null){
		getMenusRequest.abort();
	}
	getMenusRequest = $.getJSON('${path}/source?navid='+navid, function(result){
		if(result.error){
			//alert(result.error.message);						
		}else{		
			// 获取到导航数组，遍历取出菜单组
			response($.map(result.result,function(data){
				 var showTitle = data.showTitle;
				// 如果有标题显示设置
			 	showTitle = typeof showTitle == undefined || showTitle == false  ?false:true;
				// 获取关联的分类模块
				// 如果有关联，关联的分类将作为菜单项，追加到当前分组的菜单项列表
				if(data.id == 'product'){
					// 商品管理菜单组，获取分类列表，并将转换的菜单追加到列表
					if(getCats(data.items).has ==false){
						data.items.push({
							id:'nocats',
							name:'未设置商品分类'
						});
					} 
				}
				var items = getMenus(data.items);
				return {
					id:data.id,// 菜单组ID
					label:data.name, // 菜单组名
					showTitle:data.name && data.name !=''?showTitle:false, // 是否显示标题							
					items:items// 菜单列表,
				};
			}));
		}
	 });
}
/**
 * 获取商品分类
 * items 条目
 * 分类ID 默认未定义
 */
function getCats(items,id){
	// has 有分类标记，默认false
	var has = false;
	items = items || [];
	var url = '${path}/cat/getCats?type=${CAT_TYPE_SMS_PRODUCT}'+(id?'&id='+id:'');
	$.ajax({
        type: 'get',
        dataType:'json', 
        async:false, 
        url: url,
        beforeSend:function(){
        },
        success: function(data) {
        	if(data && data.result && $.isArray(data.result) && data.result.length > 0){
        		has = true;
        		$.grep(data.result,function(cat){
        			items.push({
        				id:cat.id,
        				name:cat.name,
        				url:'sms/product/info?cid='+cat.id,
        				items:getCats(undefined,cat.id).items
        			});
        			
        		});
        	}
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
        	alert(errorThrown);
        }
    });
	return {
		has:has,
		items:items
	};
}
/**
 * 遍历取出菜单列表
 */ 
function getMenus(items){
	if(items && $.isArray(items)){
		return $.map(items,function(item){
			var menus = walkItems(item);
			return menus;
		});
	}		
}
/**
 * 遍历子菜单列表
 */
function walkItems(data){
	return {// 菜单项
		id:data.id,// 菜单ID
		label:data.name, // 菜单名，显示文本
		//href:'${path}'+data.uri, // 链接
		noclick:data.noclick,
		icon:data.icon, // 菜单图标
		className:data.styleClass,// 菜单样式
		select:function(ext,q,reload){// 返回的tabs对象
			var url = data.url;
			url = url+(q && q!=''?url.indexOf('?')!=-1?'&'+q:'?'+q:''); 
			if(ext && ext!=null && url && url!='' && url !='undefined'){
				url = path + '/'+url;
				url = url.replace(eval('/([/]+)/g'),"/");
				ext.loadExt(// 添加tab项
						{
							id:data.id,// 菜单ID,
							tab:{
								label:data.name,// 菜单名，在此作为标签文本,
								extra:true// 标签支持删除
							},
							content:{
								source:'url:'+url,// 内容为url,以iframe框架页显示
								type:'frame'
							}
						},reload,true);
			}
		},
		items:getMenus(data.items)
	};
}

/**
 * 框架页数据源请求成功
 */
function sourceSuccess(result){ 
	return $.map( result, function( item ) {
		return {
			id: item.id,
			// 标签
			tab:{
				label: item.label
			},
			 // 标签切换到目的地时加载内容
			select:function(scroller){
				// 加载菜单
				var _content = scroller.content.getTag();
				// 根据ID(导航ID)查询对应的菜单组
				// 内容页嵌套菜单对象
				scroller.menus = createMenus(_content,scroller);
			}     
		};
	});
}
/**
 * 创建菜单 
 */ 
function createMenus(_content,scroller){
	return _content.menus({
		source:function(res){
			getSource(scroller.id,res);
		},
		menuLayout:{			// 标签布局
			offset:'left',		// 标签栏位置，默认为左wmj
			menusWidth:170		// 标签栏宽度，只有设置居左或居右显示有效，默认为父容器宽度
		},
		paddingStep:25,			// 菜单内左边距步长
		complete:function(_content){ // 加载菜单结束，返回内容HTML节点，HTML节点可以创建不同对象重新传入类
			var subTabHost = _content.tabHost({
				theme:'default',
				//tabNone:true,
				//anim:true,
				showResponse:function(scroller){
					// 设置地址栏
					setUrlState(navid,scroller.id,'',scroller.data.label);
				}
			});
			return subTabHost;
		},
		afterComplete:function(){
			this.selectMenu(menuid);
		}
	});
}
/**
 * 创建框架页
 */
loadParams(function(request){
	navid = request?request.navid:''; // 当前导航ID
	menuid = request?request.menuid:''; // 当前菜单ID
	//var from = request?request.from:'';// 来源
	
	var _frame = $('#frame');
	tabHost = _frame.tabHost({
		theme:'default-navs',
		header:'<div id="top">'
				+'<div class="left frame-title">${SITENAME_ADMIN }</div>'
				+'<div class="right">'
				+'${onlineEUser.username}	<a href="${path }/logout" class="icon icon-exit"><i></i><font>退出</font></a>'
				+'</div>'
				+'<div style="clear:both"></div>'
				+'</div>',
		footer:'<div>${SITENAME_ADMIN }@${VERSION }</div>',
		anim:false,
		source:function(response){
			if(sourceRequest!=null){
				sourceRequest.abort();
			}
			var source = [{
				id:"setting",
				label:'网站设置'
			},{
				id:'ui',
				label:'UI设置'
			},{
				id:"cms",
				label:'文章管理'
			},{
				id:"safe",
				label:'安全设置'
			}];
			response(sourceSuccess(source));
		}, 
		tabLayout:{				// 标签布局
			offset:'top',		// 标签栏位置，默认为顶部
			tabsWidth:200,		// 标签栏宽度，只有设置居左或居右显示有效，默认为父容器宽度
			scroll:true			// 允许滚动
		},
		showResponse:function(scroller){
			// 显示指定标签页的回调函数
			resizeScroller(scroller);
			navid = scroller.id;
			// 设置地址栏
			//setUrlState(navid,'','',scroller.data.label);
		}		
	});
	// 加载,如果navid不为空，将会选中此标签页
	tabHost.load(navid); 
	// 调整尺寸
	resize();
	// 监听调整尺寸
	$(window).resize(function(){
		resize();
	});	
	function resize(){
		$('#frame').width($(window).width());
		$('#frame').height($(window).height());
		tabHost.resize(function(scroller){
			resizeScroller(scroller);
		});
	}
	// 调整指定滚动标签页尺寸
	function resizeScroller(scroller){
		if(scroller.content){
			scroller.content.show(true,function(){
				if(scroller.menus)
					scroller.menus.resize(function(ext){
						 if(ext && ext !=null)
							 ext.resize(function(scler){
									if(scler.content){
										scler.content.show(false);
									}
							 });
					});
			});
		}
	}
});

function openTab(navid,menuid,q,reload){
	tabHost.load(navid,reload,function(scroller){
		var menus = scroller.menus;
		if(menus){
			menus.selectMenu(menuid,q,true);
		}
	});
}
function refresh(){
	// menus.selectMenu(menuid,'',true);// reload=true
}
function remove(navid,menuid,label){
	tabHost.load(navid,false,function(scroller){
		var menus = scroller.menus;
		if(menus){
			var ext = menus.ext;
			ext.removeById(menuid);
		}
	});
}
</script>

</body>
</html>
