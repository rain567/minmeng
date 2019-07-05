<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.fixwork.web.upload.Upload" %>
<%
// 上传
Upload upload = new Upload(request,response);
upload.execute();
%>