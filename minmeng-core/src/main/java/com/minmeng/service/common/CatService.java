package com.minmeng.service.common;

import java.util.ArrayList;
import java.util.List;

import com.j2mvc.framework.dao.DaoSupport;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.Cat;

/**
 * @description 分类
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-17
 */
public class CatService{

	DaoSupport dao = new DaoSupport(Cat.class);
	String tableName = DBConstants.Table.Common.CAT;
	
	/**
	 * 插入
	 * @param cat
	 * @return
	 */
	public Cat insert(Cat cat) {		
		return (Cat) dao.insert(cat);
	}
	/**
	 * 更新
	 * @param cat
	 * @return
	 */
	public Cat update(Cat cat) {
		return (Cat)dao.update(cat);
	}

	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public Cat get(String id) {
		Object object = dao.get(id);
		return object!=null?(Cat)object:null;
	}

	/**
	 * 查询指定uri及模块的分类
	 * @param uri
	 * @param moduleId
	 * @return
	 */
	public Cat getByUri(String uri){
		String sql = "SELECT * FROM "+tableName + " WHERE uri=? ";
		Object object = dao.queryForObject(sql, new String[]{uri});
		return object!=null?(Cat)object:null;
	}
	
	/**
	 * 保存
	 * @param cat
	 * @return
	 */
	public Cat save(Cat cat){
		if(cat == null || cat.getId() == null){
			return null;
		}
		if(get(cat.getId())!=null){
			cat = update(cat);
		}else {
			cat = insert(cat);
		}
		return cat; 
	}
	/**
	 * 删除
	 * @param ...id
	 * @return
	 */
	public Integer delete(String...id){
		Object[] object = id;
		return dao.delete(object);
	}
	/**
	 * 删除包括子分类
	 * @param ...id
	 * @return
	 */
	public Integer deleteAll(String...id){
		List<String> list = new ArrayList<String>();
		for(int i=0;i<id.length;i++){
			list.add(id[i]);
			getChidren(id[i],list);
		}
		Object[] array = new Object[list.size()];
		list.toArray(array);
		return dao.delete(array);
	}

	/**
	 * 获取所有子分类ID
	 * @param id
	 * @param list
	 * @return
	 */
	public List<String> getChidren(String id,List<String> list){
		String sql = "SELECT id FROM "+tableName + " WHERE parent_id=?";
		List<String> array = dao.queryArray(sql, new String[]{id});
		list = list!=null?list:new ArrayList<String>();
		if(array!=null){
			int size = array.size();
			for(int i=0;i<size;i++ ){
				String s = array.get(i);
				list.add(s);
				getChidren(s, list);
			}
		}
		return list;
	}


