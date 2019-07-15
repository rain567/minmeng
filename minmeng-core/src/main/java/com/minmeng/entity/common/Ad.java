package com.minmeng.entity.common;

import java.util.Date;



import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import org.fixwork.framework.entity.BaseEntity;
import org.fixwork.mapping.Column;
import org.fixwork.mapping.PrimaryKey;
import org.fixwork.mapping.Table;

/**
 * 推送消息
 * @Company 贵州万嘉
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2015-5-11
 */
@Table(DBConstants.Table.Common.AD)
@PrimaryKey(autoIncrement = false)
public class Ad extends BaseEntity {

	private static final long serialVersionUID = -2248258335307969728L;

	/** id */
	@Column(name = "id",length = 32,notnull = true)
	private String id;	

	public static final String POS_INDEX_ROTATION = "index_rotation";
	public static final String POS_PAGE_BANNER = "page_banner";
	public static final String POS_MOBILE_INDEX_ROTATION = "mobile_index_rotation";
	public static final String POS_MOBILE_BANNER = "mobile_page_banner";
	/** 位置:index_rotation:首页轮播，index_banner:首页横幅广告 */
	@Column(name = "position")
	private String position;			
	/** 图片 */
	@Column(name = "image")
	private String image;				
	/** 链接地址 */
	@Column(name = "href")
	private String href;		
	/** 广告内容 */
	@Column(name = "text")
	private String text;						
	/** 价格 */
	@Column(name = "price")
	private Double price = 0.0;
	/** descri */
	@Column(name = "descri")
	private String descri;

	/** 状态:0:未启用,1:启用' */
	private String status = "1";
	/** 排序 */
	@Column(name = "sorter")
	private Integer sorter = 999;


	/** 创建时间 */
	@Column(name="create_time",notnull=true)
	private String createTime = Constants.DATE_TIME_FORMAT.format(new Date());	

	/** 变更时间 */
	@Column(name="update_time",notnull=true)
	private String updateTime = Constants.DATE_TIME_FORMAT.format(new Date());

	/** 生效时间 */
	@Column(name="effect_time",notnull=true)
	private String effectTime = Constants.DATE_TIME_FORMAT.format(new Date());

	/** 生效时间 */
	@Column(name="expire_time",notnull=true)
	private String expireTime = Constants.DATE_TIME_FORMAT.format(new Date());

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getDescri() {
		return descri;
	}

	public void setDescri(String descri) {
		this.descri = descri;
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

	public String getEffectTime() {
		return effectTime;
	}

	public void setEffectTime(String effectTime) {
		this.effectTime = effectTime;
	}

	public String getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}


	
}
