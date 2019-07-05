<%
/**
	搜索
	2015-1-21创建@杨大江
*/
%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tag.fixwork.org/taglib/core" prefix="t" %>
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
.item-descri{font-size:13px;color:#484848}
</style>
</head>
<body>
<!-- body start -->
<c:set var="urlPrefix" value="${ATTACH_PREFIX}/"></c:set>
<jsp:include page="include/top.jsp"></jsp:include>
	<jsp:include page="include/searchbar.jsp"></jsp:include>
	<div class="main" style="overflow:hidden">
	<div style="clear:both"></div>
	<div class="list-page">
		<c:if test="${!empty paginationHtml }">
		<div style="text-align:center">
		${paginationHtml }
		</div>
		</c:if>
		<!-- 图文列表 -->
		<div class="text-image-list">
		<c:forEach items="${items }" var="item" varStatus="status">
				<div class="item">
					
					<c:if test="${fn:length(item.images) > 0 }">
						<div class="item-img">	
							<a href="${item.href }">
							<span style="background:url(${urlPrefix}${item.images[0] }) no-repeat center;background-size:cover;"></span>
							</a>
						</div>
					</c:if>
					
					<div class="item-texts <c:if test="${fn:length(item.images) > 0 }">float</c:if>">
						<div class="item-title">
							<a href="${item.href }">
								<span style="font-weight:bold">${item.title }</span>
							</a>
						</div>
						<div class="item-normal">
							<c:if test="${item.source != '' }">
							<span class="source">
								${item.source }
							</span>
							</c:if>
							<span class="time">
								<t:dateFormat source="${item.createTime }" force="true"></t:dateFormat>
							</span>
						</div>
						<div class="item-descri">	
							<a href="${item.href }">							
							<t:subText length="65" source="${item.content }" postfix="..."></t:subText>
							</a>
						</div>
					</div>
					<div style="clear:both"></div>
				</div>
				<div style="clear:both"></div>
		</c:forEach>
		</div>
		<c:if test="${!empty result.error.message }">
		<div class="no-data">${result.error.message }</div>
		</c:if>
		<c:if test="${!empty paginationHtml }">
		<div style="text-align:center">
		${paginationHtml }
		</div>
		</c:if>
	</div>
	</div>
<jsp:include page="include/footer.jsp"></jsp:include>
<jsp:include page="include/js.jsp"></jsp:include>
<!-- body end -->
</body>
</html>
