package com.minmeng.service;

import java.util.List;

import org.fixwork.framework.dao.DaoSupport;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.util.MD5;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Utils;

/**
 * 
 * 公共服务
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date  2014-3-29
 */
public class CommonService{

	DaoSupport dao;

	public CommonService(){
		dao = new DaoSupport();
	}
	public CommonService(String dataSourceName){
		dao = new DaoSupport(dataSourceName);
	}

	/**
	 * 获取数值
	 * @param sql
	 * @param params
	 * @return
	 */
	public Integer number(String sql,Object[] params){
		return dao.number(sql, params);
	}
	/**
	 * 获取字符串
	 * @param sql
	 * @param params
	 * @return
	 */
	public String string(String sql,Object[] params){
		return dao.string(sql, params);
	}

	/**
	 * 获取字符串数组
	 * @param sql
	 * @param params
	 * @return
	 */
	public List<String> array(String sql,Object[] params){
		return dao.queryArray(sql, params);
	}

}
