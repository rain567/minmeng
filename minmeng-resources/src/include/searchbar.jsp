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
<%--<div id="searchbar">
	 <div class="main" style="position:relative;height:30px;padding:5px">
		<div class="left">
			<div style="padding-top:2px;">今日天气：</div>
		</div>
		<div class="left">
		<%// 天气预报 %>
		<!-- <iframe id="weatherFrame" scrolling="no" src="https://tianqiapi.com/api.php?style=ta&skin=pitaya" frameborder="0" width="260" height="24" allowtransparency="true"></iframe>  -->
		<div class="weather">${weather }</div>
		</div>
	</div>
	<div class="main"  style="position:relative;padding:5px 5px 10px 5px">
			<form id="searchform" action="${path }/search">	
				<input type="text" name="k" class="keyword" value="${k }">
				<Button type="submit">搜索</Button>
			</form>
		</div> 
</div>--%>