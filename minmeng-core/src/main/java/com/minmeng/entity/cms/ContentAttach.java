package com.minmeng.entity.cms;

import com.j2mvc.framework.entity.BaseEntity;
import com.j2mvc.framework.mapping.Column;
import com.j2mvc.framework.mapping.PrimaryKey;
import com.j2mvc.framework.mapping.Table;

import com.minmeng.entity.DBConstants;


/**
 * 
 * 内容附件
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-3-11
 */
@Table(DBConstants.Table.CMS.CONTENT_ATTACH)
@PrimaryKey(autoIncrement = false)
public class ContentAttach extends BaseEntity{
	
	private static final long serialVersionUID = 2922004179844334105L;

	/** id */
	@Column(name = "id",length = 32)
	private String id;	

	/** 内容ID */
	@Column(name = "content_id",length = 32)
	private String contentId; 

	/** 附件ID */
	@Column(name = "attach_id",length = 32)
	private String attachId;

	public ContentAttach() {
	}

	public ContentAttach( String contentId, String attachId) {
		this.contentId = contentId;
		this.attachId = attachId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContentId() {
		return contentId;
	}

	public void setContentId(String contentId) {
		this.contentId = contentId;
	}

	public String getAttachId() {
		return attachId;
	}

	public void setAttachId(String attachId) {
		this.attachId = attachId;
	}
	
}
