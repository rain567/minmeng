package com.minmeng.web.action;

import java.io.IOException;

import org.fixwork.framework.action.RequestUri;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import com.minmeng.entity.ui.Page;

/**
 * @Description 内容列表
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-21 创建
 * @Date 2014-12-26 变更
 */
@ActionPath(path="/c/")
public class ContentListAction  extends ContentAction {

	/**
	 * 
	 * @param uri 
	 * @param p 当前页号
	 * @param s 每页尺雨
	 * @param k 关键字
	 * @param st 开始时间
	 * @param et 结束时间
	 * @param ls 列表类型
	 * @return
	 */
	@ActionUri(uri="[a-z\\-\\d]+([/])?")
	public String list(RequestUri uri,Integer p,Integer s,String k,String st,String et,String ls){
		cat = catService.getByUri(uri.getValues()[1]);
		Page page = pageService.getByName(Page.NAME_LIST);
		if(cat!=null){
//			String title = page.getTitle();
//			title = title!=null && !title.trim().equals("")?title.trim():page.getName();
//			title = title!=null && !title.trim().equals("")?title:cat.getName();
			put("page",page);
			if(cat.getCatType().equals(CAT_TYPE_LIST)){
				loadList(p, s, k, st, et, ls);
				return jsp("content/list.jsp");
			}else if(cat.getCatType().equals(CAT_TYPE_SINGLE)){
				loadInfo(null,cat.getId(),p);
				return jsp("content/single.jsp");
			}else{
				return jsp("content/index.jsp");
			}
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
