package com.minmeng.entity.ui;

import java.util.Date;

import com.j2mvc.framework.entity.BaseEntity;
import com.j2mvc.framework.mapping.Column;
import com.j2mvc.framework.mapping.Foreign;
import com.j2mvc.framework.mapping.PrimaryKey;
import com.j2mvc.framework.mapping.Table;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;

/**
 * @Description 页面控件
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2018-12-26
 */
@Table(DBConstants.Table.UI.PAGE_VIEW)
@PrimaryKey(autoIncrement = false)
public class PageView  extends BaseEntity{

	private static final long serialVersionUID = -1733421219123131655L;

	/** 主键 */
	@Column(name = "id",length = 32)
	private String id;	

	/** 页面ID */
	@Column(name = "page_id",length = 32)
	private String pageId;

	/** 分类 */
	@Foreign
	@Column(name = "view_id",length = 32)
	private View view;

	/** 排序 */
	@Column(name = "sorter")
	private Integer sorter = 999;

	/** 状态 */
	@Column(name = "status")
	private String status = "1";

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

	public String getPageId() {
		return pageId;
	}

	public void setPageId(String pageId) {
		this.pageId = pageId;
	}

	public View getView() {
		return view;
	}

	public void setView(View view) {
		this.view = view;
	}

	public Integer getSorter() {
		return sorter;
	}

	public void setSorter(Integer sorter) {
		this.sorter = sorter;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
