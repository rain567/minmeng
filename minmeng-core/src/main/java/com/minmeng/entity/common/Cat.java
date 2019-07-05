package com.minmeng.entity.common;

import java.util.Date;
import java.util.List;

import com.j2mvc.framework.entity.BaseEntity;
import com.j2mvc.framework.mapping.Column;
import com.j2mvc.framework.mapping.JSONField;
import com.j2mvc.framework.mapping.PrimaryKey;
import com.j2mvc.framework.mapping.Table;
import com.j2mvc.util.StringUtils;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.service.common.CatService;

/**
 * 
 * 分类
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-3-10
 */
@Table(DBConstants.Table.Common.CAT)
@PrimaryKey(autoIncrement = false)
public class Cat extends BaseEntity{

	private static final long serialVersionUID = 1263613099758254265L;
	
	CatService service = new CatService();

	/** id */
	@Column(name = "id",length = 32)
	private String id;	
	/** 分类名称 */
	@Column(name = "name")
	private String 	name;	
	/** 别名 */
	@Column(name = "alias")
	private String 	alias;	
	/** 分类URI */
	@Column(name = "uri")
	private String uri;

	/** 分类类型：1:列表栏目，2：单页栏目 */
	public static final String CAT_TYPE_LIST = "1";
	public static final String CAT_TYPE_SINGLE = "2";
	@Column(name = "cat_type")
	private String catType;
	/** 列表显示样式：1:文字列表,2:图文列表,3:缩略图,4:缩略图文 */
	public static final String LIST_STYLE_TEXT = "1";
	public static final String LIST_STYLE_TEXT_IMG = "2";
	public static final String LIST_STYLE_THUMB = "3";
	public static final String LIST_STYLE_THUMB_TEXT = "4";
	@Column(name = "list_style")
	private String listStyle;
	
	/** 分类图片 */
	@Column(name = "icon")
	private String 	icon;				
	/** 状态 */
	@Column(name = "status")
	private String 	status = "1";	
	/** 排序 */
	@Column(name = "sorter")
	private Integer sorter = 999;

	/** 上级分类 */
	@Column(name = "parent_id")
	private String parentId;	

	/** 创建时间 */
	@Column(name = "create_time")
	private String createTime = Constants.DATE_TIME_FORMAT.format(new Date());	

	/** 修改时间 */
	@Column(name = "update_time")
	private String updateTime = Constants.DATE_TIME_FORMAT.format(new Date());		
	
	@JSONField("exists_children")
	private boolean existsChildren;

	private String text;
	public Cat() {
		super();
	}

	public Cat(String id) {
		super();
		this.id = id;
	}


	public String getListStyle() {
		return listStyle;
	}

	public void setListStyle(String listStyle) {
		this.listStyle = listStyle;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
		setExistsChildren(service.totalChildren(id)>0);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.text = name;
		this.name = name;
	}


	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}



	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public Integer getSorter() {
		return sorter;
	}

	public void setSorter(Integer sorter) {
		this.sorter = sorter;
	}

	public String getCatType() {
		return catType;
	}

	public void setCatType(String catType) {
		this.catType = catType;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public boolean isExistsChildren() {
		return existsChildren;
	}

	public void setExistsChildren(boolean existsChildren) {
		this.existsChildren = existsChildren;
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

	private List<Cat> children;
	private String state;

	public List<Cat> getChildren() {
		if(existsChildren && children == null){
			children = service.queryChidren(id);
		}
		return children;
	}

	public void setChildren(List<Cat> children) {
		this.children = children;
	}

	public String getState() {
		if(existsChildren){
			state = "closed";
		}
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}
	
	private String descri;
	public String getDescri() {
		if(descri == null){
			descri ="分类URI:"+uri+";"+(!StringUtils.isEmpty(alias)?"别名："+alias+";":"");
			if(CAT_TYPE_LIST.equals(catType)){
				descri +="类型：列表栏目;";
			}else if (CAT_TYPE_SINGLE.equals(catType)){
				descri +="类型：单页栏目;";
			}
			if(CAT_TYPE_LIST.equals(catType)){
				if(LIST_STYLE_TEXT.equals(listStyle)){
					descri +="列表显示样式：文字列表;";
				}
				else if(LIST_STYLE_TEXT_IMG.equals(listStyle)){
					descri +="列表显示样式：图文列表;";
				}
				else if(LIST_STYLE_THUMB.equals(listStyle)){
					descri +="列表显示样式：缩略图;";
				}
				else if(LIST_STYLE_THUMB_TEXT.equals(listStyle)){
					descri +="列表显示样式：缩略图文;";
				}
			}
			if("1".equals(status)){
				descri +="状态：启用";
			}else if("0".equals(status)){
				descri +="状态：未启用";
			}else{
				descri +="状态：未设置";
			}
	
			
		}
		return descri;
	}

	public void setDescri(String descri) {
		this.descri = descri;
	}
	
	
}
