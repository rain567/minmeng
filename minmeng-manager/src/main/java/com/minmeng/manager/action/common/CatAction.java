package com.minmeng.manager.action.common;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.DataValidations;
import org.fixwork.util.Error;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;
import org.fixwork.util.Utils;

import com.minmeng.Constants;
import com.minmeng.entity.common.Cat;
import com.minmeng.service.common.CatService;
import com.minmeng.manager.action.BaseAction;

/**
 * @Description 分类管理
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-19
 */
@ActionPath(path="/cat/",dir="/WEB-INF/jsp/cat/")
public class CatAction extends BaseAction{
	static final Logger log = Logger.getLogger(CatAction.class);
	
	CatService catService = new CatService();

	@ActionUri(uri="([/])?")
	public String index(){
		return "index.jsp";
	}

	/**
	 * 获取分类列表
	 */
	@ActionUri(uri="getCats([/])?")
	public void getCats(String id,String type){
		List<Cat> list = new ArrayList<Cat>();
		if(!StringUtils.isEmpty(id)){
			// 子菜单
			list = catService.queryChidren(id);
		}else if(!StringUtils.isEmpty(type)){
			// 指定类顶级菜单
			list = catService.queryTopByType(type);
		}else{
			// 所有类型顶级菜单
			list = catService.queryTop();
		}
		if(list!=null && list.size()>0){
			printJson(list);
		}else {
			printJson(new Error(Error.ERROR_DATA, "未找到."));
		}
	}

	@ActionUri(uri="getCat([/])?")
	public void getCat(String id){
		Cat cat = catService.get(id);
		if(cat!=null){
			printJson(cat);
		}else {
			printJson(new Error("未找到."));
		}
	}

	/**
	 * 分类树
	 */
	@ActionUri(uri="tree([/])?")
	public String tree(String id,String type){
		put("id",id);
		put("type",type);
		return "tree.jsp";
	}

	@ActionUri(uri="parents([/])?")
	public void parents(String id){
		Cat cat = catService.get(id);
		String str = getParents("",cat,0);
		print(!str.equals("")?str:"未设置");
	}
	/**
	 * 输出所有父级分类
	 * @param str
	 * @param cat
	 * @param i
	 * @return
	 */
	public String getParents(String str,Cat cat,int i){
		// 获取上级分类
		if(cat!=null){
			Integer childrenSize = catService.totalChidren(cat.getId());
			
			str = (childrenSize>0?
					"<a onclick='opdb("+cat.getId()+")'>"
					+ (!StringUtils.isEmpty(cat.getIcon())?"<span class='icon'><img src='"+attachPrefix+"/"+cat.getIcon()+"' width=16 height=16/></span>":"")
					+ cat.getName() 
					+ "</a>"
					:
						(!StringUtils.isEmpty(cat.getIcon())?"<span class='icon'><img src='"+attachPrefix+"/"+cat.getIcon()+"' width=16 height=16/></span>":"") +cat.getName())
				  + (i>0?" &raquo; ":"") + str;
			i ++;
			Cat parent = catService.get(cat.getParentId());
			if(parent !=null){
				str = getParents(str,parent,i);
			}else{
			}
		}
		return str;
	}
	
	
	@ActionUri(uri="edit([/])?",description="编辑分类")
	public String edit(String id,String parentId){
		Cat cat = catService.get(id);
		id =  cat!=null?cat.getId():Utils.createId();
		if(cat !=null){
			parentId = cat.getParentId();
		}else{
			cat = new Cat();
		}
		Cat parent = catService.get(parentId);
		if(parent!=null && cat.getCatType() == null){
			cat.setCatType(parent.getCatType());;
		}
		put("parentId",parentId);
		put("id",id);
		put("cat", cat);
		put("typeDescris",Constants.typeDescris);
		put("listStypeDescris",Constants.listStypeDescris);
		return "edit.jsp";
	}

	@ActionUri(uri="save([/])?",description="编辑分类")
	public void save(Cat cat,String parentId,String catType,String listStyle){
		if(StringUtils.isEmpty(cat.getId())){
			printJson(new Error("ID不能为空！"));
			return;
		}
		if(StringUtils.isEmpty(catType)){
			printJson(new Error("分类类型不能为空！"));
			return;
		}
		listStyle = listStyle!=null?listStyle:"";
		String name = cat.getName();
		String uri = cat.getUri();
		if(checkName(cat.getId(), parentId,name)
				&& checkUri(cat.getId(),uri)){
			// 父分类
			cat.setParentId(parentId);
			cat.setListStyle(listStyle);
			
			List<Error> errors = DataValidations.dataTooLong(cat);
			
			if(errors!=null && errors.size()>0){
				printJson(new Error("数据长度超过限制.",errors));
				return;
			}
			if(catService.save(cat)!=null){
				printJson(new Success( "保存完成"));
			}else {
				printJson(new Error( "保存失败."));
			}
		}
	}
	
