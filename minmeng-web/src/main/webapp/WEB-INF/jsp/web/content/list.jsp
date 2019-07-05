<%
/**
	栏目
	2014-12-28创建@杨大江
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title }</title>
<jsp:include page="../include/css.jsp"></jsp:include>
</head>
<body>
<!-- body start -->
<c:set var="urlPrefix" value="${ATTACH_PREFIX}/"></c:set>
	<jsp:include page="../include/top.jsp"></jsp:include>
	<jsp:include page="../include/subnavbar.jsp"></jsp:include>
	<div class="main" style="overflow:hidden">
	<div class="page-title">
			<div class="left">
				<span class="title"><a href="${path}">首页</a> &raquo; ${catname }</span>
			</div>
			<div class="right">
			<%-- 	<a href='${url}&ls=${LIST_STYLE_TEXT }' class="ls-btn <c:if test="${ls eq LIST_STYLE_TEXT}">select</c:if>">文字列表</a>
				<a href='${url}&ls=${LIST_STYLE_TEXT_IMAGE}' class="ls-btn <c:if test="${ls eq LIST_STYLE_TEXT_IMAGE}">select</c:if>">图文并茂</a>
			 --%>
			</div>
			<div style="clear:both"></div>
	</div>
	<div class="list-page" >
		<!-- 文字列表 -->
		<c:if test="${ls eq LIST_STYLE_TEXT}">
		<div class="text-list">
		<c:forEach items="${infos }" var="item" varStatus="status">
				<dl>
					<dd>
						
						<a href="<c:if test="${!empty item.href}">${item.href}</c:if><c:if test="${empty item.href}">${path}/c/${cat.uri}/${item.id}</c:if>"  class="link">
							<span class="point">&middot; </span>
							<span>${item.title }</span>
						</a>
					</dd>
					<dd class="time">
					<span>
						<t:dateFormat source="${item.createTime }" force="true"></t:dateFormat>
					</span>
					</dd>
				</dl>
				<div style="clear:both"></div>
		</c:forEach>
		</div>
		</c:if> 
		<!-- 图文列表 -->
		<c:if test="${ls eq LIST_STYLE_TEXT_IMAGE  }">
		<div class="text-image-list">
		<c:forEach items="${infos }" var="item" varStatus="status">
				<c:if test="${!empty item.href}">
					<c:set var="href" value="${item.href}" />
				</c:if>
				<c:if test="${empty item.href}">
					<c:set var="href" value="${path}/c/${cat.uri}/${item.id}" />
				</c:if>
				
				<div class="item">
					
					<c:if test="${fn:length(item.images) > 0 }">
						<div class="item-img">	
							<a href="${href }">
							<span style="background:url(${urlPrefix}${item.images[0].url }) no-repeat center;background-size:cover;"></span>
							</a>
						</div>
					</c:if>
					<div class="item-texts <c:if test="${fn:length(item.images) > 0 }">float</c:if>">
						<div class="item-title">
							<a href="${href }"  class="link">
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
							<a href="${href }">							
							<t:subText length="170" source="${item.content }" postfix="..."></t:subText>
							</a>
						</div>
						<div class="item-normal">	
							<a href="${href }" class="goinfo">详情</a>
							<div style="clear:both"></div>
						</div>
					</div>
					<div style="clear:both"></div>
				</div>
		</c:forEach>
		</div>
		</c:if> 
		<c:if test="${!empty nodata }">
		<div class="no-data">${nodata }</div>
		</c:if>
		<c:if test="${!empty paginationHtml }">
		<div style="text-align:center">
		${paginationHtml }
		</div>
		</c:if>
	</div>
	</div>
<jsp:include page="../include/footer.jsp"></jsp:include>
<jsp:include page="../include/js.jsp"></jsp:include>
<!-- body end -->
</body>
</html>
