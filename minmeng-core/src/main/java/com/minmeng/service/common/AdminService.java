package com.minmeng.service.common;

import java.util.List;



import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.Admin;
import com.minmeng.service.CommonService;
import org.fixwork.framework.dao.DaoSupport;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Utils;

/**
 * 
 * 系统管理员服务
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-17
 */
public class AdminService extends CommonService{

	DaoSupport dao = new DaoSupport(Admin.class);
	String tableName = DBConstants.Table.Common.ADMIN;
	
	/**
	 * 插入
	 * @param admin
	 * @return
	 */
	public Admin insert(Admin admin) {		
		return (Admin) dao.insert(admin);
	}
	/**
	 * 更新
	 * @param admin
	 * @return
	 */
	public Admin update(Admin admin) {
		return (Admin)dao.update(admin);
	}

	public Admin get(String id){
		Object object = dao.get(id);
		return object!=null?(Admin)object:null;
	}
	
	/**
	 * 获取
	 * @param mobile
	 * @param id
	 * @return
	 */
	public Admin getByMobile(String mobile,String id) {
		String preSql = "SELECT * FROM " + tableName + " WHERE mobile=? and id=?";
		List<?> list =  dao.query(preSql, new String[]{mobile,id});
		if(list.size()>0)
			return (Admin) list.get(0);
		else
			return null;
	}
	/**
	 * 查看用户名是否存在
	 * @param username
	 * @return
	 */
	public boolean existsUsername(String username) {
		String preSql = "SELECT count(*) FROM " + tableName + " WHERE username=?";
		return dao.number(preSql, new String[]{username})>0;
	}

	/**
	 * 查看手机号是否存在
	 * @param mobile
	 * @return
	 */
	public boolean existsMobile(String mobile) {
		String preSql = "SELECT count(*) FROM " + tableName + " WHERE mobile=?";
		return dao.number(preSql, new String[]{mobile})>0;
	}


	/**
	 * 登陆
	 * @param username
	 * @param password
	 * @param domain
	 * @return
	 */
	public Admin login(String username,String password,String sitename){
		if(username.equals("") || password.equals(""))
			return null;
		String sql = "SELECT * FROM "+ tableName
				+ " WHERE (username=? or mobile=?) and "
				+ "password=MD5(?)";
		Object object = dao.queryForObject(sql,new String[]{username,username,password});
		Admin admin = object!=null?(Admin)object:null;
		Admin sessionAdmin = null;
		if(admin!=null){
			String sessionid = Utils.createSessionid(username, !StringUtils.isEmpty(sitename)?sitename:"admin.bbs.worda.cn",password);
			sessionAdmin = setSessionAdmin(admin, password);
			// 保存sessionid
			sessionAdmin.setSessionid(sessionid);
			saveSessionid(sessionid,admin.getId());
		}
		return sessionAdmin;
	}
	/**
	 * 根据sessionid获取
	 * @param sessionid
	 * @return
	 */
	public Admin getBySessionid(String sessionid){
		if(!(sessionid!=null && !sessionid.trim().equals("")))
			return null;
		String sql = "SELECT * FROM "+ tableName  + " WHERE sessionid=? ";
		Object object = dao.queryForObject(sql,new String[]{sessionid});
		Admin admin = object!=null?(Admin)object:null;
		Admin sessionAdmin = null;
		if(admin!=null){
			String password = Utils.getPassword(sessionid);
			sessionAdmin = setSessionAdmin(admin, password);
		}
		return sessionAdmin;
	}
	/**
	 * 设置会话用户变量
	 * @param admin
	 * @param password
	 * @return
	 */
	private Admin setSessionAdmin(Admin admin,String password){
		Admin sessionAdmin = new Admin();
		sessionAdmin.setId(admin.getId());
		sessionAdmin.setUsername(admin.getUsername());
		sessionAdmin.setStatus(admin.getStatus());
		return sessionAdmin;
	}
	
	/**
	 * 将sessionkey保存到用户表
	 * @param sessionKey
	 * @param Superid
	 * @return
	 */
	public boolean saveSessionid(String sessionid,String Superid){
		String updateSql = "update "+tableName+" set sessionid=? WHERE id=?";
		return dao.update(updateSql, new String []{sessionid,Superid})>0;
	}
	/**
	 * 清除Sessionid
	 * @param id 可以是用户ID，也可是会话ID
	 * @return
	 */
	public boolean clearSessionid(String id){
		String updateSql = "update "+tableName+" set sessionid='' WHERE id=? or sessionid=?";
		return dao.update(updateSql, new String []{id,id})>0;
	}
}
