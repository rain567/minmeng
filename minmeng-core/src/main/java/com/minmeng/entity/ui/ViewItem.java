package com.minmeng.entity.ui;

import java.util.Date;




import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.Cat;
import org.fixwork.framework.entity.BaseEntity;
import org.fixwork.mapping.Column;
import org.fixwork.mapping.Foreign;
import org.fixwork.mapping.PrimaryKey;
import org.fixwork.mapping.Table;

/**
 * @Description 控件条目
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2018-12-26
 */
@Table(DBConstants.Table.UI.VIEW_ITEM)
@PrimaryKey(autoIncrement = false)
public class ViewItem  extends BaseEntity {

	private static final long serialVersionUID = -17334212391232355L;

	/** 主键 */
	@Column(name = "id",length = 32)
	private String id;	

	/** 分类 */
	@Foreign
	@Column(name = "cat_id",length = 32)
	private Cat cat;
	private String catName;
	/** 控件  */
	@Foreign
	@Column(name = "view_id")
	private View view;
	
	private String viewName;
	/** 图片 */
	@Column(name = "image")
	private String image;
	/** 文本内容 */
	@Column(name = "content")
	private String content = "";
	/** 链接地址 */
	@Column(name = "link")
	private String link = "";
	/** 打开目标 */
	@Column(name = "target")
	private String target = "";

	/** 是否否广告位 */
	@Column(name = "is_ad")
	private boolean ad = false;	

	/** 价格 */
	@Column(name = "price",length = 32)
	private Double price = 0.0;

	/** 排序 */
	@Column(name = "sorter",length = 11)
	private Integer sorter = 99;

	/** 状态:1:启用,0:未启用 */
	@Column(name = "status")
	private String status="1";
	/** 创建时间 */
	@Column(name = "create_time")
	private String createTime = Constants.DATE_TIME_FORMAT.format(new Date());	

	/** 生效时间 */
	@Column(name = "update_time")
	private String updateTime = Constants.DATE_TIME_FORMAT.format(new Date());	
	/** 过期时间 */
	@Column(name = "expire_time")
	private String expireTime = Constants.DATE_TIME_FORMAT.format(new Date());	

	/** 修改时间 */
	@Column(name = "effect_time")
	private String effectTime = Constants.DATE_TIME_FORMAT.format(new Date());

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Cat getCat() {
		return cat;
	}

	public void setCat(Cat cat) {
		this.cat = cat;
	}

	public View getView() {
		return view;
	}

	public void setView(View view) {
		this.view = view;
	}


	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public boolean isAd() {
		return ad;
	}

	public void setAd(boolean ad) {
		this.ad = ad;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
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

	public String getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}

	public String getEffectTime() {
		return effectTime;
	}

	public void setEffectTime(String effectTime) {
		this.effectTime = effectTime;
	}

	public String getCatName() {
		if(catName == null && cat!=null){
			catName = cat.getName();
		}
		return catName;
	}

	public void setCatName(String catName) {
		this.catName = catName;
	}

	public String getViewName() {
		if(viewName == null && view!=null){
			viewName = view.getName();
		}
		return viewName;
	}

	public void setViewName(String viewName) {
		this.viewName = viewName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}	
	


}
