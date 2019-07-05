package com.minmeng.entity.cms;

import java.util.Date;

import com.j2mvc.framework.entity.BaseEntity;
import com.j2mvc.framework.mapping.Column;
import com.j2mvc.framework.mapping.Foreign;
import com.j2mvc.framework.mapping.PrimaryKey;
import com.j2mvc.framework.mapping.Table;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;

/**
 * 
 * 专题内容
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2019-1-3
 */
@Table(DBConstants.Table.CMS.FORUM_CONTENT)
@PrimaryKey(autoIncrement = false)
public class ForumContent extends BaseEntity{
	
	private static final long serialVersionUID = 7845437634866658081L;

	/** id */
	@Column(name = "id",length = 32)  
	private String id;	

	@Foreign
	/** 内容 */
	@Column(name = "content_id")
	private ContentInfo content;
	@Foreign
	/** 专题 */
	@Column(name = "forum_id")
	private Forum forum	;
	/** 状态:0:未启用,1:启用 */
	@Column(name = "")
	private String status = "1";
	private Integer sorter = 99;
	/** 创建时间 */
	@Column(name = "create_time")
	private String createTime = Constants.DATE_TIME_FORMAT.format(new Date());	

	/** 修改时间 */
	@Column(name = "update_time")
	private String updateTime = Constants.DATE_TIME_FORMAT.format(new Date());

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public ContentInfo getContent() {
		return content;
	}

	public void setContent(ContentInfo content) {
		this.content = content;
	}

	public Forum getForum() {
		return forum;
	}

	public void setForum(Forum forum) {
		this.forum = forum;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getSorter() {
		return sorter;
	}

	public void setSorter(Integer sorter) {
		this.sorter = sorter;
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


}
