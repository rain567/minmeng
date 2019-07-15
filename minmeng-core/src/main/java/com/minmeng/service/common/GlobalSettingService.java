package com.minmeng.service.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.fixwork.framework.dao.DaoSupport;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.GlobalSetting;
import com.minmeng.service.CommonService;


/**
 * 全局设置
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-17
 */
public class GlobalSettingService extends CommonService{

	DaoSupport dao = new DaoSupport(GlobalSetting.class);
	String tableName = DBConstants.Table.Common.GLOBAL_SETTING;

	/**
	 * 插入
	 * @param GlobalSetting
	 * @return
	 */
	private GlobalSetting insert(GlobalSetting GlobalSetting) {		
		return (GlobalSetting) dao.insert(GlobalSetting);
	}
	
	/**
	 * 更新
	 * @param GlobalSetting
	 * @return
	 */
	private GlobalSetting update(GlobalSetting GlobalSetting) {
		return (GlobalSetting)dao.update(GlobalSetting);
	}

	/**
	 * 保存
	 * @param GlobalSetting
	 * @return
	 */
	public GlobalSetting save(GlobalSetting GlobalSetting){
		if(GlobalSetting == null)
			return null;
		if(get(GlobalSetting.getId())!=null){
			// 更新
			GlobalSetting = update(GlobalSetting);
		}else{
			// 新增
			GlobalSetting = insert(GlobalSetting);
		}
		return GlobalSetting;
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
	public GlobalSetting get(String id) {
		Object object =  dao.get(id);
		return object!=null?(GlobalSetting)object:null;
	}

	/**
	 * 获取
	 * @return
	 */
	public GlobalSetting get() {
		Object object =  dao.queryForObject("SELECT * FROM "+tableName+" limit 1");
		return object!=null?(GlobalSetting) object:null;
	}
	
	/**
	 * 遍历全局设置，并存入Map
	 * @return
	 */
	public Map<String,String> query(){
		Map<String,String> result = new HashMap<String,String>();
		String sql = "SELECT * FROM "+tableName ;
		
		List<?> object = dao.query(sql);
		@SuppressWarnings("unchecked")
		List<GlobalSetting> settings = object!=null?(List<GlobalSetting>)object:null;
		if(settings!=null)
		for(GlobalSetting setting : settings){
			result.put(setting.getId(),setting.getValue());
		}
		return result;
	}
	
	/**
	 * 获取
	 * @param preSql 预编译查询语句
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<GlobalSetting> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql, params);
		return list!=null?(List<GlobalSetting>) list:null;
	}
}
