package com.minmeng.manager.action.sys;

import java.util.List;

import org.apache.log4j.Logger;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.Error;
import org.fixwork.util.Pagination;
import org.fixwork.util.Success;

import com.minmeng.entity.sys.SqlDump;
import com.minmeng.manager.action.ui.UIAction;

/**
 * @Description 备份还原
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2015-3-25
 */
@ActionPath(path="/ui/dump/",dir="/WEB-INF/jsp/ui/dump/",description="UI设置－备份还原",auth=true)
public class SqlDumpAction extends UIAction{
	static final Logger log = Logger.getLogger(SqlDumpAction.class);


	@ActionUri(uri="([/])?",description="UI设置备份还原")
	public String list(Integer page,Integer pageSize,String username,String mode,String keyword,
			String startTime,String endTime){
		page = page!=null?page:1;
		String psStr = I18n.i18n.get("DEFAULT_PAGESIZE");
		pageSize =  pageSize!=null?pageSize:psStr.matches("\\d+")?Integer.valueOf(psStr):20;
		
		// 查询出总数
		Integer total = dumpService.total(keyword, username, mode,startTime, endTime);
		// 创建分页对象
		Pagination pagination  = new Pagination(total,pageSize, page);
		// 查询分页数据
		Integer start = pagination.getStartIndex();
		List<SqlDump> list = dumpService.query(keyword, username, mode, startTime, endTime, start, pageSize);
		// 输出
		put("list", list);
		put("username", username);
		put("mode", mode);
		put("keyword", keyword);
		put("pageSize", pageSize);
		put("nodata", !(list != null && list.size() > 0) ? "未找到数据。" : "");
		put("pagination", pagination);
		put("paginationHtml", pagination.getHtml(request.getRequestURI()+"?"
				+ "keyword="+keyword
				+ "&username="+username
				+ "&mode="+mode
				+ (startTime.matches(I18n.i18n.get("DATE_REGEXT"))?"&startTime='"+startTime+"'":"")
				+ (endTime.matches(I18n.i18n.get("DATE_REGEXT"))?"&endTime='"+endTime+"'":""), 20));
		return "index.jsp";
	}

	/**
	 * 还原
	 * @param dumpId
	 * @return
	 */
	@ActionUri(uri="restore([/])?",description="UI设置备份还原－还原")
	public void restore(Integer dumpId){
		SqlDump dump = dumpService.get(dumpId);
		if(dump == null){
			printJson(new Error( "备份记录不存在."));
		}else if( sqlRestore(dump.getSqlFile(),"还原设置："+dump.getDescri())){
			printJson(new Success( "操作成功完成"));
		}else {
			printJson(new Error( "操作失败."));
		}
	}
	

	/**
	 * 删除
	 * @param dumpId
	 * @return
	 */
	@ActionUri(uri="del([/])?",description="UI设置备份还原－删除备份/还原记录")
	public void del(Integer dumpId){
		SqlDump dump = dumpService.get(dumpId);
		if(dump == null){
			printJson(new Error( "记录不存在."));
		}else {
			if(dumpService.delete(dumpId)>0){
				printJson(new Success( "删除成功"));
				if(dump.getMode().equalsIgnoreCase(SqlDump.Mode.BACKUP.toString())){
					// 备份，则删除文件
					rmDump(dump.getSqlFile());
				}
			}else{
				printJson(new Error( "删除失败."));
			}
		}
	}

}
