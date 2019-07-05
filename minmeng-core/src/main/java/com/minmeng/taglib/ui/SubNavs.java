package com.minmeng.taglib.ui;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.minmeng.entity.common.Cat;
import com.minmeng.service.common.CatService;

/**
 * 子导航
 * @author 贵州万嘉：杨大江
 * @version 1.1
 */
public class SubNavs extends SimpleTagSupport {

	Integer subDepth; // 深度
	String catId;  // 分类Id
	CatService catService = new CatService();
	String urlPrefix;
	
	/**读取叶子类树*/ 
	private String walk(String returnStr,String parentId,int depth){
		// 根据传来的参数查询叶分类
		List<Cat> ics = null;
		ics = catService.queryChidren(parentId);
		int size = ics!=null ?ics.size():0;
		for(int i=0;i<size;i++){ 
			Cat cat = ics.get(i);
			String href = getHref(cat);
			// 输出HTML标签
			returnStr = returnStr + "<li>";
			returnStr = returnStr + "<a href=\""+href+"\">"
							 	  + "<span>"
								  +	cat.getName()
					 			  + "</span>"	
					  		      + "</a>";

			Integer childrenTotal = catService.totalChildren(cat.getId());
			if(childrenTotal>0 && depth < subDepth){
				//有子分类，则递归
				returnStr = returnStr + "<ul class=\"moresubnavbar\">";
				returnStr = returnStr + walk("",cat.getId(),depth+1);
				returnStr = returnStr + "</ul>";
			}
			returnStr = returnStr + "</li>";
		}
		return returnStr;
	}
	
	private String getHref(Cat cat){
		String catHref = cat.getUri();
		urlPrefix = urlPrefix!=null?urlPrefix:"";
		catHref = urlPrefix + "/c/"+catHref;
		return catHref;
	}
	
	public void doTag() throws JspException, IOException {
		String out = "";
		if(subDepth>0){
			out =  walk("",catId,1) ;
		}
		// 输出处理结果到页面上
		getJspContext().getOut().println(out);
	}

	public Integer getSubDepth() {
		return subDepth;
	}

	public void setSubDepth(Integer subDepth) {
		this.subDepth = subDepth;
	}

	public String getCatId() {
		return catId;
	}

	public void setCatId(String catId) {
		this.catId = catId;
	}

	public String getUrlPrefix() {
		return urlPrefix;
	}

	public void setUrlPrefix(String urlPrefix) {
		this.urlPrefix = urlPrefix;
	}
}
