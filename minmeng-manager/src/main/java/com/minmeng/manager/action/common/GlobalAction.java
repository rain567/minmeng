package com.minmeng.manager.action.common;

import java.util.Map;

import org.apache.log4j.Logger;
import org.fixwork.framework.action.Action;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;
import org.fixwork.util.Utils;

import com.minmeng.entity.common.GlobalSetting;
import com.minmeng.service.common.GlobalSettingService;

/**
 * @Description 管理员中心>全局设置
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-19
 */
@ActionPath(path="/setting/global/",dir="/WEB-INF/jsp/setting/global/")
public class GlobalAction extends Action{
	static final Logger log = Logger.getLogger(GlobalAction.class);
	
	GlobalSettingService gsService = new GlobalSettingService();

	@ActionUri(uri="([/])?")
	public String index(){
		Map<String,String> setting = gsService.query();
		put("siteName",setting.get("siteName"));
		String footerHtml = setting.get("footerHtml");
		put("footerHtml",!StringUtils.isEmpty(footerHtml)? Utils.htmlspecialchars(footerHtml):"");
		put("icp",setting.get("icp"));
		put("css",setting.get("css"));
		put("siteEmail",setting.get("siteEmail"));
		put("sitePhone",setting.get("sitePhone"));
		put("development",setting.get("development"));
		put("icpGongan",setting.get("icpGongan"));
		return "index.jsp";
	}

	@ActionUri(uri="save([/])?",description="保存设置")
	public void edit(
			String siteName,
			String footerHtml,
			String icp,  
			String siteEmail,
			String sitePhone,
			String development,
			String icpGongan,
			String css
			){
		GlobalSetting s1 = new GlobalSetting("siteName",siteName);
		GlobalSetting s2 = new GlobalSetting("footerHtml",footerHtml);
		GlobalSetting s3 = new GlobalSetting("icp",icp);
		GlobalSetting s4 = new GlobalSetting("css",css);
		GlobalSetting s5 = new GlobalSetting("siteEmail",siteEmail);
		GlobalSetting s6 = new GlobalSetting("sitePhone",sitePhone);
		GlobalSetting s7 = new GlobalSetting("development",development);
		GlobalSetting s8 = new GlobalSetting("icpGongan",icpGongan);
		
		gsService.save(s1);
		gsService.save(s2);
		gsService.save(s3);
		gsService.save(s4);
		gsService.save(s5);
		gsService.save(s6);
		gsService.save(s7);
		gsService.save(s8);
		
		printJson(new Success("保存结束"));
	}

	@Override
	public String onStart() {
		// TODO Auto-generated method stub
		return null;
	}
}
