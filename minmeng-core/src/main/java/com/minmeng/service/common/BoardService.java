package com.minmeng.service.common;

import java.util.ArrayList;
import java.util.List;

import org.fixwork.framework.dao.DaoSupport;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.util.MD5;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Utils;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.Board;
import com.minmeng.service.CommonService;

/**
 * @description 留言板
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-3-11
 */
public class BoardService extends CommonService{

	DaoSupport dao = new DaoSupport(Board.class);
	String tableName = DBConstants.Table.Common.BOARD;
	
	/**
	 * 插入
	 * @param board
	 * @return
	 */
	public Board insert(Board board) {		
		return (Board) dao.insert(board);
	}
	/**
	 * 更新
	 * @param board
	 * @return
	 */
	public Board update(Board board) {
		return (Board)dao.update(board);
	}

	
	/**
	 * 保存
	 * @param board
	 * @return
	 */
	public Board save(Board board){
		if(board == null || board.getId() == null){
			return null;
		}
		if(get(board.getId())!=null){
			board = update(board);
		}else {
			board = insert(board);
		}
		return board; 
	}

	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public Board get(String id) {
		Object object = dao.get(id);
		return object!=null?(Board)object:null;
	}

	/**
	 * 设置公开状态
	 * @return
	 */
	public Integer setOpen(String id,String open) {
		String sql = "UPDATE "+tableName + " SET open=? WHERE id=?";
		return  dao.execute(sql, new Object[]{open,id});
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
	 * 计算总数
	 * @param sql
	 * @param params
	 * @return
	 */
	public Integer total(String sql,Object [] params){
		return dao.number(sql,params);
	}


	/**
	 * 预编译获取
	 * @param preSql 预编译语句	
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Board> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql,params);
		return list!=null && list.size()>0?(List<Board>)list:null;
	}

	/**
	 * 获取总数
	 * @param keyword
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int total(String keyword,
			String open,
			String startTime,String endTime){
		Object[] metals = createSqlMetals(keyword, open,startTime, endTime );
		String sql = "SELECT count(*) "+metals[0];
		List<Object> params = (List<Object>) metals[1];
		return dao.number(sql, params.toArray());
	}

	/**
	 * 获取列表
	 * @param keyword
	 * @param startTime
	 * @param endTime
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Board> query(String keyword,
			String open,
			String startTime,String endTime,
			int start,int limit ) {
		Object[] metals = createSqlMetals(keyword, open,startTime, endTime );
		String sql = "SELECT * "+metals[0]+" order by create_time desc limit ?,?";
		List<Object> params = (List<Object>) metals[1];
		params.add(start);
		params.add(limit);
		return (List<Board>) dao.query(sql, params.toArray());
	}
	
	
	/**
	 * 生成查询语句以及查询参数集合
	 * @param keyword
	 * @param open 公开状态
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	private Object[] createSqlMetals(String keyword,
			String open,
			String startTime,String endTime){
		String sqlText = " FROM "+tableName + " WHERE " 
				+ "(title like ? or content like ?) "
				+ (!StringUtils.isEmpty(open)?" and open=? ":"")
				+ (startTime!=null && startTime.matches(I18n.i18n.get("DATE_REGEXT"))?" and create_time >=?":"")
				+ (endTime!=null && endTime.matches(I18n.i18n.get("DATE_REGEXT"))?" and create_time <=?":"");
		// 添加参数
		List<Object> params = new ArrayList<Object>();
		keyword = keyword !=null?keyword:"";
		params.add("%"+keyword+"%");
		params.add("%"+keyword+"%");
		if(!StringUtils.isEmpty(open))
			params.add(open);
		if(startTime!=null && startTime.matches(I18n.i18n.get("DATE_REGEXT")))
			params.add(startTime);
		if(endTime!=null && endTime.matches(I18n.i18n.get("DATE_REGEXT")))
			params.add(endTime);
		return new Object[]{sqlText,params};
	}
	
}
