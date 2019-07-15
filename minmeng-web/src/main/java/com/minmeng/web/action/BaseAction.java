package com.minmeng.web.action;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import org.fixwork.framework.action.Action;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionUri;
import org.jsoup.Connection;
import org.jsoup.helper.HttpConnection;
import org.jsoup.nodes.Document;

import com.minmeng.entity.common.Ad;
import com.minmeng.entity.common.FriendUrl;
import com.minmeng.entity.common.SlideLink;
import com.minmeng.entity.ui.Nav;
import com.minmeng.service.cms.ContentInfoService;
import com.minmeng.service.common.AdService;
import com.minmeng.service.common.CatService;
import com.minmeng.service.common.FriendUrlService;
import com.minmeng.service.common.GlobalSettingService;
import com.minmeng.service.common.SlideLinkService;
import com.minmeng.service.ui.NavService;
import com.minmeng.service.ui.PageService;
import com.minmeng.service.ui.PageViewService;
import com.minmeng.service.ui.ViewService;
import com.minmeng.web.util.JspUtil;

/**
 * @Description 基础Action
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-21
 */
public class BaseAction extends Action {
	protected Logger log = Logger.getLogger(getClass().getCanonicalName());
	/** 索引路径 */
	protected String indexDir = I18n.i18n.get("INDEXED_DIR");
	/** 网站名称 */
	protected final String SITENAME = I18n.i18n.get("SITENAME");
	
	protected final String STATUS_OK = "1";

	/** 内容分页每页条数 */
	protected final Integer INFO_PAGESIZE = I18n.i18n.get("INFO_PAGESIZE")!=null &&  I18n.i18n.get("INFO_PAGESIZE").matches("\\d+")?Integer.valueOf(I18n.i18n.get("INFO_PAGESIZE")):20;
	/** 内容分页分隔符 */
	protected final String INFO_PAGESEQ = I18n.i18n.get("INFO_PAGESEQ");
	/** 列表 */
	protected final String CAT_TYPE_LIST = I18n.i18n.get("CAT_TYPE_LIST");
	/** 单页 */
	protected final String CAT_TYPE_SINGLE = I18n.i18n.get("CAT_TYPE_SINGLE");
	/** 图说 */
	protected final String CAT_TYPE_IMAGE = I18n.i18n.get("CAT_TYPE_IMAGE");
	/** 单页图说 */
	protected final String CAT_TYPE_IMAGE_SINGLE = I18n.i18n.get("CAT_TYPE_IMAGE_SINGLE");
	/** 互动 */
	protected final String CAT_TYPE_INTERACTION = I18n.i18n.get("CAT_TYPE_INTERACTION");
	
	protected NavService navService = new NavService();
	protected CatService catService = new CatService();
	protected ContentInfoService contentService = new ContentInfoService();
	protected PageService pageService = new PageService();
	protected ViewService viewService = new ViewService();
	protected PageViewService pageViewService = new PageViewService();
	protected GlobalSettingService gsService = new GlobalSettingService();
	protected AdService adService = new AdService();

	protected FriendUrlService friendUrlService = new FriendUrlService();

	/** JSP页面工具类 */
	protected JspUtil jspUtil;
	/** 来源标签 */ 
	protected String tag;
	/** 全局设置 */
	protected Map<String,String> setting;
	/** 默认域域 */
	protected String DEFAULT_DOMAIN = I18n.i18n.get("DEFAULT_DOMAIN");
	
	/**
	 * 读取子域名
	 * 同时查询出当前模块
	 */
	@Override
	public String onStart(){
		String serverName = request.getServerName();
		if(serverName.equals(DEFAULT_DOMAIN)){
			// 301重定向//
			response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);   
			response.setHeader("Location","http://www."+DEFAULT_DOMAIN);
			return null;
		}else if(!serverName.equals("www."+DEFAULT_DOMAIN)){
		}
		tag = request.getHeader("tag");
		if(tag == null)
			tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
		// 全局设置
		setting = gsService.query();
		// 导航栏
		navbar();
		// 滚动链接列表
		slideLinks();
		// 全局设置
		put("setting",setting);
		// 友情链接
		List<FriendUrl> friendUrls = friendUrlService.query();
		put("friendUrls", friendUrls);
		// 天气预报
		//weather();
		jspUtil = new JspUtil(request,response);

		// 轮播及横幅
		ads();
		return null;
	}

	public void ads(){
		List<Ad> rotationData = null;
		List<Ad> bannerData = null;
		if(jspUtil.isMobile()){
			rotationData = adService.queryByPosition(Ad.POS_MOBILE_INDEX_ROTATION, 5);
			bannerData = adService.queryByPosition(Ad.POS_MOBILE_BANNER, 1);
		}
		if(rotationData == null){
			rotationData = adService.queryByPosition(Ad.POS_INDEX_ROTATION, 5);
		}
		if(bannerData == null){
			bannerData = adService.queryByPosition(Ad.POS_PAGE_BANNER, 1);
		}
		put("rotationData",rotationData);
		put("bannerData",bannerData!=null && bannerData.size()>0?bannerData.get(0):null);
	}
	
	public String jsp(String jsp){
		return jspUtil.jsp(jsp);
	}
	/**
	 * 导航栏
	 */
	public void navbar(){
		List<Nav> navs = navService.query( STATUS_OK);
		put("navs",navs);
	}
	/**
	 * 滚动链接
	 */
	public void slideLinks(){
		SlideLinkService service = new SlideLinkService();
		List<SlideLink> slideLinks = service.query();
		put("slideLinks",slideLinks);
	}
	/**
	 * 天气预报
	 */
	@ActionUri(uri="weather([/])?")
	public void weather(){
		String url="https://tianqiapi.com/api.php?style=te&skin=pitaya";
		try {            
            Connection conn = HttpConnection.connect(url);  
			Document document = conn.get();
			print(document.body().html());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}    
  

	@ActionUri(uri="404([/])?")
	public String err404(){
		put("code",404);
		put("error","找不到网页");
		return jsp("err/error.jsp");
	}

	@ActionUri(uri="500([/])?")
	public String err500(){
		put("code",500);
		put("error","抱歉，错误的请求");
		return jsp("err/error.jsp");
	}
}
