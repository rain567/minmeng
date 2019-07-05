package com.minmeng.entity.cms;

import java.util.Date;

import com.j2mvc.framework.entity.BaseEntity;
import com.j2mvc.framework.mapping.Column;
import com.j2mvc.framework.mapping.PrimaryKey;
import com.j2mvc.framework.mapping.Table;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;

/**
 * 
 * 抓取内容
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2019-1-3
 */
@Table(DBConstants.Table.CMS.FETCH_RECORD)
@PrimaryKey(autoIncrement = false)
public class FetchRecord extends BaseEntity{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4912816004635549082L;

	/** id */
	@Column(name = "id",length = 32)  
	private String id;	

	/** list:列表，detail:详情 */
	@Column(name = "fetch_type")
	private String fetchType;	
	/** 链接地址 */
	@Column(name = "url")
	private String url;	

	/** 创建时间 */
	@Column(name = "create_time")
	private String createTime = Constants.DATE_TIME_FORMAT.format(new Date());

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFetchType() {
		return fetchType;
	}

	public void setFetchType(String fetchType) {
		this.fetchType = fetchType;
	}


	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}	

}
