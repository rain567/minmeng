<%
/**
	导航列表
	2014-12-25创建@杨大江
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
<jsp:include page="../../include/css.jsp"></jsp:include>
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
			<a id="add"  class="button" corner-right="no">添加导航</a> 
			<a id="edit" class="button" border-left="no" corner-right="no">编辑导航</a> 
			<a id="del" class="button" border-left="no" corner-right="no">删除导航</a> 
			<a class="button refresh" border-left="no">刷新</a> 
		</div>
		<div class="right"></div>
	</div>

	<div class="content">
		<table class="list">
			<tr>
				<th width=30><input type="checkbox" name="picks"></th>
				<th>导航名称</th>
				<th>导航别名</th>
				<th>链接地址</th>
				<th>导航类型</th>
				<th>关联分类</th>
				<th>子导航深度</th>
				<th width=80>启用状态</th>
				<th width=80>排序</th>
			</tr>
			<c:forEach items="${list }" var="item" varStatus="status">
				<tr>
					<td>
						<input type="checkbox" name="pick" value="${item.id }">
					</td>
					<td>${item.name }</td>
					<td>${item.alias }</td>
					<td><font color=blue>${item.link }</font></td>
					<td>
						<c:if test="${ item.navType == '' }">
							<font color=#ccc>未设置类型</font>
						</c:if>
						<c:if test="${item.navType == '1' }">
							<font color=gray>文本导航</font>
						</c:if>
						<c:if test="${item.navType == '2' }">
							<font color=green>关联分类</font>
						</c:if>
					</td>
					<td>${item.cat.name }</td>
					<td>${item.subDepth }</td>
					<td>
						<c:if test="${item.status == 1 }">
							<div class="status-button enabled" id="${item.id }"></div>
						</c:if>
						<c:if test="${item.status == 0 }">
							<div class="status-button disabled" id="${item.id }"></div>
						</c:if>
					</td>
					<td>${item.sorter }</td>
				</tr>
			</c:forEach>
		</table>
		<div class="no-data">${nodata }</div>
		${paginationHtml }
	</div>
</div>
<!-- body end -->
<jsp:include page="../../include/js.jsp"></jsp:include>
<script type="text/javascript">
	var enableEdit,enabledel;
	/**
	 * 启用所有有限制的操作按钮
	 */
	function enableButtons(){
		$.grep(buttons,function(item){
			item.button.setDisable(false);
		});
		enableEdit = true;
		enabledel = true;
	}
	/**
	 * 禁用所有有限制的操作按钮
	 */
	function disableButtons(){
		$.grep(buttons,function(item){
			if(item.id == 'edit' 
					|| item.id == 'del'){
				item.button.setDisable(true);
			}
		});
		enableEdit = false;
		enabledel = false;
	}
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
				getButton('del').setDisable(false);
				enableEdit = false;
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

	var dialog;
	function edit(id) {
		id = id?id:"";
		var url = '${path}/ui/nav/edit?moduleId=${module.id}&id=' + id;
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

	$('#del').click(function() {
		if (!enabledel) {
			return;
		}
		var picks = getCheckboxValues("pick");
		handle("你确定要删除选定条目么？", function() {
			// 提交URL
			var url = '${path }/ui/nav/del';
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
				var url = '${path }/ui/nav/setstatus';
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
