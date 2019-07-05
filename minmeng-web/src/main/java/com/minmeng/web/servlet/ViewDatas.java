package com.minmeng.web.servlet;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.minmeng.entity.cms.ContentInfo;
import com.minmeng.entity.common.Cat;
import com.minmeng.entity.ui.View;
import com.minmeng.entity.ui.ViewItem;
import com.minmeng.service.cms.ContentInfoService;
import com.minmeng.service.ui.ViewItemService;

public class ViewDatas {
	HttpServletRequest request;
	HttpServletResponse response;
	View view;
	
	ViewItemService viService = new ViewItemService();
	ContentInfoService contentService = new ContentInfoService();
	
	public ViewDatas(HttpServletRequest request, HttpServletResponse response,View view) {
		super();
		this.request = request;
		this.response = response;
		this.view = view;
	}
	/**
	 * 获取容器控件内容
	 * @param view
	 */
	public void containerViewDetail(){
		put("view",view);
	}
	/**
	 * 获取分类控件内容
	 * @param view
	 */
	public void catViewDetail(){
		Integer max = view.getMaxItems();
		List<ViewItem> items = viService.query(view.getId());
		Map<Cat,List<ContentInfo>> data = new LinkedHashMap<Cat,List<ContentInfo>>();
		for(int i=0;i<items.size();i++){
			ViewItem item = items.get(i);
			Cat cat = item.getCat();
			if(cat!=null){
				List<ContentInfo> list = contentService.query(cat.getId(), "", max);
				data.put(cat, list);
			}
		}
		put("view",view);
		put("data",data);
	}

	/**
	 * 获取自定义内容控件内容
	 * @param view
	 */
	public void contentViewDetail(){
		Integer max = view.getMaxItems();
		List<ViewItem> items = viService.query(view.getId(), max);
		put("view",view);
		put("items",items);
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
