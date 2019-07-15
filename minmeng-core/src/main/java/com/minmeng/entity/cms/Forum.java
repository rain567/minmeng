package com.minmeng.entity.cms;

import java.util.Date;



import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import org.fixwork.framework.entity.BaseEntity;
import org.fixwork.mapping.Column;
import org.fixwork.mapping.PrimaryKey;
import org.fixwork.mapping.Table;

/**
 * 
 * 专题
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2019-1-3
 */
@Table(DBConstants.Table.CMS.FORUM)
@PrimaryKey(autoIncrement = false)
public class Forum extends BaseEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1533962228467439360L;

	/** id */
	@Column(name = "id",length = 32)
	private String id;	

	/** 名称 */
	@Column(name = "")
	private String name;				
	/** URI */
	@Column(name = "")
	private String uri;		
	/** 专题图片 */
	@Column(name = "")
	private String image;	
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
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
