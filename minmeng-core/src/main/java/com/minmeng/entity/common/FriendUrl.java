package com.minmeng.entity.common;

import java.io.Serializable;

import com.j2mvc.framework.mapping.Column;
import com.j2mvc.framework.mapping.PrimaryKey;
import com.j2mvc.framework.mapping.Table;

import com.minmeng.entity.DBConstants;

/**
 * 
 * @description 友情链接
 * @company 贵州沃尔达科技有限公司
 * 
 * @version 1.0 @date 2014-3-11 @author杨大江
 */
@Table(DBConstants.Table.Common.FRIEND_URL)
@PrimaryKey(autoIncrement=false)
public class FriendUrl implements Serializable{
	private static final long serialVersionUID = 2438854466225883326L;

	@Column(name="id",length=32,notnull=true)
	private String id;
	/**
	 * 网站名称
	 */
	@Column(name="sitename",length=64,notnull=true)
	private String sitename	;

	/**
	 * 网址
	 */
	@Column(name="url",length=64,notnull=true)
	private String url;

	/**
	 * logo
	 */
	@Column(name="logo",length=255,notnull=true)
	private String logo;


	/**
	 * 排序
	 */
	@Column(name="sorter",length=11,notnull=true)
	private Integer sorter;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSitename() {
		return sitename;
	}

	public void setSitename(String sitename) {
		this.sitename = sitename;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getSorter() {
		return sorter;
	}

	public void setSorter(Integer sorter) {
		this.sorter = sorter;
	}


	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}
	
}
