package com.minmeng.manager.interceptor;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.framework.interceptor.MeasureInterceptor;
import org.fixwork.util.CookieUtil;
import org.fixwork.util.StringUtils;

import com.minmeng.entity.common.Admin;
import com.minmeng.service.common.AdminService;

/**
 * 
 * 管理员拦截器
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-17
 */
public class AdminInterceptor extends MeasureInterceptor{	
	  
	Logger log = Logger.getLogger(AdminInterceptor.class.getCanonicalName());

	String sessionParam = I18n.i18n.get("SESSION_ADMIN");
	String sessionidParamName = I18n.i18n.get("SESSION_ADMIN_SESSIONID");
	AdminService adminService = new AdminService();

	/**
	 * 不设置权限的uri
	 * @param uri
	 * @return
	 */
	private boolean isFilterAuth(String uri){
		List<String> filters = new ArrayList<String>();
		filters.add("login");
		filters.add("show-identify-code");
		filters.add("identify-code");
		filters.add("forget");
		filters.add("uploadJson");// 待修改
		filters.add("receive");//报送接受
		uri = StringUtils.deleRepeat(uri, "/");
		uri = uri.endsWith("/")?uri.substring(0,uri.lastIndexOf("/")):uri;
		int start = uri.indexOf("/");
		if(start!=-1)
			uri = uri.substring(uri.lastIndexOf("/") + 1,uri.length());
		return filters.contains(uri);
	}
	/**
	 * 不通过session
	 * @param uri
	 * @return
	 */
	private boolean isFilter(String uri){
		List<String> filters = new ArrayList<String>();
		filters.add("uploadJson");
		filters.add("fileManagerJson");
		filters.add("upload");
		filters.add("uploadFile");
		filters.add("progress");
		filters.add("exticon");
		filters.add("receive");//报送接受
		uri = StringUtils.deleRepeat(uri, "/");
		uri = uri.endsWith("/")?uri.substring(0,uri.lastIndexOf("/")):uri;
		int start = uri.indexOf("/");
		if(start!=-1)
			uri = uri.substring(uri.lastIndexOf("/") + 1,uri.length());
		return filters.contains(uri);
	}

	@Override
	public boolean execute(HttpServletRequest request,HttpServletResponse response) {
		String uri = request.getRequestURI();
		HttpSession session = request.getSession();
		Admin sessionAdmin = (Admin) session.getAttribute(sessionParam);
		String sessionid = (String) session.getAttribute(sessionidParamName);	
		if(isFilterAuth(uri) || sessionAdmin!=null){
			session.setAttribute(sessionidParamName, sessionid);	
			session.setAttribute(sessionParam, sessionAdmin);
			return true;
		}
		if(sessionAdmin == null){
			// 如果会话用户为空，从cookie中获取sessionid
			sessionid = sessionid !=null?sessionid: CookieUtil.getCookieValue(request, sessionidParamName);
			sessionid = sessionid !=null?sessionid:isFilter(uri)?request.getParameter(sessionidParamName):"";

			if(!StringUtils.isEmpty(sessionid)){
				sessionAdmin = adminService.getBySessionid(sessionid);
			} 
		}
		if(sessionAdmin !=null){
			session.setAttribute(sessionidParamName, sessionid);	
			session.setAttribute(sessionParam, sessionAdmin);	
			return true;
		}
		session.removeAttribute(sessionidParamName);
		session.removeAttribute(sessionParam);
		return false;
	}
 
	@Override
	public void error(HttpServletRequest request,HttpServletResponse response){
		// 在此实现除登陆权限以外的其他操作
		log.error(request.getRequestURL()+" >> 无权限");
		try {
			response.sendRedirect(request.getContextPath()+"/login");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void success(HttpServletRequest arg0, HttpServletResponse arg1) {
		
	}
}