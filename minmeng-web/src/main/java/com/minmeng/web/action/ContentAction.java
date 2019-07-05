package com.minmeng.web.action;

import java.util.List;

import com.j2mvc.framework.i18n.I18n;
import com.j2mvc.framework.mapping.ActionPath;
import com.j2mvc.util.Pagination;
import com.j2mvc.util.StringUtils;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.cms.ContentInfo;
import com.minmeng.entity.common.Cat;
import com.minmeng.service.cms.ContentInfoService;
import com.minmeng.service.common.CatService;

/**
 * @Description 内容
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-21 创建
 * @Date 2014-12-26 变更
 */
@ActionPath(path="/c/")
public class ContentAction  extends BaseAction {
	
	protected CatService catService = new CatService();
	protected ContentInfoService infoService = new ContentInfoService();
	
	protected Cat cat;
	
	
	/**
	 * 读列表
	 * @param p 当前页号
	 * @param s 每页尺雨
	 * @param k 关键字
	 * @param st 开始时间
	 * @param et 结束时间
	 * @param ls 列表类型
	 */
	protected void loadList(Integer p,Integer s,String k,String st,String et,String ls){
		// 列表页
		p = p!=null && p > 0?p:1;
		if(s == null){
			String psStr = I18n.i18n.get("FRONT_PAGESIZE");
			s = psStr!=null && psStr.matches("\\d+")?Integer.valueOf(psStr):20;
		}
		
		// 查询出总数
		Integer total = infoService.total(cat.getId(), k, st, et);
		// 创建分页对象
		Pagination pagination  = new Pagination(total,s, p,"p");
		// 查询分页数据
		Integer start = pagination.getStartIndex();
		List<ContentInfo> infos = infoService.query(cat.getId(), k, st, et, start, s);
		// 输出
		put("cat",cat);
		put("catname",parents(cat.getId()));
		put("infos", infos);
		put("k", k);
		put("s", s);
		put("st", s);
		put("et", et);
		put("ls",!StringUtils.isEmpty(ls)?ls:cat.getListStyle());
		put("nodata", !(infos != null && infos.size() > 0) ? "未找到数据。" : "");
		put("pagination", pagination);
		String url = request.getRequestURI()+"?"
					+ (!StringUtils.isEmpty(k)?"k="+k:"")
					+ (s != null?"&s="+s:"")
					+ (!StringUtils.isEmpty(st) && st.matches(I18n.i18n.get("DATE_REGEXT"))?"&st='"+st+"'":"")
					+ (!StringUtils.isEmpty(et) && et.matches(I18n.i18n.get("DATE_REGEXT"))?"&et='"+et+"'":"")
					+ (!StringUtils.isEmpty(tag)?"&tag="+tag:"")
					+ (!StringUtils.isEmpty(ls)?"&ls="+ls:"");
		put("paginationHtml", pagination.getBootstrapHtml(url, 12, true));
		put("url",url+"&p="+p);
		put("title",cat.getName() + " - 第"+p+"页 － " + SITENAME );
		// 子栏目导航
		setSubcats();
	}

	/**
	 * 内容页
	 * @param p 内容分页
 	 * @param id 
	 */
	protected void loadInfo(String id,String catId,Integer p){
		// 内容页
		p = p!=null && p > 0?p:1; // 内容分页
		
		ContentInfo info = null;
		if(!StringUtils.isEmpty(id)){
			info = infoService.get(id);
		}else if(!StringUtils.isEmpty(catId)){
			info = infoService.getByCat(catId);
		}
		// 输出
		put("cat",cat);
		put("catname",parents(cat.getId()));
		if(info!=null){
			String html = info.getContent();  
			htmlPagination(html,p);  
			setNext(info.getCreateTime());
			setPrev(info.getCreateTime());
			String title = info.getTitle();
//			put("html", html);
			put("info", info);
			put("title",(title!=null && !title.equals("")?title + " － ":"") + cat.getName() + " － "  + SITENAME );
			// 设置浏览量
			info.setBrower(info.getBrower()+1);
			infoService.save(info);
		}else{
			put("nodata","未找到数据。");
		}
		// 子栏目导航
		setSubcats();
	}
	/**
	 * 内容分页
	 * @param html
	 */
	protected void htmlPagination(String html,Integer p){
//		HtmlPagination hp = new HtmlPagination(html, INFO_PAGESIZE, p,"p");
//		Pagination pagination = hp.getPagination();
		put("html", html);//hp.html());   
//		put("pagination", pagination);
//		put("paginationHtml", pagination.getBootstrapHtml(request.getRequestURI()
//				+ (!StringUtils.isEmpty(tag)?"?tag="+tag:""), 12, true));
	}
	

	/**
	 * 分类所有父分类
	 * @param id
	 */
	protected String parents(String id){
		Cat cat = catService.get(id);
		String str = getParents("",cat,0);
		return str;
	}

	/**
	 * 输出所有父级栏目
	 * @param str
	 * @param cat
	 * @param i
	 * @return
	 */
	protected String getParents(String str,Cat cat,int i){
		// 获取上级栏目
		if(cat!=null){
			//Integer childrenSize = catService.totalChidren(cat.getId(), module.getId());
			
			str = //(childrenSize>0?
					"<a href=\""+path+"/c/"+cat.getUri()+"\">"
					+ cat.getName() 
					+ "</a>"
					//:cat.getName())
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
	
	/**
	 * 设置子栏目导航
	 */
	protected void setSubcats(){
		Cat top = catService.getTop(cat);
		List<Cat> list = catService.queryChidren(top.getId());
		put("subcats",list);
	}

	/**
	 * 获取下一条
	 * 小于当前时间为下一条
	 * @param id
	 */
	protected void setNext(String createTime){
		String sql = "SELECT * FROM " + DBConstants.Table.CMS.CONTENT_INFO 
				+ " WHERE create_time<? and cat_id=? " 
				+ " order by create_time desc limit 1";
		List<?> list = infoService.query(sql, new String[]{createTime,cat.getId()});
		put("next",list!=null && list.size()>0? (ContentInfo) list.get(0):null);
	}
	/**
	 * 获取上一条
	 * 在于当前时间为上一条
	 * @param id
	 */
	protected void setPrev(String createTime){
		String sql = "SELECT * FROM " + DBConstants.Table.CMS.CONTENT_INFO + " WHERE create_time>?  and cat_id=?" +
				"order by create_time limit 1 ";
		List<?> list = infoService.query(sql, new String[]{createTime,cat.getId()});
		put("prev",list!=null && list.size()>0? (ContentInfo) list.get(0):null);
	}
}
