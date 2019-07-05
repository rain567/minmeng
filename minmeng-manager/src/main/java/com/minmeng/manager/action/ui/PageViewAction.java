package com.minmeng.manager.action.ui;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.Error;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;

import com.minmeng.entity.ui.Page;
import com.minmeng.entity.ui.PageView;
import com.minmeng.entity.ui.View;

/**
 * @Description 页面控件
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2018-12-26 
 */
@ActionPath(path="/ui/page-view/",dir="/WEB-INF/jsp/ui/page-view/")
public class PageViewAction extends UIAction{
	static final Logger log = Logger.getLogger(PageViewAction.class);
	
	
	@ActionUri(uri="([/])?")
	public String index(){
		return "index.jsp";
	}

	@ActionUri(uri="getList([/])?")
	public void getList(String pageName){
		List<PageView> list = pageViewService.query(pageName);
		Map<String,Object> m = new HashMap<String,Object>();
		m.put("rows", list);
		printJson(m);
	}


	@ActionUri(uri="save([/])?",description="UI设置－保存页面控件")
	public void save(String viewId,String pageName,String status,Integer sorter,String id){
		Page page = pageService.getByName(pageName);
		if(page == null){
			printJson(new Error( "未指定页面."));
			return;
		}
		View view = viewService.get(viewId);
		if(view == null){
			printJson(new Error( "未指定控件."));
			return;
		}
		if(StringUtils.isEmpty(id)){
			printJson(new Error( "未设置ID."));
			return;
		}
		if(StringUtils.isEmpty(status)){
			printJson(new Error( "未设置状态."));
			return;
		}
		if(!status.matches("\\d+")){
			printJson(new Error( "未设置状态."));
			return;
		}
		PageView pageView = pageViewService.get(id);
		if(pageView == null){
			pageView = new PageView();
		}
		pageView.setId(id);
		pageView.setPageId(page.getId());
		pageView.setView(view);
		pageView.setSorter(sorter);
		pageView.setStatus(status);

		if(pageViewService.save(pageView)!=null){
			Map<String,PageView> map = new HashMap<String,PageView>();
			map.put("row", pageView);
			printJson(map);
			sqlDump("保存页面控件："+view.getName()+".");
		}else {
			printJson(new Error( "保存失败."));
		}
	}



	@ActionUri(uri="del([/])?",description="UI设置－删除页面控件")
	public void del(String ids) {
		if(pageViewService.delete(ids.split(","))>0){
			printJson(new Success( "删除完成."));
			sqlDump("删除页面控件："+ids+".");
		}else {
			printJson(new Error( "删除失败."));
		}
	}
}
