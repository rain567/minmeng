package com.minmeng.manager.action;

import java.io.IOException;
import java.util.*;
import org.apache.log4j.Logger;
import org.fixwork.framework.action.Action;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.search.Indexer;
import org.fixwork.search.SearchItem;
import org.fixwork.util.CookieUtil;
import org.fixwork.util.Error;
import org.fixwork.util.IdentifyCode;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.cms.ContentInfo;
import com.minmeng.entity.common.Attach;
import com.minmeng.entity.common.Cat;
import com.minmeng.entity.common.Admin;
import com.minmeng.service.cms.ContentInfoService;
import com.minmeng.service.common.CatService;
import com.minmeng.service.common.AdminService;

/**  
 * @Description 编辑系统
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-17
 */
@ActionPath(path="/",dir="/WEB-INF/jsp/",description="编辑系统")
public class BaseAction extends Action{
	protected static final Logger log = Logger.getLogger(BaseAction.class.getCanonicalName());
	protected String indexDir = I18n.i18n.get("INDEXED_DIR");
	protected String attachPrefix = I18n.i18n.get("ATTACH_PREFIX");
 
	protected String sitename =  I18n.i18n.get("SITENAME");
	
	AdminService adminService = new AdminService(); 
	CatService catService = new CatService();
	ContentInfoService contentService = new ContentInfoService();
	
	String sessionParam = I18n.i18n.get("SESSION_ADMIN");
	String sessionidParamName = I18n.i18n.get("SESSION_ADMIN_SESSIONID");
	/** 网站名称 */
	protected final String SITENAME = I18n.i18n.get("SITENAME");
	protected String userAgent;
	protected String remoteAddr ;

	protected Admin sessionAdmin;

	@Override
	public String onStart(){
		sessionAdmin = (Admin) session.getAttribute(sessionParam);
		userAgent = request.getHeader("User-agent");
		remoteAddr = request.getRemoteAddr();
		return null;
	}
	
	/**
	 * 超级管理首页
	 */
	@ActionUri(uri="([/])?")
	public String index(){
		return "index.jsp";
	}


	/**
	 * 框架页数据
	 */
	@ActionUri(uri="source([/])?")
	public String source(String navid){
		Map<String, String[]> parameterMap = this.request.getParameterMap();
		Map<String, Object> objectMap = toMapObject(parameterMap);
		navid = (String) objectMap.get("navid");
		if(navid.equals("cms")){
			// 结果
			List<JsonSource> result = new ArrayList<JsonSource>();
			List<JsonSource> items = new ArrayList<JsonSource>();
			// 单页分类
			List<JsonSource> singleItems = getItems(null,null,I18n.i18n.get("CAT_TYPE_SINGLE"));
			if(singleItems!=null && singleItems.size()>0)
				items.addAll(singleItems);
			
			// 列表类分类
			List<JsonSource> listItems = getItems(null,null,I18n.i18n.get("CAT_TYPE_LIST"));
			if(listItems!=null && listItems.size()>0)
				items.addAll(listItems);
			
			if(items.size() == 0){
				// 设置刷新按钮
				JsonSource group = new JsonSource();
				group.setId("refresh");
				group.setName("请添加栏目并刷新页面");
				result.add(group);
			}else{
				// 菜单组
				JsonSource group = new JsonSource();
				group.setId("cms");
				group.setName("全部分类");
				group.setItems(items);
				result.add(group);
			}
			
			Map<String,List<JsonSource>> map = new HashMap<String,List<JsonSource>>();
			map.put("result", result);
			printJson(map);
			
			return null;//"sources/source-content.jsp";
		}
		return "sources/source-"+navid+".jsp";
	}

