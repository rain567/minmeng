
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
<c:if test="${fn:length(subcats) > 0 }">
<div class="navbar simple">
	<div class="main">
	<ul>
		<c:forEach items="${subcats }" var="cat" varStatus="status">
			<li class="nav">
				<a  class="a" href="${path }/c/${cat.uri}"> 
					<span style="position:relative">${cat.name }</span> 
				</a> 
				<c:if test="${cat.existsChildren == true}">
					<ul class="subnavbar">
						<c:forEach items="${cat.children }" var="child" varStatus="status">
							<li class="nav">
									<a  class="a" href="${path }/c/${child.uri}"> 
										<span>${child.name }</span> 
									</a> 
							</li>
						</c:forEach>
					</ul>
				</c:if>
			</li>
		</c:forEach>
	</ul>
	</div>
</div>
</c:if>
<div style="clear:both"></div>
