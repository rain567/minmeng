package com.minmeng.service.common;

import java.util.ArrayList;
import java.util.List;



import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.Ad;
import com.minmeng.service.CommonService;
import org.fixwork.framework.dao.DaoSupport;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Utils;

/**
 * 广告
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-25
 */
public class AdService  extends CommonService{

	DaoSupport dao = new DaoSupport(Ad.class);
	String tableName = DBConstants.Table.Common.AD;

	/**
	 * 插入
	 * @param ad
	 * @return
	 */
	private Ad insert(Ad ad) {		
		return (Ad) dao.insert(ad);
	}
	
	/**
	 * 更新
	 * @param ad
	 * @return
	 */
	private Ad update(Ad ad) {
		return (Ad)dao.update(ad);
	}

	/**
	 * 保存
	 * @param ad
	 * @return
	 */
	public Ad save(Ad ad){
		if(ad == null)
			return null;
		if(get(ad.getId())!=null){
			// 更新
			ad = update(ad);
		}else{
			// 新增
			ad = insert(ad);
		}
		return ad;
	}

	/**
	 * 清除指定模块
	 * @param moduleId
	 */
	public void clear(){
		String sql = "DELETE FROM "+tableName;
		dao.execute(sql,null);
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
	public Ad get(String id) {
		Object object =  dao.get(id);
		return object!=null?(Ad)object:null;
	}

	/**
	 * 设置启用状态
	 * @return
	 */
	public Integer setActive(String id,String active) {
		String sql = "UPDATE "+tableName + " SET active=? WHERE id=?";
		return  dao.execute(sql, new Object[]{active,id});
	}

	/**
	 * 获取
	 * @param preSql 预编译查询语句
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Ad> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql, params);
		return list!=null?(List<Ad>) list:null;
	}


	/**
	 * 获取总数
	 * @param active
	 * @param position
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int total(String active,String position){
		Object[] metals = createSqlMetals(active,position);
		String sql = "SELECT count(*) "+metals[0];
		List<Object> params = (List<Object>) metals[1];
		return dao.number(sql, params.toArray());
	}
	/**
	 * 获取内容列表
	 * @param active
	 * @param position
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Ad> query() {
		String sql = "SELECT * FROM "+tableName+" order by position,sorter";
		return (List<Ad>) dao.query(sql);
	}
	/**
	 * 获取内容列表
	 * @param active
	 * @param position
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Ad> query(String status,String position,int start,int limit) {
		Object[] metals = createSqlMetals(status,position);
		String sql = "SELECT * "+metals[0]+" order by position,sorter limit ?,?";
		List<Object> params = (List<Object>) metals[1];
		params.add(start);
		params.add(limit);
		return (List<Ad>) dao.query(sql, params.toArray());
	}

	/**
	 * 获取内容列表
	 * @param active
	 * @param position
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Ad> queryByPosition(String position,int limit) {
		String sql = "SELECT * FROM "+tableName+" WHERE position=? and status='1' order by sorter limit ?";
		return (List<Ad>) dao.query(sql, new Object[]{position,limit});
	}
	
	/**
	 * 生成查询语句以及查询参数集合
	 * @param active
	 * @param position
	 * @return
	 */
	private Object[] createSqlMetals(String status,String position){
		String sqlText = " FROM "+tableName + " WHERE 1=1 " 
				+ (!StringUtils.isEmpty(status)?" and status=?":"")
				+ (!StringUtils.isEmpty(position)?" and position=?":""); 
		// 添加参数
		List<Object> params = new ArrayList<Object>();
		if(!StringUtils.isEmpty(status))
			params.add(status);
		if(!StringUtils.isEmpty(position))
			params.add(position);
		return new Object[]{sqlText,params};
	}
}
