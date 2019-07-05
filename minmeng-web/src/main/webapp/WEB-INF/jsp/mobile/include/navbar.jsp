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
 
    <div class="navbar navbar-fixed-top navbar-default" >  
      <div class="container">
        <div class="navbar-header">  
        	<a class="navbar-brand" href="${path }/">
        		<img class="img-responsive" src="${SITE_RESOURCE_PREFIX }/css/mobile/images/logo.png" alt="${SITENAME }" style="height: 95%;width: auto;" />
        	</a>
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navBar">  
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>  
        <div class="collapse navbar-collapse navbar-right" id="navBar">  
          <ul class="nav navbar-nav">
	            
			<c:forEach items="${navs }" var="nav" varStatus="status">
				<li class="<c:if test="${nav.name == 'home' }">active</c:if> <c:if test="${nav.subDepth > 0 }">dropdown</c:if>">
					
					<c:if test="${nav.subDepth < 1 }">
					<a  class="a" href="<c:if test="${fn:startsWith(nav.link, 'http://')}">${nav.link }</c:if><c:if test="${!fn:startsWith(nav.link, 'http://')}">${path}<c:if test="${!fn:startsWith(nav.link, '/')}">/</c:if>${nav.link }</c:if>"> 
						<span style="position:relative">${nav.name }</span> 
					</a> 
					</c:if>
					<c:if test="${nav.subDepth > 0 }">
						<a  href="<c:if test="${fn:startsWith(nav.link, 'http://')}">${nav.link }</c:if><c:if test="${!fn:startsWith(nav.link, 'http://')}">${path}<c:if test="${!fn:startsWith(nav.link, '/')}">/</c:if>${nav.link }</c:if>"
							 class="dropdown-toggle" 
							 data-toggle="dropdown" 
							 role="button" 
							 aria-haspopup="true" 
							 aria-expanded="false">${nav.name } <span class="caret"></span></a>
					</c:if>
					<c:if test="${nav.subDepth > 0 }">
					<ul class="dropdown-menu">
						<t:subNavs catId="${nav.cat.id }" subDepth="${nav.subDepth }" urlPrefix="${path }"></t:subNavs>
					</ul>
					</c:if>
				</li>
			</c:forEach>
          </ul>  
        </div>
      </div>
    </div>  
    