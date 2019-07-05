package com.minmeng.service.common;

import java.util.List;

import com.j2mvc.framework.dao.DaoSupport;

import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.FriendUrl;
import com.minmeng.service.CommonService;



/**
 * 友情链接
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-17
 */
public class FriendUrlService  extends CommonService{

	DaoSupport dao = new DaoSupport(FriendUrl.class);
	String tableName = DBConstants.Table.Common.FRIEND_URL;

	/**
	 * 插入
	 * @param friendUrl
	 * @return
	 */
	private FriendUrl insert(FriendUrl friendUrl) {		
		return (FriendUrl) dao.insert(friendUrl);
	}
	
	/**
	 * 更新
	 * @param friendUrl
	 * @return
	 */
	private FriendUrl update(FriendUrl friendUrl) {
		return (FriendUrl)dao.update(friendUrl);
	}

	/**
	 * 保存
	 * @param friendUrl
	 * @return
	 */
	public FriendUrl save(FriendUrl friendUrl){
		if(friendUrl == null)
			return null;
		if(get(friendUrl.getId())!=null){
			// 更新
			friendUrl = update(friendUrl);
		}else{
			// 新增
			friendUrl = insert(friendUrl);
		}
		return friendUrl;
	}
	
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public FriendUrl get(String id) {
		Object object =  dao.get(id);
		return object!=null?(FriendUrl)object:null;
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
	 * @param preSql 预编译查询语句
	 * @param params 参数数组
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<FriendUrl> query(String preSql,Object [] params) {
		List<?> list =  dao.query(preSql, params);
		return list!=null?(List<FriendUrl>) list:null;
	}
	/**
	 * 查询站点的友情链接
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<FriendUrl> query() {
		String sql = "SELECT * FROM "+tableName + "  order by sorter";
		List<?> list =  dao.query(sql);
		return list!=null?(List<FriendUrl>) list:null;
	}
}
