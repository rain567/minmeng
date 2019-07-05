package com.minmeng.manager.action.cms;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.Pagination;
import org.fixwork.util.StringUtils;

import com.minmeng.entity.cms.ContentInfo;
import com.minmeng.entity.common.Cat;
import com.minmeng.service.cms.ContentInfoService;
import com.minmeng.service.common.CatService;
import com.minmeng.manager.action.BaseAction;

/**
 * @Description 管理员中心>内容
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-20
 */
@ActionPath(path="/cms/",dir="/WEB-INF/jsp/cms/")
public class ContentAction extends BaseAction{
	static final Logger log = Logger.getLogger(ContentAction.class);
	
	CatService catService = new CatService();
	ContentInfoService contentService = new ContentInfoService();

	/**
	 * 首页
	 * @param cid
	 * @return
	 * @throws IOException 
	 */
	@ActionUri(uri="([/])?")
	public void index(String keyword,String cid) throws IOException{
		keyword = !StringUtils.isEmpty(keyword)?keyword:"";
		Cat cat = catService.get(cid);
		if(cat == null){
			print("未指定栏目");
			return;
		}
		String catType = cat.getCatType();
		if(catType!=null){
			if(catType.equals(I18n.i18n.get("CAT_TYPE_LIST"))){
				// 列表栏目 
				response.sendRedirect(path+"/cms/list?cid="+cid+"&keyword="+keyword);
			}else if(catType.equals(I18n.i18n.get("CAT_TYPE_SINGLE"))){
				// 单页栏目
				response.sendRedirect(path+"/cms/edit2?cid="+cid);
			}else if(catType.equals(I18n.i18n.get("CAT_TYPE_IMAGE"))){
				// 图说栏目
				response.sendRedirect(path+"/cms/list?cid="+cid+"&keyword="+keyword);
			}else if(catType.equals(I18n.i18n.get("CAT_TYPE_IMAGE_SINGLE"))){
				// 单页图说栏目
				response.sendRedirect(path+"/cms/edit4?cid="+cid);
			}else if(catType.equals(I18n.i18n.get("CAT_TYPE_INTERACTION"))){
				// 互动栏目
				response.sendRedirect(path+"/cms/list?cid="+cid+"&keyword="+keyword);
			}
		}
	}
	
	@ActionUri(uri="list([/])?")
	public String list(String keyword,String cid){
		put("keyword",keyword);
		put("cid",cid);
		return "list.jsp";
	}

	@ActionUri(uri="getList([/])?")
	public void getList(String keyword, String cid,  
			String endTime,String startTime,
			Integer pageNumber,Integer pageSize){
		pageNumber = pageNumber!=null?pageNumber:1;
		String psStr = I18n.i18n.get("DEFAULT_PAGESIZE");
		pageSize =  pageSize!=null?pageSize:psStr.matches("\\d+")?Integer.valueOf(psStr):20;
		
		// 查询出总数
		Integer total = contentService.total(cid, keyword, startTime, endTime);
		// 创建分页对象
		Pagination pagination  = new Pagination(total,pageSize, pageNumber);
		// 查询分页数据
		Integer start = pagination.getStartIndex();
		List<ContentInfo> list = contentService.query(cid, keyword, startTime, endTime, start, pageSize);
		
		Map<String,Object> m = new HashMap<String,Object>();
		
		m.put("total", pagination.getTotal());
		m.put("rows", list);
		printJson(m);
	}
	/**
	 * 辑辑
	 * @param cid
	 * @return
	 * @throws IOException 
	 */
	@ActionUri(uri="edit([/])?")
	public void edit(String cid,String id) throws IOException{
		Cat cat = catService.get(cid);
		String catType = cat.getCatType();
		if(catType!=null){
			if(catType.equals("1")){
				// 普通栏目 
				response.sendRedirect(path+"/cms/edit1?cid="+cid+"&id="+id);
			}else if(catType.equals("2")){
				// 图说栏目
				response.sendRedirect(path+"/cms/edit2?cid="+cid+"&id="+id);
			}
		}
	}
}
