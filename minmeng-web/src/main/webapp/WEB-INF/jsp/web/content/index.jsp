<%
/**
	栏目
	2014-12-28创建@杨大江
*/
%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="${page.keywords }">
<meta name="description" content="${page.descri }">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title }</title>
<jsp:include page="../include/css.jsp"></jsp:include>
</head>
<body>
<!-- body start -->
<jsp:include page="../include/top.jsp"></jsp:include>
<jsp:include page="../include/footer.jsp"></jsp:include>
<jsp:include page="../include/js.jsp"></jsp:include>
<!-- body end -->
</body>
</html>
