package com.minmeng.service.cms;

import java.util.Date;
import java.util.List;

import com.j2mvc.framework.dao.DaoSupport;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.cms.ForumContent;
import com.minmeng.service.CommonService;

/**
 * @description 专题
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2019-1-3
 */
public class ForumContentService extends CommonService{

	DaoSupport dao = new DaoSupport(ForumContent.class);
	String tableName = DBConstants.Table.CMS.FORUM_CONTENT;
	
	/**
	 * 插入
	 * @param forumContent
	 * @return
	 */
	public ForumContent insert(ForumContent forumContent) {		
		return (ForumContent) dao.insert(forumContent);
	}
	/**
	 * 更新
	 * @param forumContent
	 * @return
	 */
	public ForumContent update(ForumContent forumContent) {
		return (ForumContent)dao.update(forumContent);
	}

	/**
	 * 保存
	 * @param forumContent
	 * @return
	 */
	public ForumContent save(ForumContent forumContent) {
		if(forumContent == null || forumContent.getId() == null){
			return null;
		}
		if(get(forumContent.getId())!=null){
			forumContent.setUpdateTime(Constants.DATE_TIME_FORMAT.format(new Date()));
			forumContent = update(forumContent);
		}else {
			forumContent = insert(forumContent);
		}
		return forumContent; 
	}

	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public ForumContent get(String id) {
		Object object = dao.get(id);
		return object!=null?(ForumContent)object:null;
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
	public List<ForumContent> query(String sql,Object [] params) {
		List<?> list =  dao.query(sql,params);
		return list!=null && list.size()>0?(List<ForumContent>)list:null;
	}
}
