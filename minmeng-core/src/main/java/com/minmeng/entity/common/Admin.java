package com.minmeng.entity.common;

import com.j2mvc.framework.entity.BaseEntity;
import com.j2mvc.framework.mapping.Column;
import com.j2mvc.framework.mapping.PrimaryKey;
import com.j2mvc.framework.mapping.Table;

import com.minmeng.entity.DBConstants;

/**
 * 系统管理员
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-3-10
 */
@Table(DBConstants.Table.Common.ADMIN)
@PrimaryKey(autoIncrement = false)
public class Admin extends BaseEntity{
	private static final long serialVersionUID = 3819068356779230024L;

	/** id */
	@Column(name = "id",length = 50,notnull = true)
	private String id;	
	 
	/** 用户名 */
	@Column(name = "username",length = 50,notnull = true)
	private String username;			

	/** 密码 */
	@Column(name = "password",length = 50,notnull = true)
	private String password;				

	/** 手机号 */ 
	@Column(name = "mobile",length = 50,notnull = true)
	private String mobile;				

	/** 状态 */
	@Column(name = "status",length = 1,notnull = true)
	private String status;

	/** 会话ID,用户退出时清除 */
	@Column(name="sessionid",length=255,notnull=true)	
	private String sessionid;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}



	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSessionid() {
		return sessionid;
	}

	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	
}
