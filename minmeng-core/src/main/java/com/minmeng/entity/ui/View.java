package com.minmeng.entity.ui;

import java.util.Date;
import java.util.List;



import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.service.ui.ViewItemService;
import com.minmeng.service.ui.ViewService;
import org.fixwork.framework.entity.BaseEntity;
import org.fixwork.mapping.Column;
import org.fixwork.mapping.PrimaryKey;
import org.fixwork.mapping.Table;
import org.fixwork.util.StringUtils;

/**
 * @Description 控件
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2018-12-26
 */
@Table(DBConstants.Table.UI.VIEW)
@PrimaryKey(autoIncrement = false)
public class View  extends BaseEntity {

	private static final long serialVersionUID = -17334284191232355L;

	/** 主键 */
	@Column(name = "id",length = 32)
	private String id;	
	/** 识别名称 */
	@Column(name = "name")
	private String name;
	/** 类型：0:容器，1：关联分类，2：自定义内容 */
	public static final String MODE_CONTAINER = "0";
	public static final String MODE_CAT = "1";
	public static final String MODE_CONTENT = "2";
	@Column(name = "mode")
	private String mode;	
	/** 样式类型 */
	@Column(name = "style")
	private String style;	
	/** 最大条目数 */
	@Column(name = "max_items")
	private Integer maxItems = 5;
	/** 链接地址 */
	@Column(name = "link")
	private String link;
	/** 父层组件ID */
	@Column(name = "parent_id")
	private String parentId;
	private String parentName;
	
	/** 当前控件为子控件时使用，输出的方式 */
	public static final String OUT_MODE_BEFORE = "before";
	public static final String OUT_MODE_AFTER = "after";
	@Column(name = "out_mode")
	private String outMode;
	/** 排序 */
	@Column(name = "sorter")
	private Integer sorter= 99;
	
	/** 状态:1:启用,0:未启用 */
	@Column(name = "status")
	private String status="1";

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
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getStyle() {
		return style;
	}
	public void setStyle(String style) {
		this.style = style;
	}
	public Integer getMaxItems() {
		return maxItems;
	}
	public void setMaxItems(Integer maxItems) {
		this.maxItems = maxItems;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getOutMode() {
		return outMode;
	}
	public void setOutMode(String outMode) {
		this.outMode = outMode;
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
	public String getParentName() {
		if(parentName == null &&!StringUtils.isEmpty(parentId)){
			ViewService service = new ViewService();
			parentName = service.parents(parentId);
		}
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	ViewService service = new ViewService();
	private String text;
	private List<View> children;

	public String getText() {
		if(text == null)
			text = name;
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public List<View> getChildren() {
		if(children == null){
			children = service.queryChidren(id);
		}
		return children;
	}
	public void setChildren(List<View> children) {
		this.children = children;
	}
	private Integer itemCount = null;

	public Integer getItemCount() {
		if(itemCount == null){
			ViewItemService service = new ViewItemService();
			itemCount = service.total(id);
		}
		return itemCount;
	}
	public void setItemCount(Integer itemCount) {
		this.itemCount = itemCount;
	}
	

}