	/**
	 * 设置管理限制
	 * @return
	 */
	public Integer setAdminLimit(String idArr,String adminLimit) {
		idArr = idArr.replace(",", "','");
		String sql = "UPDATE "+tableName + " SET admin_limit=? WHERE id in('"+idArr+"')";
		return  dao.execute(sql, new Object[]{adminLimit});
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
	 * 预编译获取
	 * @param preSql 预编译语句	
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Cat> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql,params);
		return list!=null && list.size()>0?(List<Cat>)list:null;
	}
	/**
	 * 删除指定模块的分类
	 * @param moduleId
	 * @return
	 */
	public Integer deleteByModule(String moduleId){
		String sql = "DELETE FROM "+tableName + " WHERE module_id=?";
		return dao.number(sql, new String[]{moduleId});
	}

	/**
	 * 同级名称存在
	 * @param id
	 * @param name
	 * @return
	 */
	public boolean existsName(String id,String parentId,String name){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE name=? and id<>? and parent_id=?";
		return dao.number(sql,new String[]{name,id,parentId})>0;
	}

	/**
	 * URI存在
	 * @param id
	 * @param name
	 * @return
	 */
	public boolean existsUri(String id,String uri){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE uri=? and id<>?";
		return dao.number(sql,new String[]{uri,id})>0;
	}
	/**
	 * 所有顶级分类
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Cat> queryTop(int start,int limit) {
		String sql = "SELECT * FROM "+tableName + " WHERE parent_id='' or parent_id is null order by sorter limit ?,?";
		List<?> list =  dao.query(sql,new Integer[]{start,limit});
		return list!=null && list.size()>0?(List<Cat>)list:null;
	}

	/**
	 * 所有指定类型顶级分类
	 * @param type
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Cat> queryTopByType(String type,int start,int limit) {
		String sql = "SELECT * FROM "+tableName + " WHERE cat_type=? and ( parent_id='' or parent_id is null) order by sorter limit ?,?";
		List<?> list =  dao.query(sql,new Object[]{type,start,limit});
		return list!=null && list.size()>0?(List<Cat>)list:null;
	}

	/**
	 * 所有顶级分类
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Cat> queryTop() {
		String sql = "SELECT * FROM "+tableName + " WHERE parent_id='' or parent_id is null order by sorter";
		List<?> list =  dao.query(sql);
		return list!=null && list.size()>0?(List<Cat>)list:null;
	}

	/**
	 * 所有指定类型顶级分类
	 * @param moduleId
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Cat> queryTopByType(String type) {
		String sql = "SELECT * FROM "+tableName + " WHERE  cat_type=? and ( parent_id='' or parent_id is null) order by sorter";
		List<?> list =  dao.query(sql,new Object[]{type});
		return list!=null && list.size()>0?(List<Cat>)list:null;
	}
	/**
	 * 获取子分类列表
	 * @param parentId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Cat> queryChidren(String parentId){
		String sql = "SELECT * FROM "+tableName + " WHERE parent_id=?  order by sorter";
		List<?> list =  dao.query(sql,new Object[]{parentId});
		return list!=null && list.size()>0?(List<Cat>)list:null;
	}

	/**
	 * 获取子分类列表
	 * @param parentId
	 * @param moduleId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Cat> queryChidren(String parentId,String moduleId){
		String sql = "SELECT * FROM "+tableName + " WHERE " +
				"module_id=? " +
				(parentId!=null && !parentId.trim().equals("")?" and parent_id=? ":"") +
				"order by sorter";
		List<?> list =  dao.query(sql,
				parentId!=null && !parentId.trim().equals("")?
						new Object[]{moduleId,parentId.trim()}:
							new Object[]{moduleId});
		return list!=null && list.size()>0?(List<Cat>)list:null;
	}
	
	/**
	 * 获取子分类列表，过滤指定ID
	 * @param parentId
	 * @param filterId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Cat> queryTopUnionFilter(String filterId,String type){
		String sql = "SELECT * FROM "+tableName + " WHERE " +
				"id not in(select id from  "+tableName + " where parent_id=? or id=?)  " +
				" and ( parent_id='' or parent_id is null) " +
				(type!=null && !type.equals("")?" and cat_type=? ":"") +
				" order by sorter";
		List<?> list =  dao.query(sql,
				type!=null && !type.equals("")?
						new Object[]{filterId,filterId,type}:
							new Object[]{filterId,filterId});
		return list!=null && list.size()>0?(List<Cat>)list:null;
	}
	/**
	 * 获取子分类列表，过滤指定ID
	 * @param parentId
	 * @param filterId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Cat> queryChidrenUnionFilter(String parentId,String filterId){
		String sql = "SELECT * FROM "+tableName + " WHERE " +
				"id not in(select id from  "+tableName + " where parent_id=? or id=?)  " +
				(parentId!=null && !parentId.trim().equals("")?" and parent_id=? ":"") +
				" order by sorter";
		List<?> list =  dao.query(sql,
				parentId!=null && !parentId.trim().equals("")?
						new Object[]{filterId,filterId,parentId}:
							new Object[]{filterId,filterId});
		return list!=null && list.size()>0?(List<Cat>)list:null;
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
	public List<Cat> queryChidren(String parentId,int start,int limit){
		String sql = "SELECT * FROM "+tableName + " WHERE " +
			(parentId!=null && !parentId.trim().equals("")?" and parent_id=? ":"") +
				" order by sorter limit ?,?";
		List<?> list =  dao.query(sql,
				parentId!=null && !parentId.trim().equals("")?
						new Object[]{parentId,start,limit}:
							new Object[]{start,limit});
		return list!=null && list.size()>0?(List<Cat>)list:null;
	}
	/**
	 * 获取子分类列表
	 * @param parentId
	 * @param moduleId
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Cat> queryChidren(String parentId,String moduleId,int start,int limit){
		String sql = "SELECT * FROM "+tableName + " WHERE " +
				"module_id=? " +
				(parentId!=null && !parentId.trim().equals("")?" and parent_id=? ":"") +
				"order by sorter limit ?,?";
		List<?> list =  dao.query(sql,
				parentId!=null && !parentId.trim().equals("")?
						new Object[]{moduleId,parentId,start,limit}:
							new Object[]{moduleId,start,limit});
		return list!=null && list.size()>0?(List<Cat>)list:null;
	}


	/**
	 * 获取父级分类
	 * @param id
	 * @return
	 */
	public Cat getParent(String id){
		String sql = "SELECT * FROM "+tableName + " WHERE parent_id=?";
		Object object = dao.queryForObject(sql,new String[]{id});
		return object!=null?(Cat)object:null;
	}
	/**
	 * 获取顶级分类
	 * @param id
	 * @return
	 */
	public Cat getTop(String id){
		return getTop(get(id));
	}
	/**
	 * 获取顶级分类
	 * @param cat
	 * @return
	 */
	public Cat getTop(Cat cat){
		if(cat!=null){
			Cat parent = get(cat.getParentId());
			if(parent!=null)
				cat = getTop(parent);
		}
		return cat;
	}
}
