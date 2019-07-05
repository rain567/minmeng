<%
/**
	顶部
	v1.0
	2014-8-6创建@杨大江
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tag.fixwork.org/taglib/core" prefix="t" %>

<div class="navbar">
	<div class="main">
	<ul>
		<li class="header"><a class="logo" href="${path }/"></a></li>
		<c:forEach items="${navs }" var="nav" varStatus="status">
			<li class="nav">
				<a  class="a" href="<c:if test="${fn:startsWith(nav.link, 'http://')}">${nav.link }</c:if>
				<c:if test="${!fn:startsWith(nav.link, 'http://')}">${path}<c:if test="${!fn:startsWith(nav.link, '/')}">/</c:if>${nav.link }</c:if>"> 
					<span style="position:relative">${nav.name }</span> 
				</a> 
				<c:if test="${nav.subDepth > 0 }">
					<ul class="subnavbar">
					<t:subNavs catId="${nav.cat.id }" subDepth="${nav.subDepth }" urlPrefix="${path }"></t:subNavs>
					</ul>
				</c:if>
			</li>
		</c:forEach>
	</ul>
	</div>
</div>
<div style="clear:both"></div>
