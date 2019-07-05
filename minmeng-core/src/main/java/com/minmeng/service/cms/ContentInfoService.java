package com.minmeng.service.cms;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.j2mvc.framework.dao.DaoSupport;
import com.j2mvc.framework.i18n.I18n;
import com.j2mvc.util.StringUtils;
import com.j2mvc.util.Utils;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.cms.ContentInfo;
import com.minmeng.service.CommonService;
import com.minmeng.service.common.CatService;

/**
 * @description 内容
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-3-11
 */
public class ContentInfoService extends CommonService{

	DaoSupport dao = new DaoSupport(ContentInfo.class);
	String tableName = DBConstants.Table.CMS.CONTENT_INFO;
	CatService catService = new CatService();
	
	/**
	 * 插入
	 * @param content
	 * @return
	 */
	public ContentInfo insert(ContentInfo content) {		
		return (ContentInfo) dao.insert(content);
	}
	/**
	 * 更新
	 * @param content
	 * @return
	 */
	public ContentInfo update(ContentInfo content) {
		return (ContentInfo)dao.update(content);
	}

	/**
	 * 保存
	 * @param content
	 * @return
	 */
	public ContentInfo save(ContentInfo info) {
		if(info == null || info.getId() == null){
			return null;
		}
		if(get(info.getId())!=null){
			info.setUpdateTime(Constants.DATE_TIME_FORMAT.format(new Date()));
			info = update(info);
		}else {
			info = insert(info);
		}
		return info; 
	}

