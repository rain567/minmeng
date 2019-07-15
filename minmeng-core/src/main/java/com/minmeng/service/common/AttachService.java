package com.minmeng.service.common;

import java.util.List;

import org.fixwork.framework.dao.DaoSupport;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.util.MD5;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Utils;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.Attach;
import com.minmeng.service.CommonService;

/**
 * @description 附件
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-17
 */
public class AttachService extends CommonService{

	DaoSupport dao = new DaoSupport(Attach.class);
	String tableName = DBConstants.Table.Common.ATTACH;
	
	/**
	 * 插入
	 * @param attach
	 * @return
	 */
	public Attach insert(Attach attach) {		
		return (Attach) dao.insert(attach);
	}
	/**
	 * 更新
	 * @param attach
	 * @return
	 */
	public Attach update(Attach attach) {
		return (Attach)dao.update(attach);
	}

	/**
	 * 保存
	 * @param attach
	 * @return
	 */
	public Attach save(Attach attach){
		if(attach == null)
			return null;
		if(get(attach.getId())!=null){
			// 更新
			attach = update(attach);
		}else{
			// 新增
			attach = insert(attach);
		}
		return attach;
	}

	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public Attach get(String id) {
		Object object = dao.get(id);
		return object!=null?(Attach)object:null;
	}

	/**
	 * 预编译获取
	 * @param preSql 预编译语句	
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Attach> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql,params);
		return list!=null && list.size()>0?(List<Attach>)list:null;
	}
	/**
	 * 根据URL查询
	 * @param files
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Attach> query(String[] urls){
		List<Attach> list = null;
		String idText = "";
		for (int i = 0; i < urls.length; i++) {
			String url = urls[i];
			if(url!=null && !url.equals("")){
				String attId = MD5.md5(url);
				idText += (!idText.equals("")?" or ":"") +" id='"+attId+"'";
			}
		}
		if(!idText.equals("")){
			List<?> object = dao.query("SELECT * FROM "+tableName+" WHERE "+idText);
			list =  object!=null && object.size()>0?(List<Attach>)object:null;
		}
		return list;
	}
}
