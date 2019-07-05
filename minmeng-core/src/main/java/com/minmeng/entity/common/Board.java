package com.minmeng.entity.common;

import java.util.Date;

import com.j2mvc.framework.entity.BaseEntity;
import com.j2mvc.framework.mapping.Column;
import com.j2mvc.framework.mapping.PrimaryKey;
import com.j2mvc.framework.mapping.Table;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;

/**
 * 
 * 留言
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-3-11
 */
@Table(DBConstants.Table.Common.BOARD)
@PrimaryKey(autoIncrement = false)
public class Board extends BaseEntity{

	private static final long serialVersionUID = 5100465667519640186L;

	/** id */
	@Column(name = "id",length = 32)
	private String id;	

	/** 留言标题 */
	@Column(name = "title",length = 64)
	private String title;

	/** 留言内容 */
	@Column(name = "content")
	private String content;

	/** 手机号 */
	@Column(name = "mobile",length = 15)
	private String mobile;

	/** 姓名 */
	@Column(name = "name",length = 32)
	private String name;

	/** 创建时间 */
	@Column(name = "create_time")
	private String createTime = Constants.DATE_TIME_FORMAT.format(new Date());	

	/** 修改时间 */
	@Column(name = "update_time")
	private String updateTime = Constants.DATE_TIME_FORMAT.format(new Date());		

	/** 地址 */
	@Column(name = "address",length = 255)
	private String address;

	/** 传真/电话 */
	@Column(name = "fax",length = 64)
	private String fax;

	/** 备注 */
	@Column(name = "remark",length = 64)
	private String remark;

	/** 0:未公开，1：公开 */
	@Column(name = "status")
	private String status = "0";

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
