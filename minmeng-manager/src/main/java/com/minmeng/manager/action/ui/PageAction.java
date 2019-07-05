package com.minmeng.manager.action.ui;

import java.util.List;

import org.apache.log4j.Logger;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.DataValidations;
import org.fixwork.util.Error;
import org.fixwork.util.Pagination;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;

import com.minmeng.entity.ui.Page;

/**
 * @Description 管理员中心>页面
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-23
 */
@ActionPath(path="/ui/page/",dir="/WEB-INF/jsp/ui/page/",description="UI设置－页面设置",auth=true)
public class PageAction extends UIAction{
	static final Logger log = Logger.getLogger(PageAction.class);
	
	@ActionUri(uri="([/])?",description="UI设置－页面设置")
	public String index(Integer page,Integer pageSize){
		page = page!=null?page:1;
		String psStr = I18n.i18n.get("DEFAULT_PAGESIZE");
		pageSize =  pageSize!=null?pageSize:psStr.matches("\\d+")?Integer.valueOf(psStr):20;
		
		// 查询出总数
		Integer total = pageService.total();
		// 创建分页对象
		Pagination pagination  = new Pagination(total,pageSize, page);
		// 查询分页数据
		Integer start = pagination.getStartIndex();
		List<Page> list = pageService.query( start, pageSize);
		// 输出
		put("list", list);
		put("pageSize", pageSize);
		put("nodata", !(list != null && list.size() > 0) ? "未找到数据。" : "");
		put("pagination", pagination);
		put("paginationHtml", pagination.getHtml(request.getRequestURI(), 20));
		return "index.jsp";
	}

	@ActionUri(uri="edit([/])?",description="UI设置－编辑页面")
	public String edit(Page page){
		put("page", page);
		return "edit.jsp";
	}

	@ActionUri(uri="save([/])?",description="UI设置－保存页面")
	public void save(Page page){
		List<Error> errors = DataValidations.dataTooLong(page);
		if(errors!=null && errors.size()>0){
			printJson(new Error( "数据长度超过限制.",errors));
			return;
		}
		if(pageService.save(page)!=null){
			printJson(new Success( "保存完成"));
			sqlDump("保存页面："+page.getName()+".");
		}else {
			printJson(new Error( "保存失败."));
		}
	}


	@ActionUri(uri="del([/])?",description="UI设置－删除页面")
	public void del(String ids) {
		if(pageService.delete(ids.split(","))>0){
			printJson(new Success( "删除完成."));
			sqlDump("删除页面："+ids+".");
		}else {
			printJson(new Error( "删除失败."));
		}
	}
}
