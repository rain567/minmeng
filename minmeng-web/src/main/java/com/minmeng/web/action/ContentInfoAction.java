package com.minmeng.web.action;

import java.io.IOException;

import org.fixwork.framework.action.RequestUri;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;

/**
 * @Description 内容列表
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-21 创建
 * @Date 2014-12-26 变更
 */
@ActionPath(path="/c/")
public class ContentInfoAction  extends ContentAction {

	
	@ActionUri(uri="[a-z\\-\\d]+/[a-z\\-\\d]+([/])?")
	public String info(RequestUri uri, Integer p){
		String catId = uri.getValues()[1];
		String id = uri.getValues()[2];
		cat = catService.getByUri(catId);
//		Page page = pageService.getByPageType(Page.PAGE_TYPE_CONTENT);
		if(cat!=null){
			// 页面信息
//			put("page",page);
//			// 所有自定义行
//			rows(page);
			// 加载内容
			loadInfo(id,null,p);
			return jsp("content/info.jsp");
		}else{
			try {
				response.sendRedirect(path+"/404");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return jsp("content/index.jsp");
	}
}
