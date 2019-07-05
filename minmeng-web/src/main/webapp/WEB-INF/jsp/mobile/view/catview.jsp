<%
/**
	单栏目
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
	<div class="main">
	<div class="view-title"><a href="${view.link }" target=_blank></a></div>
	<div class="view-list">
		<%// 插入子控件 %>
		<c:forEach items="${befores }" var="item" varStatus="status">
		     <jsp:include page="/View">
		    		<jsp:param value="${item.id }" name="id"/>
		     </jsp:include>
		</c:forEach>
		<%// 插入子控件结束 %>
		<div class="list-tabs">
		<c:forEach items="${data}" var="entry">
				<a class="list-tab"><span>${entry.key.name}</span></a>
		</c:forEach>
		</div>
		<div class="list-contents">
		<c:forEach items="${data}" var="entry">
			<div class="list-item">
				<div class="list-item-icon" style="background-image:url(${ATTACH_PREFIX}/${entry.key.icon});"></div>
				<div class="list-item-lable">
						${entry.key.name}
				</div>
				<ul>
				<c:forEach items="${entry.value }" var="item" varStatus="status">
					<c:if test="${!empty item.href}">
						<c:set var="href" value="${item.href}" />
					</c:if>
					<c:if test="${empty item.href}">
						<c:set var="href" value="${path}/c/${item.cat.uri}/${item.id}" />
					</c:if>
					
				   <li>
					   	<a href="${href }">
							<span class="item-img" style="background:url(${ATTACH_PREFIX}/<c:if test="${fn:length(item.images) > 0 }">${item.images[0].url }</c:if><c:if test="${fn:length(item.images) == 0 }">${DEFASULT_IMG_SRC}</c:if>) no-repeat center;background-size:cover;"></span>
							<span class="item-time"><t:dateFormat source="${item.createTime }" force="true"></t:dateFormat></span>
							<span class="item-title link">${item.title }</span>
						</a>
						<div class="item-content"><t:subText length="145" source="${item.content }" postfix="..."></t:subText></div>
					
					</li>
				</c:forEach> 
				</ul>
			</div>
		</c:forEach>
		</div>
		<%// 插入子控件 %>
		<c:forEach items="${afters }" var="item" varStatus="status">
		     <jsp:include page="/View">
		    		<jsp:param value="${item.id }" name="id"/>
		     </jsp:include>
		</c:forEach>
		<%// 插入子控件结束 %>
	</div>
	</div>
</div>
<div style="clear:both"></div>