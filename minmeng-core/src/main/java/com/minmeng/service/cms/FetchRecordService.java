package com.minmeng.service.cms;

import java.util.List;
import org.fixwork.framework.dao.DaoSupport;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.cms.FetchRecord;
import com.minmeng.service.CommonService;

/**
 * @description 抓取记录
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2019-1-3
 */
public class FetchRecordService extends CommonService{

	DaoSupport dao = new DaoSupport(FetchRecord.class);
	String tableName = DBConstants.Table.CMS.FETCH_RECORD;
	
	/**
	 * 插入
	 * @param FetchRecord
	 * @return
	 */
	public FetchRecord insert(FetchRecord fetchRecord) {		
		return (FetchRecord) dao.insert(fetchRecord);
	}
	/**
	 * 更新
	 * @param FetchRecord
	 * @return
	 */
	public FetchRecord update(FetchRecord fetchRecord) {
		return (FetchRecord)dao.update(fetchRecord);
	}

	/**
	 * 保存
	 * @param FetchRecord
	 * @return
	 */
	public FetchRecord save(FetchRecord fetchRecord) {
		if(fetchRecord == null || fetchRecord.getId() == null){
			return null;
		}
		if(get(fetchRecord.getId())!=null){
			fetchRecord = update(fetchRecord);
		}else {
			fetchRecord = insert(fetchRecord);
		}
		return fetchRecord; 
	}

	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public FetchRecord get(String id) {
		Object object = dao.get(id);
		return object!=null?(FetchRecord)object:null;
	}
	/**
	 * 获取
	 * @param url
	 * @return
	 */
	public FetchRecord getByUrl(String url) {
		String sql = "SELECT * FROM "+tableName + " WHERE url=?";
		Object object = dao.queryForObject(sql,new String[]{url});
		return object!=null?(FetchRecord)object:null;
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
	 * url已存在
	 * @param url
	 * @return
	 */
	public boolean exists(String url){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE url=?";
		return dao.number(sql,new String[]{url}) > 0;
	}
	/**
	 * url已存在
	 * @param url
	 * @param id
	 * @return
	 */
	public boolean existsName(String url,String id){
		String sql = "SELECT COUNT(*) FROM "+tableName + " WHERE url=? and id<>?";
		return dao.number(sql,new String[]{url,id}) > 0;
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
	public List<FetchRecord> query(String sql,Object [] params) {
		List<?> list =  dao.query(sql,params);
		return list!=null && list.size()>0?(List<FetchRecord>)list:null;
	}
}
