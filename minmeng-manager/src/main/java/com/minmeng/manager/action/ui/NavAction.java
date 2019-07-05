package com.minmeng.manager.action.ui;

import java.util.List;

import org.apache.log4j.Logger;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.DataValidations;
import org.fixwork.util.Error;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;
import org.fixwork.util.Utils;

import com.minmeng.entity.common.Cat;
import com.minmeng.entity.ui.Nav;
import com.minmeng.service.common.CatService;
import com.minmeng.service.ui.NavService;

/**
 * @Description 导航设置
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-25
 */
@ActionPath(path="/ui/nav/",dir="/WEB-INF/jsp/ui/nav/",description="UI设置－导航设置",auth=true)
public class NavAction extends UIAction{
	static final Logger log = Logger.getLogger(NavAction.class);
	
	NavService navService = new NavService();
	CatService catService = new CatService();

	@ActionUri(uri="([/])?",description="UI设置－导航设置")
	public String list(String status){
		List<Nav> list = navService.query( status);
		// 输出
		put("list", list);
		put("status", status);
		put("nodata", !(list != null && list.size() > 0) ? "未找到数据。" : "");
		return "index.jsp";
	}


	@ActionUri(uri="edit([/])?",description="UI设置－编辑导航设置")
	public String edit(Nav nav){
		put("id", nav.getId()!=null 
				&& !StringUtils.isEmpty(nav.getId())?nav.getId():
					Utils.createId());
		Cat cat = nav.getCat();
		put("cat", cat);
		put("nav", nav);
		return "edit.jsp";
	}

	@ActionUri(uri="save([/])?",description="UI设置－保存导航")
	public void save(Nav nav,String catId){
		if(nav.getNavType().equals(Nav.NAV_TYPE_CAT)){
			Cat cat = catService.get(catId);
			if(cat == null){
				printJson(new Error( "未设置栏目或未栏目不存在."));
				return;
			}
			nav.setCat(cat);
			nav.setName(cat.getName());
			nav.setAlias(cat.getAlias());
			nav.setLink("/c/"+cat.getUri());
		}else{
			nav.setCat(null);
		}
		List<Error> errors = DataValidations.dataTooLong(nav);
		if(errors!=null && errors.size()>0){
			printJson(new Error( "数据长度超过限制.",errors));
			return;
		}
		if(checkName(nav.getId(),nav.getName()))
		if(navService.save(nav)!=null){
			printJson(new Success( "保存完成"));
			sqlDump("保存导航："+nav.getName()+".");
		}else {
			printJson(new Error( "保存失败."));
		}
	}
	
	@ActionUri(uri="checkName([/])?",description="UI设置－检查导航名称")
	public boolean checkName(String id,String name) {
		if(id == null || "".equals(id)){
			printJson(new Error("ID未设置，导航名称不能为空。"));
			return false;
		}else if(name == null || "".equals(name)){
			printJson(new Error("导航名称不能为空。"));
			return false;
		}else if(navService.existsName(name,id)){
			printJson(new Error("导航名称已存在！"));
			return false;
		}else {
			printJson(new Success("导航名称可用"));
			return true;
		}
	}


	@ActionUri(uri="del([/])?",description="UI设置－删除导航条目")
	public void del(String ids) {
		if(navService.delete(ids.split(","))>0){
			printJson(new Success( "删除完成."));
			sqlDump("删除导航："+ids+".");
		}else {
			printJson(new Error( "删除失败."));
		}
	}
	
	@ActionUri(uri="setStatus([/])?",description="UI设置－设置导航启用状态")
	public void setStatus(String id,String status) {
		if(status == null || "".equals(status)){
			printJson(new Error("未设置状态"));
		}else if(navService.setStatus(id, status)>0){
			printJson(new Success( "设置完成."));
			if(status.equalsIgnoreCase("Y"))
				sqlDump("启用导航"+navService.get(id)+".");
			else{
				sqlDump("停用导航"+navService.get(id)+".");
			}
		}else {
			printJson(new Error( "设置失败."));
		}
	}
}
