package com.minmeng.service.sys;

import java.util.ArrayList;
import java.util.List;

import org.fixwork.framework.dao.DaoSupport;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.util.MD5;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Utils;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.sys.SqlDump;

/**
 * @description 系统备份还原
 * @dump 贵州沃尔达科技有限公司
 * @version 1.0 2015-3-25 创建@杨大江
 */
public class SqlDumpService{

	DaoSupport dao = new DaoSupport(SqlDump.class);
	String tableName = DBConstants.Table.Sys.SQL_DUMP;
	
	/**
	 * 插入
	 * @param dump
	 * @return
	 */
	public SqlDump insert(SqlDump dump) {		
		return (SqlDump) dao.insert(dump);
	}
	/**
	 * 更新
	 * @param dump
	 * @return
	 */
	public SqlDump update(SqlDump dump) {
		return (SqlDump)dao.update(dump);
	}

	/**
	 * 保存
	 * @param dump
	 * @return
	 */
	public SqlDump save(SqlDump dump){
		if(dump == null || dump.getId() == null){
			return null;
		}
		if(get(dump.getId())!=null){
			dump = update(dump);
		}else {
			dump = insert(dump);
		}
		return dump; 
	}
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public SqlDump get(Integer id) {
		Object object = dao.get(id);
		return object!=null?(SqlDump)object:null;
	}


	/**
	 * 删除
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id) {
		return dao.delete(id);
	}
	
	/**
	 * 预编译获取
	 * @param preSql 预编译语句	
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SqlDump> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql,params);
		return list!=null && list.size()>0?(List<SqlDump>)list:null;
	}

	/**
	 * 获取总数
	 * @param keyword
	 * @param username
	 * @param mode
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int total(String keyword,String username,String mode,
			String startTime,String endTime){
		Object[] metals = createSqlMetals(keyword,username, mode,startTime, endTime );
		String sql = "SELECT count(*) "+metals[0];
		List<Object> params = (List<Object>) metals[1];
		return dao.number(sql, params.toArray());
	}

	/**
	 * 获取内容列表
	 * @param username
	 * @param keyword
	 * @param mode
	 * @param startTime
	 * @param endTime
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SqlDump> query(String keyword,String username,String mode,
			String startTime,String endTime,
			int start,int limit ) {
		Object[] metals = createSqlMetals(keyword,username,mode, startTime, endTime );
		String sql = "SELECT * "+metals[0]+" order by create_time desc limit ?,?";
		List<Object> params = (List<Object>) metals[1];
		params.add(start);
		params.add(limit);
		return (List<SqlDump>) dao.query(sql, params.toArray());
	}
	
	
	/**
	 * 生成查询语句以及查询参数集合
	 * @param keyword
	 * @param username
	 * @param mode
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	private Object[] createSqlMetals(
			String keyword,
			String username,
			String mode,
			String startTime,String endTime){
		String sqlText = " FROM "+tableName + " WHERE " 
				+ "descri like ? "
				+ (username!=null && !username.equals("")?" and username=? ":"")
				+ (mode!=null && !mode.equals("")?" and mode=? ":"")
				+ (startTime.matches(I18n.i18n.get("DATE_REGEXT"))?" and create_time >=?":"")
				+ (endTime.matches(I18n.i18n.get("DATE_REGEXT"))?" and create_time <=?":""); 
		// 添加参数
		List<Object> params = new ArrayList<Object>();
		params.add("%"+keyword+"%");
		if(username!=null && !username.equals(""))
			params.add(username);
		if(mode!=null && !mode.equals(""))
			params.add(mode);
		if(startTime.matches(I18n.i18n.get("DATE_REGEXT")))
			params.add(startTime);
		if(endTime.matches(I18n.i18n.get("DATE_REGEXT")))
			params.add(endTime);
		return new Object[]{sqlText,params};
	}
	
}
