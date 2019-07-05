package com.minmeng.service.ui;

import java.util.Date;
import java.util.List;

import com.j2mvc.framework.dao.DaoSupport;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.ui.View;

/**
 * 
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2018-12-26
 */
public class ViewService {

	DaoSupport dao = new DaoSupport(View.class);
	String tableName = DBConstants.Table.UI.VIEW;

	/**
	 * 插入
	 * @param view
	 * @return
	 */
	private View insert(View view) {		
		return (View) dao.insert(view);
	}
	
	/**
	 * 更新
	 * @param view
	 * @return
	 */
	private View update(View view) {
		return (View)dao.update(view);
	}

	/**
	 * 保存
	 * @param view
	 * @return
	 */
	public View save(View view){
		if(view == null)
			return null;
		View p = get(view.getId());
		if(p != null){
			view.setUpdateTime(Constants.DATE_TIME_FORMAT.format(new Date()));
			view = update(view);
		}else{
			// 新增
			view = insert(view);
		}
		return view;
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
	public View get(String id) {
		Object object =  dao.get(id);
		return object!=null?(View)object:null;
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
	 * 控件是否存在
	 * @param id
	 * @param name
	 * @return
	 */
	public boolean exists(String id,String name){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE id<>? and name=?";
		return dao.number(sql,new String[]{id,name})>0;
	}
	/**
	 * 获取列表
	 * @return
	 */
	public String getName(String id){
		String sql = "SELECT name FROM "+tableName + " WHERE id=?";
		return dao.string(sql,new Object[]{id});
	}
	/**
	 * 获取列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<View> queryChildren(String parentId,String outMode){
		String sql = "SELECT * FROM "+tableName + " WHERE parent_id=? and out_mode=? and status=? order by sorter";
		List<?> list =  dao.query(sql,new Object[]{parentId,outMode,"1"});
		return list!=null?(List<View>) list:null;
	}
	/**
	 * 获取列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<View> query(int start,int limit){
		String sql = "SELECT * FROM "+tableName + " order by sorter  limit ?,?";
		List<?> list =  dao.query(sql,new Object[]{start,limit});
		return list!=null?(List<View>) list:null;
	}

	/**
	 * 获取列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<View> query(String parentId){
		String sql = "SELECT * FROM "+tableName + " WHERE parent_id=? order by sorter";
		List<?> list =  dao.query(sql,new Object[]{parentId});
		return list!=null?(List<View>) list:null;
	}
	/**
	 * 获取
	 * @param pageName 页面
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<View> queryByPage(String pageName) {
		String sql = "SELECT * FROM "+tableName + " WHERE  status=? and id in(" +
				"SELECT view_id FROM "+DBConstants.Table.UI.PAGE_VIEW + 
				"   WHERE status=? and page_id in(" +
				"SELECT id FROM "+DBConstants.Table.UI.PAGE + " WHERE name=?)) order by sorter";
		List<?> list =  dao.query(sql, new String[]{"1","1",pageName});
		return list!=null?(List<View>) list:null;
	}
	
	/**
	 * 获取
	 * @param preSql 预编译查询语句
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<View> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql, params);
		return list!=null?(List<View>) list:null;
	}

	/**
	 * 获取子分类列表
	 * @param parentId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<View> queryChidren(String parentId){
		String sql = "SELECT * FROM "+tableName + " WHERE parent_id=?";
		List<?> list =  dao.query(sql,new Object[]{parentId});
		return list!=null && list.size()>0?(List<View>)list:null;
	}

	
	/**
	 * 获取子分类列表，过滤指定ID
	 * @param parentId
	 * @param filterId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<View> queryTopUnionFilter(String filterId){
		String sql = "SELECT * FROM "+tableName + " WHERE " +
				"id not in(select id from  "+tableName + " where parent_id=? or id=?)  " +
				" and ( parent_id='' or parent_id is null) order by sorter";
		List<?> list =  dao.query(sql,new Object[]{filterId,filterId});
		return list!=null && list.size()>0?(List<View>)list:null;
	}
	/**
	 * 获取子分类列表，过滤指定ID
	 * @param parentId
	 * @param filterId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<View> queryTop(String status){
		String sql = "SELECT * FROM "+tableName + " WHERE (parent_id='' or parent_id is null) and status=? order by sorter ";
		List<?> list =  dao.query(sql,new Object[]{status});
		return list!=null && list.size()>0?(List<View>)list:null;
	}
	/**
	 * 获取子分类列表，过滤指定ID
	 * @param parentId
	 * @param filterId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<View> queryChidrenUnionFilter(String parentId,String filterId){
		String sql = "SELECT * FROM "+tableName + " WHERE " +
				"id not in(select id from  "+tableName + " where parent_id=? or id=?)  " +
				(parentId!=null && !parentId.trim().equals("")?" and parent_id=? ":"")+
				" order by sorter ";
		List<?> list =  dao.query(sql,
				parentId!=null && !parentId.trim().equals("")?
						new Object[]{filterId,filterId,parentId}:
							new Object[]{filterId,filterId});
		return list!=null && list.size()>0?(List<View>)list:null;
	}

	/**
	 * 获取子分类列表总数
	 * @param parentId
	 * @param filterId
	 * @return
	 */
	public Integer totalChildren(String parentId){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE parent_id=? ";
		return  dao.number(sql,new Object[]{parentId});
	}
	/**
	 * 获取所有子分类列表总数
	 * @param parentId
	 * @param filterId
	 * @return
	 */
	public Integer totalAllChidren(String parentId){
		String sql = "SELECT COUNT(*) FROM "+tableName +
				(parentId!=null && !parentId.trim().equals("")?" WHERE parent_id=? ":"") ;
		return  dao.number(sql,
				parentId!=null && !parentId.trim().equals("")?
						new Object[]{parentId}:null);
	}
	/**
	 * 获取子分类列表总数
	 * @param parentId
	 * @param filterId
	 * @return
	 */
	public Integer totalChidren(String parentId){
		String sql = "SELECT COUNT(*) FROM "+tableName + 
				(parentId!=null && !parentId.trim().equals("")?" WHERE  parent_id=? ":"") ;
		return  dao.number(sql,
				parentId!=null && !parentId.trim().equals("")?
						new Object[]{parentId}:
							new Object[]{});
	}
	/**
	 * 获取子分类列表，过滤指定ID总数
	 * @param parentId
	 * @param filterId
	 * @return
	 */
	public Integer totalChidrenUnionFilter(String parentId,String filterId){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE " +
				"id not in(select id from  "+tableName + " where parent_id=? or id=?)  " +
				(parentId!=null && !parentId.trim().equals("")?" and parent_id=? ":"") ;
		return  dao.number(sql,
				parentId!=null && !parentId.trim().equals("")?
						new Object[]{filterId,filterId,parentId}:
							new Object[]{filterId,filterId});
	}
	/**
	 * 获取子分类列表
	 * @param parentId
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<View> queryChidren(String parentId,int start,int limit){
		String sql = "SELECT * FROM "+tableName + " WHERE " +
			(parentId!=null && !parentId.trim().equals("")?" and parent_id=? ":"") +
				" order by sorter limit ?,?";
		List<?> list =  dao.query(sql,
				parentId!=null && !parentId.trim().equals("")?
						new Object[]{parentId,start,limit}:
							new Object[]{start,limit});
		return list!=null && list.size()>0?(List<View>)list:null;
	}


	/**
	 * 输出所有父级控件名称
	 * @param str
	 * @param view
	 * @param i
	 * @return
	 */
	public String parents(String id){
		View view = get(id);
		String str = getParents("",view,0);
		return str;
	}
	/**
	 * 输出所有父级控件名称
	 * @param str
	 * @param view
	 * @param i
	 * @return
	 */
	public String getParents(String str,View view,int i){
		// 获取上级控件
		if(view!=null){
			Integer childrenSize = totalChidren(view.getId());
			
			str = (childrenSize>0?view.getName() :view.getName())+ (i>0?" &raquo; ":"") + str;
			i ++;
			View parent = get(view.getParentId());
			if(parent !=null){
				str = getParents(str,parent,i);
			}else{
			}
		}
		return str;
	}

	/**
	 * 获取父级分类
	 * @param id
	 * @return
	 */
	public View getParent(String id){
		String sql = "SELECT * FROM "+tableName + " WHERE id in" +
				"(SELECT parent_id FROM "+tableName+" WHERE id=?)";
		Object object = dao.queryForObject(sql,new String[]{id});
		return object!=null?(View)object:null;
	}
	/**
	 * 获取顶级分类
	 * @param id
	 * @return
	 */
	public View getTop(String id){
		return getTop(get(id));
	}
	/**
	 * 获取顶级分类
	 * @param View
	 * @return
	 */
	public View getTop(View View){
		if(View!=null){
			View parent = getParent(View.getId());
			View = getTop(parent);
		}
		return View;
	}
}
