package com.minmeng.service.ui;

import java.util.Date;
import java.util.List;

import com.j2mvc.framework.dao.DaoSupport;
import com.j2mvc.util.Utils;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.ui.PageView;

/**
 * 
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2018-12-18
 */
public class PageViewService {

	DaoSupport dao = new DaoSupport(PageView.class);
	String tableName = DBConstants.Table.UI.PAGE_VIEW;

	/**
	 * 插入
	 * @param pageView
	 * @return
	 */
	private PageView insert(PageView pageView) {		
		return (PageView) dao.insert(pageView);
	}
	
	/**
	 * 更新
	 * @param pageView
	 * @return
	 */
	private PageView update(PageView pageView) {
		return (PageView)dao.update(pageView);
	}

	/**
	 * 保存
	 * @param pageView
	 * @return
	 */
	public PageView save(PageView pageView){
		if(pageView == null)
			return null;
		PageView p = get(pageView.getId());
		if(p != null){
			pageView.setUpdateTime(Constants.DATE_TIME_FORMAT.format(new Date()));
			pageView = update(pageView);
		}else{
			// 新增
			pageView.setId(Utils.createId());
			pageView = insert(pageView);
		}
		return pageView;
	}

	/**
	 * 删除一组
	 * @param id
	 * @return
	 */
	public Integer delete(String...ids) {
		Object[] object = ids;
		return dao.delete(object);
	}
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public PageView get(String id) {
		Object object =  dao.get(id);
		return object!=null?(PageView)object:null;
	}
	
	public int clear(String pageId){
		String sql = "DELETE FROM "+tableName + " WHERE page_id=?";
		return dao.execute(sql,new String[]{pageId});
	}


	/**
	 * 获取总数
	 * @return
	 */
	public Integer total(){
		String sql = "SELECT COUNT(*) FROM "+tableName ;
		return dao.number(sql,new Object[]{});
	}
	/**
	 * 获取列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<PageView> query(int start,int limit){
		String sql = "SELECT * FROM "+tableName + "   limit ?,?";
		List<?> list =  dao.query(sql,new Object[]{start,limit});
		return list!=null?(List<PageView>) list:null;
	}
	/**
	 * 获取列表
	 * @param moduleId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<PageView> query(String pageName){
		String sql = "SELECT * FROM "+tableName + "   WHERE page_id in(" +
				"SELECT id FROM "+DBConstants.Table.UI.PAGE + " WHERE name=?) order by sorter";
		List<?> list =  dao.query(sql,new Object[]{pageName});
		return list!=null?(List<PageView>) list:null;
	}
	/**
	 * 获取
	 * @param preSql 预编译查询语句
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<PageView> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql, params);
		return list!=null?(List<PageView>) list:null;
	}
}
