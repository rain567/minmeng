package com.minmeng.manager.action.ui;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.fixwork.framework.i18n.I18n;
import com.minmeng.entity.DBConstants;
import com.minmeng.entity.sys.SqlDump;
import com.minmeng.manager.action.BaseAction;
import com.minmeng.service.common.CatService;
import com.minmeng.service.sys.SqlDumpService;
import com.minmeng.service.ui.PageService;
import com.minmeng.service.ui.PageViewService;
import com.minmeng.service.ui.ViewItemService;
import com.minmeng.service.ui.ViewService;


/**
 * @Description UI
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2015-3-25
 */
public class UIAction extends BaseAction {

	/**UI设置备份路径*/
	private String uiDumpPath = I18n.i18n.get("UI_DUMP_PATH");
	static final SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
	protected SqlDumpService dumpService = new SqlDumpService();
	protected ViewService viewService = new ViewService();
	protected ViewItemService viewItemService = new ViewItemService();
	protected CatService catService = new CatService();
	protected PageService pageService = new PageService();
	protected PageViewService pageViewService = new PageViewService();

	
	public String createCmdFile(String cmd){
		uiDumpPath = uiDumpPath.endsWith("/")?uiDumpPath:uiDumpPath+"/";
		File dir = new File(uiDumpPath);
		if(!dir.exists()){
			dir.mkdirs();
		}
		String cmdFilePath = uiDumpPath + "dump.sh";
		File cmdFile = new File(cmdFilePath);
		if(!cmdFile.exists()){
			try {
				cmdFile.createNewFile();
				return null;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return cmdFilePath;
	}
	/**
	 * 备份
	 * @descri 描述
	 * @return
	 */
	protected String sqlDump(String descri){
		uiDumpPath = uiDumpPath.endsWith("/")?uiDumpPath:uiDumpPath+"/";
		File dir = new File(uiDumpPath);
		if(!dir.exists()){
			dir.mkdirs();
		}
		String sqlFile = df.format(new Date())+ Math.round(Math.random()*8999+1000)+".sql";
		//String cmd = "/usr/local/mysql/bin/mysqldump -hlocalhost -uroot -proot ztc_site_ui>" + uiDumpPath + sqlFile;
		String cmd = "mysqldump -hlocalhost -uroot -proot minmeng_ui>" + uiDumpPath + sqlFile;
		try {
			Runtime.getRuntime().exec(new String[]{"/bin/sh","-c",cmd});
			
			SqlDump dump = new SqlDump();
			dump.setMode(SqlDump.Mode.BACKUP.toString());
			dump.setSqlFile(sqlFile);
			dump.setDescri(descri);
			dump.setUsername(sessionAdmin.getUsername());
			dumpService.insert(dump);
		} catch (IOException e) {
			log.error("无法备份，不支持windows系统："+e.getMessage());
		}
		return sqlFile;
	}

	/**
	 * 还原
	 * @param sqlFile
	 * @return
	 */
	protected boolean sqlRestore(String sqlFile,String descri){
		uiDumpPath = uiDumpPath.endsWith("/")?uiDumpPath:uiDumpPath+"/";
		//String cmd = "/usr/local/mysql/bin/mysql -uroot -proot  "+DBConstants.DATABASE_UI+" -e \"source " + uiDumpPath + sqlFile+"\"";
		//String cmd = "mysql -uroot -proot  "+DBConstants.Database.UI +" -e \"source " + uiDumpPath + sqlFile+"\"";
//		try {
//			Runtime.getRuntime().exec(new String[]{"/bin/sh","-c",cmd});
//
//			SqlDump dump = new SqlDump();
//			dump.setMode(SqlDump.Mode.RESTORE.toString());
//			dump.setSqlFile(sqlFile);
//			dump.setDescri(descri);
//			dump.setUsername(sessionAdmin.getUsername());
//			dumpService.insert(dump);
//			return true;
//		} catch (IOException e) {
//			e.printStackTrace();
//			return false;
//		}
		return false;
	}

	/**
	 * 删除备份
	 * @param sqlFile
	 * @return
	 */
	protected void rmDump(String sqlFile){
		uiDumpPath = uiDumpPath.endsWith("/")?uiDumpPath:uiDumpPath+"/";
		File file = new File(uiDumpPath + sqlFile);
		if(file.exists())
			file.delete();
	}
}
