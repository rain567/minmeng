<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tag.fixwork.org/taglib/core" prefix="t"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>tree</title>
<!-- 加载样式文件 -->
 
<jsp:include page="../../include/css.jsp"></jsp:include> 
<style type="text/css">
.name{line-height:28px;font-size:14px;color:#777}
</style> 

</head>
<body>
<input type="hidden" name="viewId" id="viewId">
<input type="hidden" name="refresh" id="refresh" value="false">
<div id="treeContainer">
	<t:viewTree filterId="${id }"></t:viewTree> 
</div> 
<jsp:include page="../../include/js.jsp"></jsp:include>

<script type="text/javascript">
$('#treeContainer').find('a.name').click(function(){
	var id = $(this).attr('id');
	$('input[name="viewId"]').val(id);
	$('input[name="refresh"]').val("true");
	window.parent.dialog.close();
});
</script>	
</body>
</html>