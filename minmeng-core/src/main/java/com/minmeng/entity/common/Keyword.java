package com.minmeng.entity.common;

import java.util.Date;



import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import org.fixwork.framework.entity.BaseEntity;
import org.fixwork.mapping.Column;
import org.fixwork.mapping.PrimaryKey;
import org.fixwork.mapping.Table;

/**
 * 关键字
 * 
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1
 * @Date 2014-3-10
 */
@Table(DBConstants.Table.Common.KEYWORD)
@PrimaryKey(autoIncrement = false)
public class Keyword extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2556614120387831623L;

	/** id */
	@Column(name = "id", length = 50, notnull = true)
	private String id;

	/** 词语 */
	@Column(name = "keyword")
	private String keyword;
	/** hot：热搜recommend:推荐history:用户搜索历史 */
	@Column(name = "tag")
	private String tag;
	/** 序号 */
	@Column(name = "sorter")
	private Integer sorter = 999;
	/** 查询次数 */
	@Column(name = "qcount")
	private Integer qcount = 0;

	/** 创建时间 */
	@Column(name = "create_time", notnull = true)
	private String createTime = Constants.DATE_TIME_FORMAT.format(new Date());

	/** 变更时间 */
	@Column(name = "update_time", notnull = true)
	private String updateTime = Constants.DATE_TIME_FORMAT.format(new Date());

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}


	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
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


	public Integer getQcount() {
		return qcount;
	}

	public void setQcount(Integer qcount) {
		this.qcount = qcount;
	}


}
