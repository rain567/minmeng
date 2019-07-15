package com.minmeng.service.ui;

import java.util.List;

import org.fixwork.framework.dao.DaoSupport;
import org.fixwork.util.StringUtils;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.ui.Nav;

/**
 * 导航
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-25
 */
public class NavService {

	DaoSupport dao = new DaoSupport(Nav.class);
	String tableName = DBConstants.Table.UI.NAV;

	/**
	 * 插入
	 * @param nav
	 * @return
	 */
	private Nav insert(Nav nav) {		
		return (Nav) dao.insert(nav);
	}
	
	/**
	 * 更新
	 * @param nav
	 * @return
	 */
	private Nav update(Nav nav) {
		return (Nav)dao.update(nav);
	}

	/**
	 * 保存
	 * @param nav
	 * @return
	 */
	public Nav save(Nav nav){
		if(nav == null)
			return null;
		if(get(nav.getId())!=null){
			// 更新
			nav = update(nav);
		}else{
			// 新增
			nav = insert(nav);
		}
		return nav;
	}

	/**
	 * 清除指定模块导航
	 * @param moduleId
	 */
	public void clear(String moduleId){
		String sql = "DELETE FROM "+tableName + " WHERE module_id=?";
		dao.execute(sql, new String[]{moduleId});
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
	public Nav get(String id) {
		Object object =  dao.get(id);
		return object!=null?(Nav)object:null;
	}

	/**
	 * link是否存在
	 * @param link
	 * @param moduleId
	 * @return
	 */
	public boolean existsLink(String link,String moduleId,String id){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE link=? and module_id=? and id<>?";
		return dao.number(sql,new String[]{link,moduleId,id})>0;
	}

	/**
	 * 名称是否存在
	 * @param name
	 * @param moduleId
	 * @return
	 */
	public boolean existsName(String name,String id){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE name=? and  id<>?";
		return dao.number(sql,new String[]{name,id})>0;
	}
	/**
	 * 设置启用状态
	 * @return
	 */
	public Integer setStatus(String id,String status) {
		String sql = "UPDATE "+tableName + " SET status=? WHERE id=?";
		return  dao.execute(sql, new Object[]{status,id});
	}

	/**
	 * 获取页面总数
	 * @param moduleId
	 * @param active
	 * @return
	 */
	public Integer total(String moduleId,String active){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE module_id=? " +
				(active!=null && !active.equals("")?"and active=? ":"");
		return dao.number(sql,
				active!=null && !active.equals("")?
						new Object[]{moduleId,active}:
							new Object[]{moduleId});
	}
	/**
	 * 获取页面列表
	 * @param moduleId
	 * @param active
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Nav> query(String status){
		String sql = "SELECT * FROM "+tableName + 
				(!StringUtils.isEmpty(status)?" WHERE status=? ":"") +
				" ORDER BY sorter ";
		List<?> list =  dao.query(sql,
				!StringUtils.isEmpty(status)?
						new Object[]{status}:
							new Object[]{});
		return list!=null?(List<Nav>) list:null;
	}
	/**
	 * 获取
	 * @param preSql 预编译查询语句
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Nav> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql, params);
		return list!=null?(List<Nav>) list:null;
	}
}
