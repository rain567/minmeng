package com.minmeng.manager.action.ui;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.Error;
import org.fixwork.util.Pagination;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;
import org.fixwork.util.Utils;

import com.minmeng.entity.common.Cat;
import com.minmeng.entity.ui.View;
import com.minmeng.entity.ui.ViewItem;

/**
 * @Description 控件条目
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2018-12-26 
 */
@ActionPath(path="/ui/view-item/",dir="/WEB-INF/jsp/ui/view-item/")
public class ViewItemAction extends UIAction{
	static final Logger log = Logger.getLogger(ViewItemAction.class);
	
	
	@ActionUri(uri="([/])?")
	public String index(String viewId){
		View view = viewService.get(viewId);
		if(view == null){
			put("error","未选择控件！");
			return "error.jsp";
		}
		put("view",view);
		return "index.jsp";
	}

	@ActionUri(uri="getList([/])?")
	public void getList(String viewId,Integer pageNumber,Integer pageSize){
		pageNumber = pageNumber!=null?pageNumber:1;
		String psStr = I18n.i18n.get("DEFAULT_PAGESIZE");
		pageSize =  pageSize!=null?pageSize:psStr.matches("\\d+")?Integer.valueOf(psStr):20;
		
		// 查询出总数
		Integer total = viewItemService.total(viewId);
		// 创建分页对象
		Pagination pagination  = new Pagination(total,pageSize, pageNumber);
		// 查询分页数据
		Integer start = pagination.getStartIndex();
		List<ViewItem> list = viewItemService.query(viewId, start, pageSize);
		
		Map<String,Object> m = new HashMap<String,Object>();
		
		m.put("total", pagination.getTotal());
		m.put("rows", list);
		printJson(m);
	}

	@ActionUri(uri="edit([/])?",description="UI设置－编辑控件条目")
	public String edit(String id,String viewId){
		id = !StringUtils.isEmpty(id)?id:"";
		viewId = !StringUtils.isEmpty(viewId)?viewId:"";
		ViewItem viewItem = viewItemService.get(id);
		View view = null;
		if(viewItem != null){
			view = viewItem.getView();
		}else{
			view = viewService.get(viewId);
			viewItem = new ViewItem();
			viewItem.setId(Utils.createId());
		}
		if(view == null){
			put("error","未指定控件");
			return "/WEB-INF/jsp/error.jsp";
		}
		put("viewItem", viewItem);
		put("view", view);
		return "edit.jsp";
	}

	@ActionUri(uri="content([/])?",description="UI设置－查看控件条目")
	public String content(String id){
		id = !StringUtils.isEmpty(id)?id:"";
		ViewItem viewItem = viewItemService.get(id);
		put("viewItem", viewItem);
		return "content.jsp";
	}
	

	@ActionUri(uri="save([/])?",description="UI设置－保存控件条目")
	public void save(ViewItem viewItem,String catId,String viewId,String image){
		View view = viewService.get(viewId);
		if(view == null){
			printJson(new Error( "未指定控件."));
			return;
		}
		viewItem.setView(view);
		if("1".equals(view.getMode())){
			Cat cat = catService.get(catId);
			if(cat == null){
				printJson(new Error( "未指定分类."));
				return;
			}
			viewItem.setCat(cat);
			if(viewItemService.save(viewItem)!=null){
				printJson(new Success( "保存完成"));
				sqlDump("保存控件条目："+view.getName()+".");
			}else {
				printJson(new Error( "保存失败."));
			}
		}else if("2".equals(view.getMode())){
			if(StringUtils.isEmpty(image)
					&& StringUtils.isEmpty(viewItem.getContent())){
				printJson(new Error( "请编辑条目内容或上传图片."));
				return;
			}
			if(viewItemService.save(viewItem)!=null){
				printJson(new Success( "保存完成"));
				sqlDump("保存控件条目："+view.getName()+".");
			}else {
				printJson(new Error( "保存失败."));
			}
		}else{
			printJson(new Error( "无类型编辑."));
		}
	}



	@ActionUri(uri="del([/])?",description="UI设置－删除控件条目")
	public void del(String ids) {
		if(viewItemService.delete(ids.split(","))>0){
			printJson(new Success( "删除完成."));
			sqlDump("删除控件条目："+ids+".");
		}else {
			printJson(new Error( "删除失败."));
		}
	}
}
