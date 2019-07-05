<%
/**
	列表
	2014-12-23创建@杨大江
	v1.0
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tag.fixwork.org/taglib/core" prefix="t"%>
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
			<a id="edit"  class="button"   corner-right="no">编辑页面信息</a> 
			<a id="row"  class="button"  border-left="no" corner-right="no">页面排版</a> 
			<a class="button refresh" border-left="no">刷新</a> 
		</div>
		<div class="right"></div>
	</div>

	<div class="content">
		<table class="list">
			<tr>
				<th width=30><input type="checkbox" name="picks"></th>
				<th>页面名称</th>
				<th>标题</th>
				<th>关键词</th>
				<th>描述</th>
				<th>发布时间</th>
				<th>修改时间</th>
			</tr>
			<c:forEach items="${list }" var="item" varStatus="status">
				<tr>
					<td>
						<input type="checkbox" name="pick" value="${item.id }">
					</td>
					<td>
						<span>
						<c:if test="${item.name == 'index' }">
							首页
						</c:if>
						<c:if test="${item.name == 'list' }">
							列表页
						</c:if>
						<c:if test="${item.name == 'info' }">
							内容页
						</c:if>
						</span>
					</td>
					<td><span>${item.title }</span></td>
					<td><span>${item.keywords }</span></td>
					<td><span>${item.descri }</span></td>
					<td><span>${item.createTime }</span></td>
					<td><span>${item.updateTime }</span></td>
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
	var enableEdit,enableRow;
	/**
	 * 启用所有有限制的操作按钮
	 */
	function enableButtons(){
		$.grep(buttons,function(item){
			item.button.setDisable(false);
		});
		enableEdit = true;
		enableRow = true;
	}
	/**
	 * 禁用所有有限制的操作按钮
	 */
	function disableButtons(){
		$.grep(buttons,function(item){
			if(item.id == 'edit' 
					|| item.id == 'row'){
				item.button.setDisable(true);
			}
		});
		enableEdit = false;
		enableRow = false;
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
				getButton('row').setDisable(true);
				enableEdit = false;
				enableRow = false;
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
		}else {
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
		var url = '${path}/ui/page/edit?id=' + id;
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

	$('#row').click(function() {
		if (!enableRow) {
			return;
		}
		var picks = getCheckboxValues("pick");
		window.parent.openTab(window.parent.navid,'row-col','pageId='+picks[0]);
	});

</script>
</body>
</html>
