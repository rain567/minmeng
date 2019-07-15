package com.minmeng.web.action;

import java.util.List;

import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.*;
import com.minmeng.entity.ui.Page;

import com.minmeng.entity.ui.Page;
import com.minmeng.entity.ui.PageView;

/**
 * @Description 首页
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-21 创建
 * @Date 2014-12-26 变更
 */
@ActionPath(path="/")
public class IndexAction  extends BaseAction {
	Page page;
	
	
	@ActionUri(uri="([/])?")
	public String index(){
		
		page = pageService.getByName(Page.NAME_INDEX);
		if(page != null){
			// 页面信息
			String title = page.getTitle();
			title = !StringUtils.isEmpty(title)?title.trim():page.getName();
			put("page",page);
			put("title",title);
			// 排版
			pageViews();
		}
		return jsp("index.jsp");
	}
	
	private void pageViews(){
		List<PageView> pageViews = pageViewService.query(page.getName());
		put("pageViews",pageViews);
	}

}
