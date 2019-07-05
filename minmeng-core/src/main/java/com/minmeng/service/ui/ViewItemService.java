package com.minmeng.service.ui;

import java.util.Date;
import java.util.List;

import com.j2mvc.framework.dao.DaoSupport;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.ui.ViewItem;

/**
 * 
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2018-12-26
 */
public class ViewItemService {

	DaoSupport dao = new DaoSupport(ViewItem.class);
	String tableName = DBConstants.Table.UI.VIEW_ITEM;

	/**
	 * 插入
	 * @param viewItem
	 * @return
	 */
	private ViewItem insert(ViewItem viewItem) {		
		return (ViewItem) dao.insert(viewItem);
	}
	
	/**
	 * 更新
	 * @param viewItem
	 * @return
	 */
	private ViewItem update(ViewItem viewItem) {
		return (ViewItem)dao.update(viewItem);
	}

	/**
	 * 保存
	 * @param viewItem
	 * @return
	 */
	public ViewItem save(ViewItem viewItem){
		if(viewItem == null)
			return null;
		ViewItem p = get(viewItem.getId());
		if(p != null){
			viewItem.setUpdateTime(Constants.DATE_TIME_FORMAT.format(new Date()));
			viewItem = update(viewItem);
		}else{
			// 新增
			viewItem = insert(viewItem);
		}
		return viewItem;
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
	public ViewItem get(String id) {
		Object object =  dao.get(id);
		return object!=null?(ViewItem)object:null;
	}

	/**
	 * 获取总数
	 * @return
	 */
	public Integer total(String viewId){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE view_id=?";
		return dao.number(sql,new Object[]{viewId});
	}
	/**
	 * 获取列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ViewItem> query(String viewId,int start,int limit){
		String sql = "SELECT * FROM "+tableName + " WHERE view_id=? ORDER BY sorter limit ?,?";
		List<?> list =  dao.query(sql,new Object[]{viewId,start,limit});
		return list!=null?(List<ViewItem>) list:null;
	}

	/**
	 * 获取列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ViewItem> query(String viewId){
		String sql = "SELECT * FROM "+tableName + " WHERE view_id=? and status=? ORDER BY sorter";
		List<?> list =  dao.query(sql,new Object[]{viewId,"1"});
		return list!=null?(List<ViewItem>) list:null;
	}

	/**
	 * 获取列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ViewItem> query(String viewId,Integer limit){
		String sql = "SELECT * FROM "+tableName + " WHERE view_id=? and status=? ORDER BY sorter limit ? ";
		List<?> list =  dao.query(sql,new Object[]{viewId,"1",limit});
		return list!=null?(List<ViewItem>) list:null;
	}
	/**
	 * 获取
	 * @param preSql 预编译查询语句
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ViewItem> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql, params);
		return list!=null?(List<ViewItem>) list:null;
	}
}
