package com.minmeng.entity.common;

import java.util.Date;



import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import org.fixwork.framework.entity.BaseEntity;
import org.fixwork.mapping.Column;
import org.fixwork.mapping.PrimaryKey;
import org.fixwork.mapping.Table;

/**
 * 附件
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-3-10
 */
@Table(DBConstants.Table.Common.ATTACH)
@PrimaryKey(autoIncrement = false)
public class Attach extends BaseEntity {

	private static final long serialVersionUID = -5546623122052028755L;

	/** id */
	@Column(name = "id",length = 32,notnull = true)
	private String id;	
	
	/** 说明 */
	@Column(name = "alt",length = 255)
	private String alt;			
	
	/** 文件路径 */
	@Column(name = "file_path",length = 255)
	private String filePath;	

	/** 访问地址 */
	@Column(name = "url",length = 255)
	private String url;	

	/** 类型：image,file,audio,video,flash,txt,doc,zip */
	public static enum Type{
		IMAGE("image"),
		FILE("file"),
		AUDIO("audio"),
		VIDEO("video"),
		FLASH("flash"),
		TXT("txt"),
		DOC("doc"),
		ZIP("zip");
		
		String value;
		Type(String value){
			this.value = value;
		}

		@Override
		public String toString(){
			return value;
		}
	}
	
	@Column(name = "att_type",length = 32)
	private String type;	

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

	public String getAlt() {
		return alt;
	}

	public void setAlt(String alt) {
		this.alt = alt;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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


	
}
