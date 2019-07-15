package com.minmeng.entity.common;




import com.minmeng.entity.DBConstants;
import org.fixwork.framework.entity.BaseEntity;
import org.fixwork.mapping.Column;
import org.fixwork.mapping.PrimaryKey;
import org.fixwork.mapping.Table;

/**
 * 全局设置
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-3-11
 */
@Table(DBConstants.Table.Common.GLOBAL_SETTING)
@PrimaryKey(autoIncrement = false)
public class GlobalSetting extends BaseEntity {

	private static final long serialVersionUID = -5746951347870381892L;

	/** 键 */
	@Column(name = "id",length = 32)
	private String id;	

	/** 值 */
	@Column(name = "value",length = 999)
	private String value;


	public GlobalSetting() {
		super();
	}

	public GlobalSetting(String id, String value) {
		super();
		this.id = id;
		this.value = value;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	
}
