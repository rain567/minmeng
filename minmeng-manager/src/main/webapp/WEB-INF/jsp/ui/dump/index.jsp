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
.clicks a{
	color:#333;cursor:pointer;
	float:left;line-height:22px;padding-left:10px;padding-right:10px;
}
.restore,.del{cursor:pointer}
.clicks a:hover{color:#ff0000}
.clicks a.select,.clicks a.select:hover{color:#fff;background:#0066cc}
.sbutton{border:0;background:#ff6600;height:20px}
.sbutton:hover{border:0;background:#cc0000;}
td span{float:left}
</style>
</head>
<body>
<!-- body start -->
<!-- 正文 -->
<div class="center">
	<div class="buttons">
			<div class="left clicks">
				<a class="refresh" >刷新</a> 
				<a href="?mode=all" <c:if test="${mode != '0' && mode != '1'}">class="select"</c:if>>全部</a>
				<a href="?mode=0" <c:if test="${mode == '0' }">class="select"</c:if>>备份记录</a>
				<a href="?mode=1" <c:if test="${mode == '1' }">class="select"</c:if>>还原记录</a>
			</div>
			<div class="left">
			<form action="?" method="get" style="margin:0;padding:0">
				<input type="hidden" name="productId" value="${product.id }">
						开始时间：
						<input type="text" class="Wdate text" name="startTime" name='startTime'
								 style="width:90px;padding-top:0;padding-bottom:0;" id="d412" 
								 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" 
								 value="${startTime }"/>
						结束时间：
						<input type="text" class="Wdate text" name="endTime" name='endTime'
								 style="width:90px;padding-top:0;padding-bottom:0;" id="d412" 
								 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" 
								 value="${endTime }"/>
						描述：<input type="text" class="text" name="keyword" value="${keyword }" style="width:90px;padding-top:2px;padding-bottom:2px;"/>
				<button type="submit" class="sbutton" style="color:#fff">查询</button> 
			</form>
			</div>
	</div>

	<div class="content">
		<table class="list">
			<tr>
				<th width=60>模式</th>
				<th width=60>版本</th>
				<th width=150>sql文件</th>
				<th>说明</th>
				<th width=80>操作员</th>
				<th width=140>备份时间</th>
				<th width=120>操作</th>
			</tr>
			<c:forEach items="${list }" var="item" varStatus="status">
				<tr>
					<td>
						<c:if test="${item.mode == '0' }"><font color=green>备份</font></c:if>
						<c:if test="${item.mode == '1' }"><font color=red>还原</font></c:if>
					</td>
					<td>${item.id }</td>
					<td><span>${item.sqlFile }</span></td>
					<td><span>${item.descri }</span></td>
					<td>${item.username }</td>
					<td>${item.createTime}</td>
					<td>
						<c:if test="${item.mode == '0' }"><a class="restore" id="${item.id }">还原</a> ｜ </c:if>
						<a class="del" id="${item.id }">删除</a>
						
					</td>
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
	$('.restore').click(function() {
		var dumpId = $(this).attr('id');
		handle("你确定要还原到此时间设置么？", function() {
			// 提交URL
			var url = '${path }/ui/dump/restore';
			var data = {
				"dumpId" : dumpId
			};
			execute(url, data);
		}, function() {
			return false;
		});
	});

	$('.del').click(function() {
		var dumpId = $(this).attr('id');
		handle("你确定要删除该条记录么？", function() {
			// 提交URL
			var url = '${path }/ui/dump/del';
			var data = {
				"dumpId" : dumpId
			};
			delDatas(url, data);
		}, function() {
			return false;
		});
	});
</script>
</body>
</html>
