package com.minmeng.manager.action.ui;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.DataValidations;
import org.fixwork.util.Error;
import org.fixwork.util.Pagination;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;
import org.fixwork.util.Utils;

import com.minmeng.entity.ui.View;

/**
 * @Description 控件
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2018-12-26 
 */
@ActionPath(path="/ui/view/",dir="/WEB-INF/jsp/ui/view/")
public class ViewAction extends UIAction{
	static final Logger log = Logger.getLogger(ViewAction.class);
	
	
	@ActionUri(uri="([/])?")
	public String index(){
		return "index.jsp";
	}

	@ActionUri(uri="getList([/])?")
	public void getList(Integer pageNumber,Integer pageSize){
		pageNumber = pageNumber!=null?pageNumber:1;
		String psStr = I18n.i18n.get("DEFAULT_PAGESIZE");
		pageSize =  pageSize!=null?pageSize:psStr.matches("\\d+")?Integer.valueOf(psStr):20;
		
		// 查询出总数
		Integer total = viewService.total();
		// 创建分页对象
		Pagination pagination  = new Pagination(total,pageSize, pageNumber);
		// 查询分页数据
		Integer start = pagination.getStartIndex();
		List<View> list = viewService.query( start, pageSize);
		
		Map<String,Object> m = new HashMap<String,Object>();
		
		m.put("total", pagination.getTotal());
		m.put("rows", list);
		printJson(m);
	}

	@ActionUri(uri="query([/])?",description="UI设置－查询编辑控件")
	public void query(){
		List<View> list = viewService.queryTop("1");
		printJson(list);
	}
	
	@ActionUri(uri="edit([/])?",description="UI设置－编辑控件")
	public String edit(View view){
		put("id", view.getId()!=null 
				&& !StringUtils.isEmpty(view.getId())?view.getId():
					Utils.createId());
		put("view", view);
		return "edit.jsp";
	}
	@ActionUri(uri="get([/])?",description="UI设置－获取控件")
	public void get(String id){
		View view = viewService.get(id);
		if(view!=null){
			printJson(view);
		}else{
			printJson(new Error("未找到控件"));
		}
	}

	@ActionUri(uri="save([/])?",description="UI设置－保存控件")
	public void save(View view,String mode,String style){
		if(StringUtils.isEmpty(mode)){
			printJson(new Error( "未指定控件类型."));
			return;
		}
		if(StringUtils.isEmpty(style)){
			printJson(new Error( "未指定控件样式."));
			return;
		}
		if(checkName(view.getId(),view.getName())){
			List<Error> errors = DataValidations.dataTooLong(view);
			if(errors!=null && errors.size()>0){
				printJson(new Error( "数据长度超过限制.",errors));
				return;
			}
			if(viewService.save(view)!=null){
				printJson(new Success( "保存完成"));
				sqlDump("保存控件："+view.getName()+".");
			}else {
				printJson(new Error( "保存失败."));
			}
		}
	}
	@ActionUri(uri="checkName([/])?",description="UI设置－检查控件识别名称")
	public boolean checkName(String id,String name) {
		if(StringUtils.isEmpty(name)){
			printJson(new Error("控件名称不能为空"));
			return false;
		}else if(viewService.exists(id,name)){
			printJson(new Error("控件名称已存在！"));
			return false;
		}else {
			printJson(new Success("控件名称可用"));
			return true;
		}
	}
	@ActionUri(uri="checkStyle([/])?",description="UI设置－检查控件样式")
	public boolean checkStye(String id,String style) {
		if(StringUtils.isEmpty(style)){
			printJson(new Error("控件样式不能为空"));
			return false;
		}else {
			printJson(new Success("控件名称可用"));
			return true;
		}
	}


	@ActionUri(uri="del([/])?",description="UI设置－删除控件")
	public void del(String ids) {
		if(viewService.delete(ids.split(","))>0){
			printJson(new Success( "删除完成."));
			sqlDump("删除控件："+ids+".");
		}else {
			printJson(new Error( "删除失败."));
		}
	}
	

	@ActionUri(uri="parents([/])?")
	public void parents(String id){
		View view = viewService.get(id);
		String str = getParents("",view,0);
		print(!str.equals("")?str:"未设置");
	}
	/**
	 * 输出所有父级控件
	 * @param str
	 * @param cat
	 * @param i
	 * @return
	 */
	public String getParents(String str,View view,int i){
		// 获取上级控件
		if(view!=null){
			Integer childrenSize = viewService.totalChidren(view.getId());
			
			str = (childrenSize>0?
					"<a onclick='opdb("+view.getId()+")'>"
					+ view.getName() 
					+ "</a>"
					:view.getName())
				  + (i>0?" &raquo; ":"") + str;
			i ++;
			View parent = viewService.get(view.getParentId());
			if(parent !=null){
				str = getParents(str,parent,i);
			}else{
			}
		}
		return str;
	}

	/**
	 * 控件树
	 */
	@ActionUri(uri="tree([/])?")
	public String tree(String id){
		put("id",id);
		return "tree.jsp";
	}
}