	/**
	 * 获取分类JSON源
	 */
	public List<JsonSource> getItems(String parentId,List<JsonSource> items,String type){
		items = items!=null ?items:new ArrayList<JsonSource>();
		List<Cat> cats = null;
		if(!StringUtils.isEmpty(parentId))
			cats = catService.queryChidren(parentId);
		else
			cats = catService.queryTopByType(type);
		if(cats!=null)
			for(Cat cat:cats){
				JsonSource source = new JsonSource();
				source.setId(cat.getId());
				source.setName(cat.getName());
				source.setUrl("cms?cid="+cat.getId());
				source.setItems(getItems(cat.getId(),null,type));
				items.add(source);
			}
		return items;
	}
	/**
	 * 顶部
	 */
	@ActionUri(uri="include/top([/])?",description="顶部")
	public String top(){
		return "include/top.jsp";
	}
	@ActionUri(uri="/login([/])?",description="登陆")
	public String login(){
		return "/WEB-INF/jsp/login.jsp";
	}

	/**
	 * 登陆
	 * @param username 用户名/手机号/邮箱
	 * @param password 密码
	 */
	@ActionUri(uri="/login([/])?",query="method=submit",description="提交登陆")
	public void loginSubmit(String username,String password,String code){
		if(!identifyCode(code)){
			return;
		}
		Admin admin = adminService.login(username, password,sitename);
		if(admin!=null){
			session.setAttribute(sessionParam, admin);	
			session.setAttribute(sessionidParamName, admin.getSessionid());	
	 		response.addCookie(CookieUtil.addCookie(sessionidParamName,admin.getSessionid(),  null,"",""));
			printJson(new Success("登陆成功，正在跳转管理界面."));
		}else{
			printJson(new Error("用户名或密码不正确."));
		}
	}