	@ActionUri(uri="checkName([/])?",description="检查同级分类名称")
	public boolean checkName(String id,String parentId,String name) {
		if(name == null || "".equals(name)){
			printJson(new Error("分类名称不能为空！"));
			return false;
		}else if(catService.existsName(id,parentId, name)){
			printJson(new Error("同级分类已存在！"));
			return false;
		}else {
			printJson(new Success("分类名称可用"));
			return true;
		}
	}

	@ActionUri(uri="checkUri([/])?",description="检查uri名称")
	public boolean checkUri(String id,String uri) {
		if(StringUtils.isEmpty(uri)){
			printJson(new Error("uri不能为空，由“英文小写字母”或“-”或“数字”组成。"));
			return false;
		}else if(!uri.matches("[a-z\\-\\d]+")){
			printJson(new Error("uri由“英文小写字母”或“-”或“数字”组成。"));
			return false;
		}else if(catService.existsUri(id,uri)){
			printJson(new Error("分类uri已存在！"));
			return false; 
		}else {
			printJson(new Success("分类uri可用"));
			return true;
		}
	}

	@ActionUri(uri="del([/])?",description="删除分类")
	public void del(String ids) {
		if(catService.deleteAll(ids.split(","))>0){
			printJson(new Success( "删除完成."));
		}else {
			printJson(new Error( "删除失败."));
		}
	}

	@ActionUri(uri="setStatus([/])?",description="设置状态")
	public void setStatus(String id,String active) {
		if(active == null || "".equals(active)){
			printJson(new Error("未设置状态"));
		}else if(catService.setStatus(id, active)>0){
			printJson(new Success( "设置完成."));
		}else {
			printJson(new Error( "设置失败."));
		}
	}

	/**
	 * 菜单树
	 */
	@ActionUri(uri="simple-tree([/])?")
	public void simpleTree(Boolean checkbox,String checkboxName,String type){
		StringBuffer buffer = new StringBuffer();
		buffer.append("<ul class='tree'>");
		buffer.append("<li>");
		buffer.append("<div style='white-space:nowrap'>");
		buffer.append("<span style='padding:0'>");
		buffer.append("<a class='name'>");
		buffer.append("所有分类");
		buffer.append("</a>");
		buffer.append("</span>"	);
		buffer.append("</div>");
			buffer.append("<ul>");
			String nodes = walk(checkbox, checkboxName, null, type);
			buffer.append(nodes!=null && !"".equals(nodes)?nodes:"<li>未设置分类，请先在“分类管理”添加商品分类。</li>");
			buffer.append("</ul>");
		buffer.append("</li>");
		buffer.append("</ul>");
		print(buffer.toString());
	}
	
	/**读取叶子类树*/ 
	private String walk(Boolean checkbox,String checkboxName,String parentId,String type){
		// 根据传来的参数查询叶分类
		List<Cat> ics = null;
		if(!StringUtils.isEmpty(parentId)){
			ics = catService.queryChidren(parentId);
		}else{
			ics = catService.queryTopByType(type);
		}
		int size = ics!=null ?ics.size():0;
		StringBuffer buffer = new StringBuffer();
		for(int i=0;i<size;i++){ 
			Cat cat = ics.get(i);
			buffer.append("<li>");
			buffer.append("<div style='white-space:nowrap'>");
			if(checkbox!=null && checkbox){
				checkboxName = !StringUtils.isEmpty(checkboxName)?
						checkboxName.trim():"auth";
				buffer.append("<span style='padding:0'>");
				buffer.append("<input type=checkbox name=\""+checkboxName+"\" value=\""+cat.getId()+"\">");
				buffer.append("</span>"	);
			}
			buffer.append("<span style='padding:0'>");
			buffer.append("<a id="+cat.getId()+" class='name'>");
			buffer.append(!StringUtils.isEmpty(cat.getIcon())?"<span class='icon'><img src='"+attachPrefix+"/"+cat.getIcon()+"' width=16 height=16/></span>":"");
			buffer.append(cat.getName());
			buffer.append("</a>");
			buffer.append("</span>"	);
			buffer.append("</div>");
			Integer childrenTotal = catService.totalChildren(cat.getId());
			if(childrenTotal>0){
				//有子分类，则递归
				buffer.append("<ul>");
				buffer.append(walk(checkbox,checkboxName,cat.getId(),type));
				buffer.append("</ul>");
			}
			buffer.append("</li>");
		}
		return buffer.toString();
	}
}
