<%
/**
	模块首页
	2014-3-30创建@杨大江
*/
%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Access-Control-Allow-Origin" content="*">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>错误</title>
<jsp:include page="../include/css.jsp"></jsp:include>
<style type="text/css">
body{background:#fff}

</style>
</head>
<body>
	<!-- body start -->
	<jsp:include page="../include/top.jsp"></jsp:include>
	<div class="main">
	<div class="error-page ${code }">
		<div class="error-message">${error }</div>
	</div>
	</div>
	<jsp:include page="../include/footer.jsp"></jsp:include>
	<jsp:include page="../include/js.jsp"></jsp:include>
	<!-- body end --> 
	<script type="text/javascript">
	
	</script>
</body>
</html>
