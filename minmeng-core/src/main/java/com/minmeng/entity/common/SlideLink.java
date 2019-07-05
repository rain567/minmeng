package com.minmeng.entity.common;

import java.io.Serializable;

import com.j2mvc.framework.mapping.Column;
import com.j2mvc.framework.mapping.PrimaryKey;
import com.j2mvc.framework.mapping.Table;
import com.minmeng.entity.DBConstants;

/**
 * 
 * @description 滚动链接
 * @company 贵州沃尔达科技有限公司
 * 
 * @version 1.0 @date 2014-12-28 @author杨大江
 */
@Table(DBConstants.Table.Common.SLIDE_LINK)
@PrimaryKey(autoIncrement=false)
public class SlideLink implements Serializable{
	private static final long serialVersionUID = 2438854466225883326L;

	@Column(name="id",length=32,notnull=true)
	private String id;
	/**
	 * 文本
	 */
	@Column(name="text",length=255,notnull=true)
	private String text	;

	/**
	 * 网址
	 */
	@Column(name="url",length=255,notnull=true)
	private String url;

	/**
	 * 排序
	 */
	@Column(name="sorter",length=11,notnull=true)
	private Integer sorter;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}


	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getSorter() {
		return sorter;
	}

	public void setSorter(Integer sorter) {
		this.sorter = sorter;
	}

	
}
