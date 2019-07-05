package com.minmeng.entity.ui;

import java.util.Date;

import com.j2mvc.framework.entity.BaseEntity;
import com.j2mvc.framework.mapping.Column;
import com.j2mvc.framework.mapping.Foreign;
import com.j2mvc.framework.mapping.PrimaryKey;
import com.j2mvc.framework.mapping.Table;

import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.Cat;

/**
 * @Description 导航
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-25
 */
@Table(DBConstants.Table.UI.NAV)
@PrimaryKey(autoIncrement = false)
public class Nav  extends BaseEntity{

	private static final long serialVersionUID = -1733428419617131655L;

	/** 主键 */
	@Column(name = "id",length = 32)
	private String id;	


	/** 分类 */
	@Foreign
	@Column(name = "cat_id",length = 32)
	private Cat cat;

	/** 名称 */
	@Column(name = "name",length = 32)
	private String name;
	
	/** 别名 */
	@Column(name = "alias",length = 32)
	private String alias;
	
	/** 链接地址 */
	@Column(name = "link",length = 255)
	private String link = "/";

	public final static String NAV_TYPE_TEXT = "1";
	public final static String NAV_TYPE_CAT = "2";
	/** 导航类型：1:文本，2：关联 */
	@Column(name = "nav_type",length = 2)
	private String navType = "1";

	/** 子导航深度，深度的显示决定于栏目分类下级分类深度 */
	@Column(name = "sub_depth",length = 11)
	private int subDepth = 0;

	/** 排序 */
	@Column(name = "sorter",length = 11)
	private int sorter = 99;

	/** 状态:0:未启用,1:启用 */
	@Column(name = "status",length = 1,notnull = true)
	private String status = "1";

	/** 创建时间 */
	@Column(name = "create_time")
	private String createTime = Constants.DATE_TIME_FORMAT.format(new Date());	

	/** 修改时间 */
	@Column(name = "update_time")
	private String updateTime = Constants.DATE_TIME_FORMAT.format(new Date());		


	public Nav(Cat cat, String name, String alias, String link, String navType,
			int subDepth, int sorter, String status) {
		super();
		this.cat = cat;
		this.name = name;
		this.alias = alias;
		this.link = link;
		this.navType = navType;
		this.subDepth = subDepth;
		this.sorter = sorter;
		this.status = status;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Nav() {
		super();
	}

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

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getNavType() {
		return navType;
	}

	public void setNavType(String navType) {
		this.navType = navType;
	}

	public int getSubDepth() {
		return subDepth;
	}

	public void setSubDepth(int subDepth) {
		this.subDepth = subDepth;
	}

	public int getSorter() {
		return sorter;
	}

	public void setSorter(int sorter) {
		this.sorter = sorter;
	}

	public Cat getCat() {
		return cat;
	}

	public void setCat(Cat cat) {
		this.cat = cat;
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
