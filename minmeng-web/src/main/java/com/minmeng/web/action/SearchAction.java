package com.minmeng.web.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import com.j2mvc.framework.i18n.I18n;
import com.j2mvc.framework.mapping.ActionPath;
import com.j2mvc.framework.mapping.ActionUri;
import com.j2mvc.searcher.SearchResult;
import com.j2mvc.searcher.Searcher;
import com.j2mvc.util.Pagination;
import com.j2mvc.util.StringUtils;

/**
 * @Description 搜索
 * @Company 贵州万嘉
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2015-1-21 创建
 */
@ActionPath(path="/")
public class SearchAction  extends BaseAction {

	/**
	 * 读列表
	 * @param p 当前页号  
	 * @param s 每页尺雨
	 * @param k 关键字
	 * @param st 开始时间
	 * @param et 结束时间
	 * @param ls 列表类型
	 */
	@ActionUri(uri="search([/])?")
	public String loadList(Integer p,Integer s,String k){
		String keyword = k!=null?k:"";
		try {
			keyword = URLDecoder.decode(k,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
//		Page page = pageService.getByPageType(Page.PAGE_TYPE_LIST);
//		if(page != null){
//			// 页面信息
//			put("page",page);
//			// 所有自定义行
//			rows(page);
//		}
		// 列表页
		p = p!=null && p > 0?p:1;
		if(s == null){
			String psStr = I18n.i18n.get("FRONT_PAGESIZE");
			s = psStr.matches("\\d+")?Integer.valueOf(psStr):20;
		}
		Searcher searcher = new Searcher(indexDir);
		SearchResult result = searcher.query(keyword, s, p,"p",160);
		Pagination pagination = result.getPagination();
		// 输出
		put("result",result);
		put("items",searcher.getItems());
		put("k", keyword);
		put("s", s);
		put("pagination", pagination);
		String url = request.getRequestURI()+"?"
					+ (!StringUtils.isEmpty(k)?"k="+k:"")
					+ (s!=null?"&s="+s:"");
		if(pagination!=null)
		put("paginationHtml", pagination.getBootstrapHtml(url, 12, true));
		put("url",url);
		put("title","搜索“" + keyword + "” - 第"+p+"页 － " + SITENAME );
		return jsp("search.jsp");
	}

}
