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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${title }</title>
<!-- 加载样式文件 -->
<jsp:include page="../include/css.jsp"></jsp:include>
<style type="text/css">
.item{
	border:0;
	margin-right:10px;
}
.m-user{
	color:green;
	line-height:22px;
}

</style>
</head>
<body>
<!-- body start -->
<!-- 正文 -->
<div class="center">
	<div class="buttons">
		<div class="left">
			<a id="add"  class="button" corner-right="no">添加分类</a> 
			<a id="edit" class="button" border-left="no" corner-right="no">编辑分类</a> 
			<a id="addChild" class="button" border-left="no" corner-right="no">添加下级分类</a> 
			<a id="contents" class="button" border-left="no" corner-right="no">管理内容</a> 
			<a id="del" class="button" border-left="no" corner-right="no">删除分类</a>  
			<a class="button refresh" border-left="no">刷新</a> 
		</div>
		<div class="right"></div>
	</div>

	<div class="content" style="padding:5px">
		<div><input type="checkbox" name="picks">所有分类</div>
		<div id="tree"></div>
	</div>
</div>
<!-- body end -->
<jsp:include page="../include/js.jsp"></jsp:include>
<script type="text/javascript">
	var enableEdit,enableAddChild,enableContents,enabledel;
	/**
	 * 启用所有有限制的操作按钮
	 */
	function enableButtons(){
		$.grep(buttons,function(item){
			item.button.setDisable(false);
		});
		enableEdit = true;
		enableAddChild = true;
		enableContents = true;
		enabledel = true;
	}
	/**
	 * 禁用所有有限制的操作按钮
	 */
	function disableButtons(){
		$.grep(buttons,function(item){
			if(item.id == 'edit' 
				|| item.id == 'addChild' 
					|| item.id == 'contents' 
					|| item.id == 'del' ){
				item.button.setDisable(true);
			}
		});
		enableEdit = false;
		enableAddChild = false;
		enableContents = false;
		enabledel = false;
	}
	listenerPicks();

	function listenerPicks(){
		disableButtons();
		/**
		 * 切换全选/全不选
		 */
		$(':checkbox[name="picks"]').change(function() {
			if ($(this).attr('checked') == 'checked') {
				$(':checkbox[name="pick"]').prop("checked", true);
				var picks = getCheckboxValues("pick");
				if (picks.length > 1) {
					getButton('edit').setDisable(true);
					getButton('addChild').setDisable(true);
					getButton('contents').setDisable(true);
					getButton('del').setDisable(false);
					enableEdit = false;
					enableAddChild = false;
					enableContents = false;
					enabledel = true;
				} else if (picks.length == 1) {
					enableButtons();
				} else {
					disableButtons();
				}
			} else {
				disableButtons();
				$(':checkbox[name="pick"]').prop("checked", false);
			}
		});
		$(':checkbox[name="pick"]').change(function() {
			var picks = getCheckboxValues("pick");
			if (picks.length == 1) {
				enableButtons();
			} else if (picks.length > 0) {
				disableButtons();
				getButton('del').setDisable(false);
				enabledel = true;
			} else {
				disableButtons();
			}
			var size = $(':checkbox[name="pick"]').size();
			var checkbox = $(':checkbox[name="picks"]');
			if(picks.length == size){
				checkbox[0].indeterminate = false;
				checkbox.prop("checked", true);
			}else if(picks.length == 0){
				checkbox[0].indeterminate = false;
				checkbox.prop("checked", false);
			}else{
				checkbox.prop("checked", true);
				checkbox[0].indeterminate = true;
			}
		});
	}

	var url = '${path }/cat/getCats';
	$('#tree').tree({
		ajaxUrl:url,
		iconPrefix:'${ATTACH_PREFIX}/',
		checkboxName:'pick',
		complete:function(){
			listenerPicks();
		}
	});
	var dialog;
	function edit(id,parentId) {
		id = id?id:"";
		parentId = parentId?parentId:"";
		var url = '${path}/cat/edit?id=' + id+"&parentId="+parentId;
		dialog = $.dialog({
			title : false,
			content : 'url:' + url,
			lock : true
		});
		dialog.max();
	}
	
	$('#add').click(function() {
		edit(); 
	});

	$('#edit').click(function() {
		if (!enableEdit) {
			return;
		}
		var picks = getCheckboxValues("pick");
		edit(picks[0]);
	});

	$('#contents').click(function() {
		if (!enableEdit) {
			return;
		}
		var picks = getCheckboxValues("pick");
		window.parent.openTab('cms',picks[0],'cid='+picks[0],true);
	});
	
	$('#addChild').click(function() {
		if (!enableEdit) {
			return;
		}
		var picks = getCheckboxValues("pick");
		edit('',picks[0]);
	});
	
	$('#del').click(function() {
		if (!enabledel) {
			return;
		}
		var picks = getCheckboxValues("pick");
		handle("删除选定分类，将同时删除所有子分类，你确定要删除么？", function() {
			// 提交URL
			var url = '${path }/cat/del';
			var data = {
				"ids" : picks.toString()
			};
			delDatas(url, data);
		}, function() {
			return false;
		});
	});

	 $('.status-button').click(function(){
		 var id = $(this).attr('id');
		 var status = 0;
		 if($(this).hasClass('disabled')){
			 // 点击启动显示
			 status = '${status_YES}';
		 }else if($(this).hasClass('enabled')){
			 status = '${status_NO}';
		 }else{
			$.dialog.tips("<font size=4>设置错误</font>",2,'error.gif');
		 }		 
		 handle("你确定要更改选中条目状态么？", function() {
				// 提交URL
				var url = '${path }/cat/setstatus';
				var data = {
					"id" : id,
					"status":status
				};
				execute(url, data);
			}, function() {
				return false;
			});
	 });

</script>
</body>
</html>
