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
<meta name="keywords" content="${page.keywords }">
<meta name="description" content="${page.descri }">
<title>${title }</title>
<jsp:include page="include/css.jsp"></jsp:include>
<style type="text/css">  
body{background:#fff}

</style>
</head>
<body>
	<c:set var="urlPrefix" value="${ATTACH_PREFIX}/"></c:set>
	<!-- body start --> 
	<jsp:include page="include/top.jsp"></jsp:include>
		<div id="myCarousel" class="carousel slide">
		    <!-- 轮播（Carousel）项目 -->
		    <div class="carousel-inner">
				<c:forEach items="${rotationData }" var="item" varStatus="status">
		        <div class="item <c:if test="${status.index == 0 }">active</c:if>" style="background-image:url(${urlPrefix}${item.image})"></div>
				</c:forEach>
		    </div>
		</div>
		<jsp:include page="include/searchbar.jsp"></jsp:include>

		<div class="views">
				<c:forEach items="${pageViews }" var="item" varStatus="status">
					<%-- 
					<c:choose>
						<c:when test="${view.mode eq '0' }">
						</c:when>
						<c:when test="${view.mode eq '1' }">
							<c:choose>
								<c:when test="${fn:contains(view.style, 'single')  }">
								</c:when>
								<c:when test="${fn:contains(view.style, 'multi')  }">
								</c:when>
							</c:choose>
						</c:when>
						<c:when test="${view.mode eq '2' }">
						</c:when>
					</c:choose> 
					--%>
		        		<jsp:include page="/View">
		        			<jsp:param value="${item.view.id }" name="id"/>
		        		</jsp:include>
				</c:forEach>
		</div>
			
	<div style="clear:both;height:20px"></div>
	<jsp:include page="include/footer.jsp"></jsp:include>
	<jsp:include page="include/js.jsp"></jsp:include>
	<!-- body end --> 
	<script type="text/javascript">
	
	</script>
</body>
</html>
