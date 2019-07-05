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
<jsp:include page="../../include/css.jsp"></jsp:include>
<style type="text/css">
.content{
	padding:20px
}

</style>
</head>
<body>
<!-- body start -->
<!-- 正文 -->
<div class="center">
	<div class="content">
		<div class="no-data">
			<span style="font-size:16px;">${error }</span>
			<div style="clear:both;height:20px"></div>
			<a class="button" id="choosepage" corner-right="no">选择控件</a>
			<a class="button" id="shutdown" border-left="no">关闭</a>
		</div>
	</div>
</div>
<!-- body end -->
<jsp:include page="../../include/js.jsp"></jsp:include>
<script type="text/javascript">
$('#choosepage').click(function() {
	window.parent.openTab(window.parent.navid,'view');
});
$('#shutdown').click(function() {
	window.parent.remove(window.parent.navid,'view-item','');
});
</script>
</body>
</html>
