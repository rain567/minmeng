package com.minmeng.service.common;

import java.util.List;

import org.fixwork.framework.dao.DaoSupport;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.util.MD5;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Utils;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.SlideLink;

/**
 * 滚动链接
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-28
 */
public class SlideLinkService {

	DaoSupport dao = new DaoSupport(SlideLink.class);
	String tableName = DBConstants.Table.Common.SLIDE_LINK;

	/**
	 * 插入
	 * @param slideLink
	 * @return
	 */
	private SlideLink insert(SlideLink slideLink) {		
		return (SlideLink) dao.insert(slideLink);
	}
	
	/**
	 * 更新
	 * @param slideLink
	 * @return
	 */
	private SlideLink update(SlideLink slideLink) {
		return (SlideLink)dao.update(slideLink);
	}

	/**
	 * 保存
	 * @param slideLink
	 * @return
	 */
	public SlideLink save(SlideLink slideLink){
		if(slideLink == null)
			return null;
		if(get(slideLink.getId())!=null){
			// 更新
			slideLink = update(slideLink);
		}else{
			// 新增
			slideLink = insert(slideLink);
		}
		return slideLink;
	}
	
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public SlideLink get(String id) {
		Object object =  dao.get(id);
		return object!=null?(SlideLink)object:null;
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
	 * 清除指定模块
	 * @param moduleId
	 */
	public void clear(String moduleId){
		String sql = "DELETE FROM "+tableName + " WHERE module_id=?";
		dao.execute(sql, new String[]{moduleId});
	}
	/**
	 * 获取
	 * @param preSql 预编译查询语句
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SlideLink> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql, params);
		return list!=null?(List<SlideLink>) list:null;
	}
	/**
	 * 查询站点的滚动链接
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SlideLink> query() {
		String sql = "SELECT * FROM "+tableName + "  order by sorter";
		List<?> list =  dao.query(sql);
		return list!=null?(List<SlideLink>) list:null;
	}
}
