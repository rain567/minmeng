package com.minmeng.service.cms;

import java.util.List;

import com.j2mvc.framework.dao.DaoSupport;
import com.j2mvc.util.Utils;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.cms.ContentAttach;
import com.minmeng.entity.common.Attach;
import com.minmeng.service.CommonService;

/**
 * @description 内容
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-17
 */
public class ContentAttachService extends CommonService{

	DaoSupport dao = new DaoSupport(ContentAttach.class);
	String tableName = DBConstants.Table.CMS.CONTENT_ATTACH;
	
	/**
	 * 插入
	 * @param ca
	 * @return
	 */
	public ContentAttach insert(ContentAttach ca) {		
		return (ContentAttach) dao.insert(ca);
	}
	/**
	 * 更新
	 * @param content
	 * @return
	 */
	public ContentAttach update(ContentAttach ca) {
		return (ContentAttach)dao.update(ca);
	}

	/**
	 * 保存
	 * @param ca
	 * @return
	 */
	public ContentAttach save(ContentAttach ca) {
		if(ca == null){
			return null;
		}
		if(get(ca.getContentId(),ca.getAttachId()) == null){
			ca.setId(Utils.createId());
			ca = insert(ca);
		}
		return ca; 
	}

	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public ContentAttach get(String id) {
		Object object = dao.get(id);
		return object!=null?(ContentAttach)object:null;
	}
	
	/**
	 * 查询内容指定内容指定附件
	 * @param infoId
	 * @param attId
	 * @return
	 */
	public ContentAttach get(String infoId,String attId){
		String sql = "SELECT * FROM " + tableName +" WHERE content_id=? and attach_id=?";
		Object object =  dao.queryForObject(sql,new String[]{infoId,attId});
		return object!=null?(ContentAttach)object:null;
	}
	/**
	 * 清除指定内容附件
	 * @param infoId
	 * @return
	 */
	public int clear(String infoId){
		String sql = "DELETE FROM "+tableName + " WHERE content_id=?";
		return dao.execute(sql, new String[]{infoId});
	}
	
	/**
	 * 查询内容指定类型附件
	 * @param infoId
	 * @param attType
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Attach> query(String infoId,String attType){
		DaoSupport dao = new DaoSupport(Attach.class);
//		String sql = "SELECT a.* FROM "+DBConstants.Database.COMMON+"."+DBConstants.Table.Common.ATTACH + " as a,"
//				+ DBConstants.Database.CMS+"."+tableName +" as ca WHERE "
//						+ " ca.content_id=? and a.att_type=? and ca.attach_id=a.id";
//		
		String sql = "SELECT a.* FROM "+DBConstants.Table.Common.ATTACH + " as a,"
				+ tableName +" as ca WHERE "
						+ " ca.content_id=? and a.att_type=? and ca.attach_id=a.id";
		List<?> list =  dao.query(sql,new String[]{infoId,attType});
		return list!=null && list.size()>0?(List<Attach>)list:null;
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
	public List<ContentAttach> query(String sql,Object [] params) {
		List<?> list =  dao.query(sql,params);
		return list!=null && list.size()>0?(List<ContentAttach>)list:null;
	}
	
}
