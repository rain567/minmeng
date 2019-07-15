package com.minmeng;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import org.fixwork.framework.dao.DaoSupport;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.util.MD5;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Utils;

/**
 * @description 常量
 * @Company 贵州万嘉
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2017-5-11
 */
public class Constants {
	public final static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	public final static SimpleDateFormat DATE_TIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public final static SimpleDateFormat TIME_FORMAT = new SimpleDateFormat("HH:mm:ss");

	public final static String ACTIVE_YES = "Y";
	public final static String ACTIVE_NO = "N";
	
	public final static int DEFAULT_PAGESIZE = 20;
	
	public final static String NODATA_MESSAGE = "未找到结果";
	/** 验证码有效期 **/
	public final static int CODE_VALID = 1000*60*60;
	/** 验证码重发间隔 **/
	public final static int CODE_RETRY_TIME = 1000*60;
	/** 登录验证码每天发送次数 **/
	public final static int CODE_DAY_NUM = 5;
	/** 登录每天错误次数 **/
	public final static int LOGIN_ERR_DAY_NUM = 5;

	/** 分类类型说明 */
	public final static Map<String,String> typeDescris = new HashMap<String,String>();
	/** 分类默认显示样式说明 */
	public final static Map<String,String> listStypeDescris = new HashMap<String,String>();

	static{
		if(I18n.i18n.get("CAT_TYPE_LIST")!=null)
			typeDescris.put(I18n.i18n.get("CAT_TYPE_LIST"),"列表栏目 <a>文章、新闻通常为此类型</a>");
		if(I18n.i18n.get("CAT_TYPE_SINGLE")!=null)
			typeDescris.put(I18n.i18n.get("CAT_TYPE_SINGLE"),"单页栏目 <a>联系我们、机构介绍等相似的单页面</a>");
//		if(I18n.i18n.get("CAT_TYPE_SMS_PRODUCT")!=null)
//			typeDescris.put(I18n.i18n.get("CAT_TYPE_SMS_PRODUCT"),"交易商品分类 <a>可以在线交易商品分类</a>");
		//typeDescris.put(I18n.i18n.get("CAT_TYPE_IMAGE_SINGLE"),"单页图说 <a>单页的图文内容</a>");
		//typeDescris.put(I18n.i18n.get("CAT_TYPE_INTERACTION"),"互动 <a>此类，前台提交,后台查询</a>");
	}
	
	static{
		if(I18n.i18n.get("LIST_STYLE_TEXT")!=null)
			listStypeDescris.put(I18n.i18n.get("LIST_STYLE_TEXT"),"文字列表 <a>纯文字+日期列表</a> ");
		if(I18n.i18n.get("LIST_STYLE_TEXT_IMAGE")!=null)
			listStypeDescris.put(I18n.i18n.get("LIST_STYLE_TEXT_IMAGE"),"图文列表 <a>若内容有预设图片，则可在列表页显示，同时显示内容概述，通常为截取内容字段部份内容。</a>");
		if(I18n.i18n.get("LIST_STYLE_THUMB")!=null)
			listStypeDescris.put(I18n.i18n.get("LIST_STYLE_THUMB"),"缩略图 <a>纯图片的显示，后台必须上传图片</a>");
		if(I18n.i18n.get("LIST_STYLE_THUMB_TEXT")!=null)
			listStypeDescris.put(I18n.i18n.get("LIST_STYLE_THUMB_TEXT"),"缩略图文 <a>图片加内容概述，通常以不规则的瀑布流式布局显示</a>");
	}
}
