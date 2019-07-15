package com.minmeng.service.ui;

import java.util.Date;
import java.util.List;

import org.fixwork.framework.dao.DaoSupport;
import org.fixwork.util.Utils;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.ui.Page;

/**
 * 页面
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-23
 */
public class PageService {

	DaoSupport dao = new DaoSupport(Page.class);
	String tableName = DBConstants.Table.UI.PAGE;

	/**
	 * 插入
	 * @param page
	 * @return
	 */
	private Page insert(Page page) {		
		return (Page) dao.insert(page);
	}
	
	/**
	 * 更新
	 * @param page
	 * @return
	 */
	private Page update(Page page) {
		return (Page)dao.update(page);
	}

	/**
	 * 保存
	 * @param page
	 * @return
	 */
	public Page save(Page page){
		if(page == null)
			return null;
		Page p = getByName(page.getName());
		if(p != null){
			page.setId(p.getId());
			page.setUpdateTime(Constants.DATE_TIME_FORMAT.format(new Date()));
			page = update(page);
		}else{
			// 新增
			page.setId(Utils.createId());
			page = insert(page);
		}
		return page;
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
	public Page get(String id) {
		Object object =  dao.get(id);
		return object!=null?(Page)object:null;
	}
	
	/**
	 * 获取
	 * @param name
	 * @return
	 */
	public Page getByName(String name) {
		String sql = "SELECT * FROM "+tableName +  " WHERE name=?";
		Object object =  dao.queryForObject(sql,new String[]{name});
		return object!=null?(Page)object:null;
	}


	/**
	 * 名称是否存在
	 * @param name
	 * @return
	 */
	public boolean existsName(String name,String id){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE name=?  and id<>?";
		return dao.number(sql,new String[]{name,id})>0;
	}
	/**
	 * 获取指定模块页面列表
	 * @param moduleId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Page> query(String status){
		String sql = "SELECT * FROM "+tableName +
				(status!=null && !status.equals("")? " WHERE status=? ":"");
		List<?> list =  dao.query(sql,status!=null && !status.equals("")?
						new String[]{status}:
							new String[]{});
		return list!=null?(List<Page>) list:null;
	}

	/**
	 * 获取页面总数
	 * @param moduleId
	 * @return
	 */
	public Integer total(){
		String sql = "SELECT COUNT(*) FROM "+tableName ;
		return dao.number(sql,new Object[]{});
	}
	/**
	 * 获取页面列表
	 * @param moduleId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Page> query(int start,int limit){
		String sql = "SELECT * FROM "+tableName + "   limit ?,?";
		List<?> list =  dao.query(sql,new Object[]{start,limit});
		return list!=null?(List<Page>) list:null;
	}
	/**
	 * 获取
	 * @param preSql 预编译查询语句
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Page> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql, params);
		return list!=null?(List<Page>) list:null;
	}
}