	@ActionUri(uri="/logout([/])?",description="退出")
	public void logout(){
		Admin sessionAdmin = (Admin)session.getAttribute(sessionParam);
		if(sessionAdmin!=null){
			adminService.clearSessionid(sessionAdmin.getId());
		}
		CookieUtil.reMoveCookie(request, response, sessionidParamName, "/", "");
		session.removeAttribute(sessionidParamName);
		session.removeAttribute(sessionParam);
		try {
			response.sendRedirect(path+"/");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@ActionUri(uri = "/identify-code",description="验证码是否正确")
	public boolean identifyCode(String code) {
		if (StringUtils.isEmpty(code)) {
			printJson(new Error("未输入验证码"));
			return false;
		} else if (Cache.identifyCode.equalsIgnoreCase(code)) {
			printJson(new Success("验证码正确"));
			return true;
		} else{
			printJson(new Error("验证码错误"));
			return false;
		}
	}

	@ActionUri(uri = "/show-identify-code",description="显示验证码图片")
	public void showIdentifyCode(){
		String lengthStr = I18n.i18n.get("IDENTIFY_CODE_LENGTH");
		int length = 0;
		if(lengthStr!=null && lengthStr.matches("\\d+")){
			length = Integer.valueOf(lengthStr);
		}
		IdentifyCode ic = null;
		if(length > 0){
			ic = new IdentifyCode(length);
		}else{
			ic = new IdentifyCode();
		}
		String code = ic.CreateIdentifyCode();
		Cache.identifyCode = code;
		ic.CreateImageOnPage(code, response);
	}

	@ActionUri(uri="cms/checkTitle([/])?",description="检查标题")
	public boolean checkTitle(String title,String id) {
		if(title == null || "".equals(title)){
			printJson(new Error("标题不能为空！"));
			return false;
		}else if(contentService.existsTitle(title, id)){
			printJson(new Error("标题重复！"));
			return false;
		}else {
			printJson(new Success("标题可用"));
			return true;
		}
	}

	@ActionUri(uri="cms/checkSubTitle([/])?",description="检查副标题（新闻简介）")
	public boolean checkSubTitle(String subtitle) {
		if(subtitle == null || "".equals(subtitle)){
			printJson(new Error("副标题不能为空！"));
			return false;
		}else {
			printJson(new Success("副标题（新闻简介）可用"));
			return true;
		}
	}


	@ActionUri(uri="setting/indexed([/])?",description="检查副标题（新闻简介）")
	public String indexed() {
		return "/WEB-INF/jsp/setting/indexed.jsp";
	}
	
	@ActionUri(uri="setting/indexed-all([/])?",description="创建所有模块索引")
	public void indexedAll() {
		log.debug("创建所有模块索引...");
		ContentInfoService infoService = new ContentInfoService();
		String sql = "SELECT * FROM "+ DBConstants.Table.CMS.CONTENT_INFO  + " WHERE " +
				" cat_id in(SELECT id FROM " 
				+ DBConstants.Table.Common.CAT
				+" WHERE cat_type=?) "+
				" ORDER BY create_time desc ";
		List<ContentInfo> list = infoService.query(sql, new String[]{I18n.i18n.get("CAT_TYPE_LIST")});
		List<SearchItem> siList = new ArrayList<SearchItem>();
		if(list == null ){
			printJson(new Error( "未找到内容，无法创建索引."));
			return;
		}
		int size = list.size();
		log.debug("列表栏目内容总数："+size+"条。");
		for(int i=0;i<size;i++){
			ContentInfo info = list.get(i);
			SearchItem item = new SearchItem();
			item.setId(info.getId());
			item.setCatId(info.getCat().getId()); 
			item.setContent(info.getContent());
			item.setCreateTime(info.getCreateTime());
			item.setKeywords(info.getKeywords());
			item.setSource(info.getSource());
			item.setSubtitle(info.getSubtitle());
			item.setTitle(info.getTitle());
			item.setUpdateTime(info.getUpdateTime());
			String href = info.getHref();
			if(href == null || "".equals(href)){
				Cat cat = info.getCat();
				href = "http://www."+I18n.i18n.get("DEFAULT_DOMAIN")+"/c/"+cat.getUri()+"/"+item.getId();
			}
			item.setHref(href);
			List<Attach> images = info.getImages();
			if(images!=null ){
				int isize = images.size();
				String[] array = new String[isize];
				for(int j=0;j<isize;j++){
					Attach image = images.get(j);
					array[j] = image.getUrl();
				}
				item.setImages(array);
			}
			List<Attach> files = info.getFiles();
			if(files!=null ){
				int fsize = files.size();
				String[] array = new String[fsize];
				for(int j=0;j<fsize;j++){
					Attach file = files.get(j);
					array[j] = file.getUrl();
				}
				item.setFiles(array);
			}
			siList.add(item);	
		}
		log.debug("创建索引开始，共"+siList.size()+"条。");
		Integer total = Indexer.indexed(siList,indexDir);
		printJson(new Success( "创建索引共"+total+"条."));
		log.debug("创建索引结束，共"+total+"条。");
	}

	/**
	 * 创建索引
	 * @param infos
	 * @return
	 */
	public Integer indexed(ContentInfo info){
		List<SearchItem> siList = new ArrayList<SearchItem>();
		SearchItem item = new SearchItem();
		item.setId(info.getId());
		item.setCatId(info.getCat().getId());
		item.setContent(info.getContent());
		item.setCreateTime(info.getCreateTime());
		List<Attach> images = info.getImages();
		if(images!=null ){
			int size = images.size();
			String[] array = new String[size];
			for(int i=0;i<size;i++){
				Attach image = images.get(i);
				array[i] = image.getUrl();
			}
			item.setImages(array);
		}
		List<Attach> files = info.getFiles();
		if(files!=null ){
			int size = files.size();
			String[] array = new String[size];
			for(int i=0;i<size;i++){
				Attach file = files.get(i);
				array[i] = file.getUrl();
			}
			item.setFiles(array);
		}
		item.setKeywords(info.getKeywords());
		item.setSource(info.getSource());
		item.setSubtitle(info.getSubtitle());
		item.setTitle(info.getTitle());
		item.setUpdateTime(info.getUpdateTime());
		String href = info.getHref();
		if(href == null || "".equals(href)){
			Cat cat = info.getCat();
			href = "http://www."+I18n.i18n.get("DEFAULT_DOMAIN")+"/c/"+cat.getUri()+"/"+item.getId();
		}
		item.setHref(href);
		siList.add(item);
		return Indexer.indexed(siList,indexDir);
	}

	public Map<String, Object> toMapObject(Map<String, String[]> paraMap) {
		Map<String, Object> map = new HashMap<>();
		Set<String> strings = paraMap.keySet();
		for (String s : strings) {
			String[] stringArray = paraMap.get(s);
			map.put(s, org.apache.commons.lang3.StringUtils.join(stringArray));
		}
		return map;
	}

}
