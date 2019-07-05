package com.minmeng.taglib;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.j2mvc.framework.i18n.I18n;
import com.j2mvc.util.StringUtils;

import com.minmeng.entity.common.Cat;
import com.minmeng.service.common.CatService;

/**
 * 分类树
 * @author 贵州万嘉：杨大江
 * @version 1.1
 */
public class CatTree extends SimpleTagSupport {

	String filterId; 
	String type;
	CatService catService = new CatService();
	
	/**读取叶子类树*/ 
	private String walk(String returnStr,String parentId,String filterId){
		// 根据传来的参数查询叶分类 
		List<Cat> ics = null;
		filterId = filterId!=null?filterId:"";
		type = type!=null?type:"";
		if(!StringUtils.isEmpty(parentId)){
			ics = catService.queryChidrenUnionFilter(parentId, filterId);
		}else{
			ics = catService.queryTopUnionFilter(filterId,type);
		}
		int size = ics!=null ?ics.size():0;
		for(int i=0;i<size;i++){ 
			Cat c = ics.get(i);
			// 输出HTML标签
			returnStr = returnStr + "<li>";
			returnStr = returnStr + "<div style='white-space:nowrap'>"
							 	  + "<span style='padding:0'>"
								  + "<a id="+c.getId()+" class='name'>"
								  + (!StringUtils.isEmpty(c.getIcon())?"<span class='icon'><img src='"+
										  (!StringUtils.isEmpty(I18n.i18n.get("ATTACH_PREFIX"))?I18n.i18n.get("ATTACH_PREFIX")+"/":"")+
										  c.getIcon()
								  +"' width=16 height=16/></span>":"")
								  +	c.getName()
					  		      + "</a>"
					 			  + "</span>"	
								  + "<span style='padding:0;color:#777'>"
							 	  + c.getUri()
							  	  + "</span>"	
								  + "</div>";

			Integer childrenTotal = catService.totalChidrenUnionFilter(c.getId(),filterId);
			if(childrenTotal>0){
				//有子分类，则递归
				returnStr = returnStr + "<ul>";
				returnStr = returnStr + walk("",c.getId(),filterId);
				returnStr = returnStr + "</ul>";
			}
			returnStr = returnStr + "</li>";
		}
		return returnStr;
	}
	
	public void doTag() throws JspException, IOException {
		String str = "<li>"
				  + "<div style='white-space:nowrap'>"
				  + "<span style='padding:0'>"
				  + "<a class='name'>"
				  +	"顶级分类"
				  + "</a>"
				  + "</span>"	
				  + "</div>"
				  + "</li>";
		str = walk(str,null,filterId);

		String out = "<ul class='tree'>" + str + "</ul>";
		// 输出处理结果到页面上
		getJspContext().getOut().println(out);
	}


	public String getFilterId() {
		return filterId;
	}

	public void setFilterId(String filterId) {
		this.filterId = filterId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

}
