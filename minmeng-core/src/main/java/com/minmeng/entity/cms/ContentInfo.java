package com.minmeng.entity.cms;

import java.util.Date;
import java.util.List;



import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.common.Attach;
import com.minmeng.entity.common.Cat;
import com.minmeng.service.cms.ContentAttachService;
import org.fixwork.framework.entity.BaseEntity;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.Column;
import org.fixwork.mapping.Foreign;
import org.fixwork.mapping.PrimaryKey;
import org.fixwork.mapping.Table;

/**
 * 
 * 内容
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-3-10
 */
@Table(DBConstants.Table.CMS.CONTENT_INFO)
@PrimaryKey(autoIncrement = false)
public class ContentInfo extends BaseEntity {
	
	private static final long serialVersionUID = 7731908500144732607L;

	/** id */
	@Column(name = "id",length = 32)
	private String id;	

	/** 分类 */
	@Foreign
	@Column(name = "cat_id",length = 32)
	private Cat cat;

	/** 标题 */
	@Column(name = "title",length = 255)
	private String title = "";
	
	/** 副标题 */
	@Column(name = "subtitle",length = 255)
	private String subtitle = "";	

	/** 内容*/
//	@NotJSONField
	@Column(name = "content")
	private String content = "";	
	
	private String webUrl = "";

	/** 作者/来源 */
	@Column(name = "source",length = 32)
	private String source = "";	

	/** 关键词 */
	@Column(name = "keywords",length = 255)
	private String keywords = "";	

	/** 创建时间 */
	@Column(name = "create_time")
	private String createTime = Constants.DATE_TIME_FORMAT.format(new Date());	

	/** 修改时间 */
	@Column(name = "update_time")
	private String updateTime = Constants.DATE_TIME_FORMAT.format(new Date());		

	/**  点赞数 */
	@Column(name = "like_total")
	private Integer likeTotal = 0;

	/** 访问量 */
	@Column(name = "brower",length = 11)
	private Integer brower = 0;	

	/** 0:创建,1:提交未审核,2：审核通过,3:审核不通过,4:关闭*/
	@Column(name = "status")
	private String status = "0";	

	/** 0:默认，1:推荐到列表页，2:推荐到内页，3:推荐到模块首页，4:推到全站首页 */
	@Column(name = "recom",length = 11)
	private String recom = "0"; 

	/** 视频地址 */
	@Column(name = "video",length = 255)
	private String video = "";

	/** 自定义链接*/
	@Column(name = "href")
	private String href = "";	

	@Column(name = "creater")
	private String creater="";	
	@Column(name = "updater")
	private String updater="";

	@Column(name = "release")
	private int release;

	public int getRelease() {
		return release;
	}

	public void setRelease(int release) {
		this.release = release;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
		if(images == null){
			images = caService.query(id, Attach.Type.IMAGE.toString());
		}
		if(files == null)
			files =  caService.query(id, Attach.Type.FILE.toString());
		setWebUrl(null);
	}

	public Cat getCat() {
		return cat;
	}

	public void setCat(Cat cat) {
		this.cat = cat;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}


	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		if(createTime != null && !createTime.equals(""))
			this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		if(updateTime != null && !updateTime.equals(""))
			this.updateTime = updateTime;
	}


	public Integer getBrower() {
		return brower;
	}

	public void setBrower(Integer brower) {
		this.brower = brower;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRecom() {
		return recom;
	}

	public void setRecom(String recom) {
		this.recom = recom;
	}
	

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}


	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}


	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public String getUpdater() {
		return updater;
	}

	public void setUpdater(String updater) {
		this.updater = updater;
	}


	public Integer getLikeTotal() {
		return likeTotal;
	}

	public void setLikeTotal(Integer likeTotal) {
		this.likeTotal = likeTotal;
	}

	

	ContentAttachService caService = new ContentAttachService();
	private List<Attach> images;
	private List<Attach> files ;

	// 图片
	public List<Attach> getImages() {
		return images;
	}
	public List<Attach> getFiles() {
		return files;
	}

	public void setImages(List<Attach> images) {
		this.images = images;
	}

	public void setFiles(List<Attach> files) {
		this.files = files;
	}

	public String getWebUrl() {
		if(webUrl == null){
			String host = I18n.i18n.get("HOST_WEB");
			webUrl = host + "/mobile/c/"+cat.getUri()+"/"+id;
		}
		return webUrl;
	}

	public void setWebUrl(String webUrl) {
		this.webUrl = webUrl;
	}
}
