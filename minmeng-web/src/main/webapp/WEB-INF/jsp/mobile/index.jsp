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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="${page.keywords }">
<meta name="description" content="${page.descri }">
<meta name="viewport" content="width=device-width,  initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>${title }</title>
<jsp:include page="include/css.jsp"></jsp:include>
<style type="text/css">
body{background:#fff}

</style>
</head>
<body>
	<!-- body start -->
<c:set var="urlPrefix" value="${ATTACH_PREFIX}/"></c:set>
	<jsp:include page="include/top.jsp"></jsp:include>

		<jsp:include page="include/searchbar.jsp"></jsp:include>

		<div class="views">
				<c:forEach items="${pageViews }" var="item" varStatus="status">
		        		<jsp:include page="/View">
		        			<jsp:param value="${item.view.id }" name="id"/>
		        		</jsp:include>
				</c:forEach>
		</div>
	<div style="clear:both;height:20px"></div>
	<jsp:include page="include/footer.jsp"></jsp:include>
	<jsp:include page="include/js.jsp"></jsp:include>
</body>
</html>
