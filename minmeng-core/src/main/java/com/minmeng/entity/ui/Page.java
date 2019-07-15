package com.minmeng.entity.ui;

import java.util.Date;




import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import org.fixwork.framework.entity.BaseEntity;
import org.fixwork.mapping.Column;
import org.fixwork.mapping.PrimaryKey;
import org.fixwork.mapping.Table;

/**
 * @Description 页面
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2018-12-18
 */
@Table(DBConstants.Table.UI.PAGE)
@PrimaryKey(autoIncrement = false)
public class Page  extends BaseEntity {

	private static final long serialVersionUID = -1733428419617131655L;

	/** 主键 */
	@Column(name = "id",length = 32)
	private String id;	

	public static final String NAME_INDEX="index";
	public static final String NAME_LIST="list";
	public static final String NAME_DETAIL="detail";
	/** 页面名称 */
	@Column(name = "name",length = 32)
	private String name;

	/** 标题 */
	@Column(name = "title",length = 255)
	private String title;
	
	/** 页面关键字 */
	@Column(name = "keywords",length = 255)
	private String keywords;

	/** 页面说明 */
	@Column(name = "descri",length = 255)
	private String descri;

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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getDescri() {
		return descri;
	}

	public void setDescri(String descri) {
		this.descri = descri;
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
