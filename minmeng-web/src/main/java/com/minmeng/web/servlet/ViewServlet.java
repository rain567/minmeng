package com.minmeng.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.minmeng.entity.ui.PageView;
import com.minmeng.entity.ui.View;
import com.minmeng.service.cms.ContentInfoService;
import com.minmeng.service.ui.PageViewService;
import com.minmeng.service.ui.ViewService;

/**
 * 控件
 */
public class ViewServlet extends BaseServlet {

	private static final long serialVersionUID = 1572818626329906577L;
	Logger log = Logger.getLogger(ViewServlet.class);
	PageViewService pageViewService = new PageViewService();
	ViewService viewService = new ViewService();
	ContentInfoService contentService = new ContentInfoService();
	PageView pageView;
	ViewDatas datas;
	View view;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doGet(request, response);
		String id = request.getParameter("id");
		view = viewService.get(id);
		if(view == null){
			return;
		}
		datas = new ViewDatas(request,response,view);
		
		String jsp = null;
		String mode = view.getMode();// 类型
		
		if (View.MODE_CONTAINER.equals(mode)) {
			// 容器
			jsp = jsp("view/containerview.jsp");
			datas.containerViewDetail();
		}else if(View.MODE_CAT.equals(mode)) {
			// 栏目
			jsp = jsp("view/catview.jsp");
			// 数据
			datas.catViewDetail();
		}else if(View.MODE_CONTENT.equals(mode)) {
			// 自定义内容
			jsp = jsp("view/contentview.jsp");
			// 数据
			datas.contentViewDetail();
		}else {
			return;
		}
		if (jsp != null) {
			// 获取子控件
			List<View> beforeChildren = viewService.queryChildren(view.getId(), View.OUT_MODE_BEFORE);
			List<View> afterChildren = viewService.queryChildren(view.getId(), View.OUT_MODE_AFTER);
			put("befores",beforeChildren);
			put("afters",afterChildren);
			request.getRequestDispatcher(jsp).include(request, response);
			response.getWriter().flush();
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doPost(request, response);
		doGet(request, response);
	}

	public void destroy() {
		// 什么也不做
	}

}
