package com.minmeng.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.minmeng.web.util.JspUtil;

/**
 * Servlet implementation class TestServlet
 */
public  abstract class BaseServlet extends HttpServlet {
	private static final long serialVersionUID = -5663861512895366457L;
	HttpServletRequest request;
	HttpServletResponse response;
	JspUtil jspUtil;

	public void init() throws ServletException {
		super.init();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.request = request;
		this.response = response;
		jspUtil = new JspUtil(request,response);
		super.doGet(request, response);

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.request = request;
		this.response = response;
		jspUtil = new JspUtil(request,response);
		super.doPost(request, response);
	}
	public String jsp(String jsp){
		return jspUtil.jsp(jsp);
	}

	/**
	 * 设置页面参数
	 * 
	 * @param name
	 * @param value
	 */
	protected void put(String name, Object value) {
		request.setAttribute(name, value);
	}
}