	/**
	 * 保存
	 * @param content
	 * @return
	 */
	public ContentInfo saveForCat(ContentInfo info) {
		if(info == null || info.getCat() == null){
			return null;
		}
		String catId = info.getCat().getId();
		ContentInfo oldInfo = getByCat(catId);
		if(oldInfo!=null){
			info.setId(oldInfo.getId());
			info.setUpdateTime(Constants.DATE_TIME_FORMAT.format(new Date()));
			info = update(info);
		}else {
			info.setId(Utils.createId());
			info = insert(info);
		}
		return info; 
	}
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public ContentInfo get(String id) {
		Object object = dao.get(id);
		return object!=null?(ContentInfo)object:null;
	}
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public ContentInfo getByTitle(String title) {
		String sql = "SELECT * FROM "+tableName + " WHERE title=?";
		Object object = dao.queryForObject(sql,new String[]{title});
		return object!=null?(ContentInfo)object:null;
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
	 * @param catId
	 * @return
	 */
	public ContentInfo getByCat(String catId) {
		String sql = "SELECT * FROM "+tableName + " WHERE cat_id=?";
		Object object = dao.queryForObject(sql,new String[]{catId});
		return object!=null?(ContentInfo)object:null;
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
	 * 设置推荐类型
	 * @return
	 */
	public Integer setRecom(String id,String recom) {
		String sql = "UPDATE "+tableName + " SET recom=? WHERE id=?";
		return  dao.execute(sql, new String[]{recom,id});
	}
	/**
	 * 标题已存在
	 * @param title
	 * @return
	 */
	public boolean exists(String title){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE title=?";
		return dao.number(sql,new String[]{title}) > 0;
	}
	/**
	 * 标题已存在
	 * @param title
	 * @param id
	 * @return
	 */
	public boolean existsTitle(String title,String id){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE title=? and id<>?";
		return dao.number(sql,new String[]{title,id}) > 0;
	}

	/**
	 * 副标题已存在
	 * @param subtitle
	 * @param id
	 * @return
	 */
	public boolean existsSubtitle(String subtitle,String id){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE subtitle=? and id<>?";
		return dao.number(sql,new String[]{subtitle,id}) > 0;
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
	public List<ContentInfo> query(String sql,Object [] params) {
		List<?> list =  dao.query(sql,params);
		return list!=null && list.size()>0?(List<ContentInfo>)list:null;
	}
	
	/**
	 * 获取总数
	 * @param catId
	 * @param keyword
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int total(String catId,String keyword,
			String startTime,String endTime){
		Object[] metals = createSqlMetals(catId,keyword, startTime, endTime );
		String sql = "SELECT count(*) "+metals[0];
		List<Object> params = (List<Object>) metals[1];
		return dao.number(sql, params.toArray());
	}

	/**
	 * 获取内容列表
	 * @param catId
	 * @param keyword
	 * @param startTime
	 * @param endTime
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ContentInfo> query(String catId,String recom,int limit ) {
		String sql = "SELECT * FROM "+tableName+"" +
				" WHERE 1=1 " ;
		// 所有子分类
		List<String> cidList = catService.getChidren(catId, null);
		String cid_text = "";
		if (!StringUtils.isEmpty(catId)) {
			cid_text = " cat_id='" + catId + "'";
			if (cidList != null)
				for (int i = 0; i < cidList.size(); i++) {
					String cid = cidList.get(i);
					cid_text = cid_text + " or cat_id='" + cid + "'";
				}
			if (!cid_text.equals(""))
				sql += " and (" + cid_text + ")";
		}
		sql += (recom!=null && !recom.equals("")? " and recom=? ":"") +
					" order by create_time desc limit ?";
		Object[] params = null;
		if(recom !=null && !recom.equals("")){
			params = new Object[]{recom,limit};
		}else{
			params = new Object[]{limit};
		}
		return (List<ContentInfo>) dao.query(sql, params);
	}

	/**
	 * 获取内容列表
	 * @param catId
	 * @param keyword
	 * @param startTime
	 * @param endTime
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ContentInfo> queryByImage(String catId,String recom,int limit) {
		String sql = "SELECT * FROM "+tableName+"" +
				" WHERE cat_id=? " +
				(recom!=null && !recom.equals("")? " and recom=? ":"") +
				" order by create_time desc limit ?";
		Object[] params = null;
		if(recom !=null && !recom.equals("")){
			params = new Object[]{catId,recom,limit};
		}else{
			params = new Object[]{catId,limit};
		}
		return (List<ContentInfo>) dao.query(sql, params);
	}
	/**
	 * 获取内容列表
	 * @param catId
	 * @param keyword
	 * @param startTime
	 * @param endTime
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ContentInfo> query(String catId,String keyword,
			String startTime,String endTime,
			int start,int limit ) {
		Object[] metals = createSqlMetals(catId,keyword, startTime, endTime );
		String sql = "SELECT * "+metals[0]+" order by create_time desc limit ?,?";
		List<Object> params = (List<Object>) metals[1];
		params.add(start);
		params.add(limit);
		return (List<ContentInfo>) dao.query(sql, params.toArray());
	}
	
	
	/**
	 * 生成查询语句以及查询参数集合
	 * @param keyword
	 * @param startTime
	 * @param endTime
	 * @param catId
	 * @return
	 */
	private Object[] createSqlMetals(
			String catId,String keyword,
			String startTime,String endTime){
		keyword = !StringUtils.isEmpty(keyword)?keyword:"";
		String sqlText = " FROM "+tableName + " WHERE " 
				+ "(title like ? or subtitle like ?) "
				+ (startTime!=null&&startTime.matches(I18n.i18n.get("DATE_REGEXT"))?" and create_time >=?":"")
				+ (endTime!=null&&endTime.matches(I18n.i18n.get("DATE_REGEXT"))?" and create_time <=?":""); 
		List<String> cidList = catService.getChidren(catId, null);
		// 所有子分类
		String cid_text = "";
		if(catId !=null && !catId.equals("")){
			cid_text = " cat_id='" + catId+"'";
			if(cidList!=null)
			for (int i = 0; i < cidList.size(); i++){
				String cid = cidList.get(i);
				cid_text = cid_text + " or cat_id='" + cid+"'";
			}
			if(!cid_text.equals(""))
				sqlText += " and ("+cid_text+")";
		}
		// 添加参数
		List<Object> params = new ArrayList<Object>();
		params.add("%"+keyword+"%");
		params.add("%"+keyword+"%");
		if(endTime!=null&&startTime.matches(I18n.i18n.get("DATE_REGEXT")))
			params.add(startTime);
		if(endTime!=null&&endTime.matches(I18n.i18n.get("DATE_REGEXT")))
			params.add(endTime);
		return new Object[]{sqlText,params};
	}
}
