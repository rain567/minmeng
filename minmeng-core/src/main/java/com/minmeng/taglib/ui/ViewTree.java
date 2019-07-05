package com.minmeng.taglib.ui;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.minmeng.entity.ui.View;
import com.minmeng.service.ui.ViewService;

/**
 * 控件树
 * @author 贵州万嘉：杨大江
 * @version 1.1
 */
public class ViewTree extends SimpleTagSupport {

	String filterId = ""; 
	ViewService service = new ViewService();
	
	/**读取叶子类树*/ 
	private String walk(String returnStr,String parentId,String filterId){
		// 根据传来的参数查询叶控件 
		List<View> ics = null;
		if(parentId !=null && !parentId.equals("")){
			ics = service.queryChidrenUnionFilter(parentId, filterId);
		}else{
			ics = service.queryTopUnionFilter(filterId);
		}
		int size = ics!=null ?ics.size():0;
		for(int i=0;i<size;i++){ 
			View c = ics.get(i);
			// 输出HTML标签
			returnStr = returnStr + "<li>";
			returnStr = returnStr + "<div style='white-space:nowrap'>"
							 	  + "<span style='padding:0'>"
								  + "<a id="+c.getId()+" class='name'>"
								  +	c.getName()
					  		      + "</a>"
					 			  + "</span>"	
								  + "</div>";

			Integer childrenTotal = service.totalChidrenUnionFilter(c.getId(),filterId);
			if(childrenTotal>0){
				//有子控件，则递归
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
				  +	"顶级控件"
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

}
