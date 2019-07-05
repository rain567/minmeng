package com.minmeng.service.cms;

import java.util.Date;
import java.util.List;

import com.j2mvc.framework.dao.DaoSupport;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.cms.Forum;
import com.minmeng.service.CommonService;

/**
 * @description 专题
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2019-1-3
 */
public class ForumService extends CommonService{

	DaoSupport dao = new DaoSupport(Forum.class);
	String tableName = DBConstants.Table.CMS.FORUM;
	
	/**
	 * 插入
	 * @param forum
	 * @return
	 */
	public Forum insert(Forum forum) {		
		return (Forum) dao.insert(forum);
	}
	/**
	 * 更新
	 * @param forum
	 * @return
	 */
	public Forum update(Forum forum) {
		return (Forum)dao.update(forum);
	}

	/**
	 * 保存
	 * @param forum
	 * @return
	 */
	public Forum save(Forum forum) {
		if(forum == null || forum.getId() == null){
			return null;
		}
		if(get(forum.getId())!=null){
			forum.setUpdateTime(Constants.DATE_TIME_FORMAT.format(new Date()));
			forum = update(forum);
		}else {
			forum = insert(forum);
		}
		return forum; 
	}

	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public Forum get(String id) {
		Object object = dao.get(id);
		return object!=null?(Forum)object:null;
	}
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public Forum getByName(String name) {
		String sql = "SELECT * FROM "+tableName + " WHERE name=?";
		Object object = dao.queryForObject(sql,new String[]{name});
		return object!=null?(Forum)object:null;
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
	 * 设置启用状态
	 * @return
	 */
	public Integer setStatus(String id,String status) {
		String sql = "UPDATE "+tableName + " SET status=? WHERE id=?";
		return  dao.execute(sql, new String[]{status,id});
	}
	/**
	 * 名称已存在
	 * @param name
	 * @return
	 */
	public boolean exists(String name){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE name=?";
		return dao.number(sql,new String[]{name}) > 0;
	}
	/**
	 * 名称已存在
	 * @param name
	 * @param id
	 * @return
	 */
	public boolean existsName(String name,String id){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE name=? and id<>?";
		return dao.number(sql,new String[]{name,id}) > 0;
	}

	
	/**
	 * 总数
	 * @param sql
	 * @param params
	 * @return
	 */
	public Integer total(String sql,Object [] params){
		return dao.number(sql, params);
	}
	/**
	 * 预编译获取
	 * @param preSql 预编译语句	
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Forum> query(String sql,Object [] params) {
		List<?> list =  dao.query(sql,params);
		return list!=null && list.size()>0?(List<Forum>)list:null;
	}
}
