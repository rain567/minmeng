package com.minmeng.entity.sys;

import java.util.Date;




import com.minmeng.Constants;
import com.minmeng.entity.DBConstants;
import org.fixwork.framework.entity.BaseEntity;
import org.fixwork.mapping.Column;
import org.fixwork.mapping.PrimaryKey;
import org.fixwork.mapping.Table;

/**
 * 
 * 模块
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-18
 */
@Table(DBConstants.Table.Sys.SQL_DUMP)
@PrimaryKey()
public class SqlDump extends BaseEntity {

	private static final long serialVersionUID = -3633988218465881129L;

	/** id */
	@Column(name = "id",length = 11)
	private Integer id;	

	/** 0:备份，1：还原 */
	public static enum Mode{
		BACKUP("0"),
		RESTORE("1");

		String value;
		Mode(String value){
			this.value = value;
		}
		
		@Override
		public String toString(){
			return value.toString();
		}
	}
	@Column(name = "mode",length = 1)
	private String mode = Mode.BACKUP.toString();

	/** sql文件 */
	@Column(name = "sql_file")
	private String sqlFile;

	/** 说明 */
	@Column(name = "descri",length = 15)
	private String descri;

	/** 操作员用户名 */
	@Column(name = "username",length = 32)
	private String username;

	/** 创建时间 */
	@Column(name = "create_time")
	private String createTime = Constants.DATE_TIME_FORMAT.format(new Date());

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getSqlFile() {
		return sqlFile;
	}

	public void setSqlFile(String sqlFile) {
		this.sqlFile = sqlFile;
	}

	public String getDescri() {
		return descri;
	}

	public void setDescri(String descri) {
		this.descri = descri;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}	

}
