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
<div class="view ${view.style }">
	<div class="view-title"><a href="${view.link }" target=_blank></a></div>
	<div class="view-list">
		<%// 插入子控件 %>
		<c:forEach items="${befores }" var="item" varStatus="status">
		     <jsp:include page="/View">
		    		<jsp:param value="${item.id }" name="id"/>
		     </jsp:include>
		</c:forEach>
		<%/* 插入子控件结束*/ %>
		<c:forEach items="${items }" var="item" varStatus="status">
			<div class="item <c:if test="${fn:length(items) == status.index +1 }">last</c:if>">
			   <div class="item-img" style="background:url(${ATTACH_PREFIX}/${item.image}) no-repeat center;background-size:cover;">
				   	<a target=_blank href="${item.link }"></a>
				</div>
			   	<c:if test="${!empty item.content}">
				   <a class="item-content" <c:if test="${!empty item.link}">href="${item.link }"</c:if>>
					  <span>${item.content}</span>
					</a>
			   	</c:if>
			</div>
		</c:forEach> 
		<%// 插入子控件 %>
		<c:forEach items="${afters }" var="item" varStatus="status">
		     <jsp:include page="/View">
		    		<jsp:param value="${item.id }" name="id"/>
		     </jsp:include>
		</c:forEach>
		<%// 插入子控件结束 %>
	</div>
</div>