<%
/**
	列表
	2014-7-23创建@杨大江
	v1.0
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${title }</title>
<!-- 加载样式文件 -->
<jsp:include page="../include/easy-ui-header.jsp"></jsp:include>
</head>
<body>
<!-- body start -->
<table id="dg" class="easyui-datagrid">
	</table>
	<div id="tb" style="padding:2px 5px;">
		<a href="javascript:reload()" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" >刷新</a>
		<a href="javascript:edit('添加内容');" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:modi();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		<a href="javascript:remove();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<input id="searchbox" style="width:150px"></input>
	</div>
	
	<script type="text/javascript">

	var keyword = '${keyword}';
	var defaultPageSize = 15;
	var pageList = [10, 15, 20, 30];

	function edit(title,id) {
		id = id?id:"";
		var url = '${path}/cms/edit?id='+ id+'&cid=${cid}';
		dialog = $.dialog({
			title : title,
			content : 'url:' + encodeURI(url),
			lock : true,
			max:false,
			min:false,
			close:function(){
				reload();
			}
		}).max();
		
	}

	function reload(){
		$('#dg').datagrid('reload');
	}
	function modi(){
		var row = $('#dg').datagrid('getSelected');
		if (row){
			edit('修改内容',row.id);
		}
	}
	function remove(){

		var ss = [];
		var rows = $('#dg').datagrid('getSelections');
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			ss.push(row.id);
		}
		if(ss.length > 0)
		$.messager.confirm('提示','你确定要删除该数据么?',function(r){
		    if (r){
				// 提交URL
				var url = '${path }/cms/del';
				$.ajax({
					type : 'POST',
					async: false,
					dataType : 'JSON',
					url : url,
					data : {
						printMode: 'JSON',
						"ids" : ss.toString()
					},
					beforeSend : function() {
					},
					success : function(data) {
						if (data && data.success) {
							// 成功
							$('#dg').datagrid('reload');
						} else if(data.error){
							$.messager.alert('提示',data.error.message);
						}else{
							$.messager.alert('提示','删除失败!');
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert(errorThrown);
					}
				});
		    }
		});
	}
	$('#searchbox').searchbox({
	    searcher:function(kw,mode){	
	    	keyword = kw;
   	    	$('#dg').datagrid('load',{
 				pageSize:defaultPageSize,
 				keyword:kw
	    	});
	    },
	    prompt:'请输入关键字'
	});
	
	$(function(){
		
		 $('#dg').datagrid({ 
				toolbar: '#tb',
		        loadMsg:'正在加载数据......',
		        columns: [[{
		            field: 'ck',
		            checkbox:true
		        },{
		            field: 'images',
		            title: '图片',
					formatter:function(value,row){
						if(row.images && row.images.length > 0){
							return '<div style="margin-top:5px;margin-left:5px">'+
							'<img src="${ATTACH_PREFIX}'+row.images[0].url+'"  border=0 width="22" height="22"/> ... </div>';
						}else{
							return '<span>无</span>';
						}
					}
		        },{
		            field: 'title',
		            title: '标题',
		            sortable:true,
					formatter:function(value,row){
						return row.video && row.video != ''?value+'[视频]':value;
					}
		        },{
		            field: 'subtitle',
		            title: '副标题'
		        },{
		            field: 'href',
		            title: '自定义链接',
		            sortable:true
		        },{
		            field: 'source',
		            title: '作者/来源',
		            sortable:true
		        },{
		            field: 'fileTotal',
		            title: '附件总数',
		            sortable:true,
					formatter:function(value,row){
						return row.files?row.files.length:0;
					}
		        },{
		            field: 'recom',
		            title: '推荐到',
		            sortable:true,
					formatter:function(value,row){
						if(value == '${RECOM_DEFAULT }')
							return '默认';
						else if(value == '${RECOM_PAGE_LIST}')
							return '列表页';
						else if(value == '${RECOM_PAGE_INNER}')
							return '内页';
						else if(value == '${RECOM_PAGE_MODULE_INDEX}')
							return '模块首页';
						else if(value == '${RECOM_PAGE_SITE_INDEX}')
							return '全站首页';
						else 
							return '未设置';
					}
		        },{
		            field: 'status',
		            title: '状态',
		            sortable:true,
					formatter:function(value,row){
						if(value == '${STATUS_CREATE}')
							return '创建';
						if(value == '${STATUS_SUBMIT}')
							return '提交未审核';
						if(value == '${STATUS_AUDITING}')
							return '提交审核';
						if(value == '${STATUS_AUDIT_OK}')
							return '审核通过';
						if(value == '${STATUS_AUDIT_NO}')
							return '审核不通过';
						else
							return '未设置';
					}
		        },{
		            field: 'createTime',
		            title: '发布时间',
		            sortable:true
		        },{
		            field: 'updateTime',
		            title: '修改时间',
		            sortable:true
		        },{
		            field: 'brower',
		            title: '访问量'
		        }]],
		        remoteSort:false,
		        multiSort:false,
		       	rownumbers: true,
				fit: true,   //自适应大小
		        loadMsg:'正在加载数据......   ',
				striped:true,
				pagination: true,     //开启分页  
				pageSize:defaultPageSize,
		        pageList: pageList, //设置每页记录条数的列表 
		        url: '${path}/cms/getList', //获取数据地址
	    		queryParams:{
					pageSize:defaultPageSize,
					keyword:keyword,
					cid:'${cid}'
		    	}, 
		        showFooter:true , 
				onLoadSuccess:function(){
					//onLoadSuccess();
				},
		    	loadFilter:function(data){
		    		if(!data.rows){
		    			data.rows = [];
		    		}
		    		return data;
		    	}
		 });

		 $('#dg').datagrid('getPager').pagination({ 
		    	onSelectPage:function(pageNumber, pageSize){
		            var opts = $('#dg').datagrid('options');
		            opts.pageNumber = pageNumber;
		            opts.pageSize = pageSize;
		            opts.queryParams.pageNumber = pageNumber;
		            opts.queryParams.pageSize = pageSize;
		    		defaultPageSize = pageSize;
		            $('#dg').datagrid('reload'); //重新加载表格
		    	}
			});

	});

	</script> 
	
	
</body>
</html>
