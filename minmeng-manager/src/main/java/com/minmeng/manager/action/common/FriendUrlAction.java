package com.minmeng.manager.action.common;

import java.util.List;

import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.Error;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;

import com.minmeng.entity.common.FriendUrl;
import com.minmeng.service.common.FriendUrlService;
import com.minmeng.manager.action.BaseAction;

/**
 * @description 网站设置>友情链接
 * @company 贵州沃尔达科技有限公司
 * @version 1.0 2014-8-30 创建@杨大江
 */
@ActionPath(path="/setting/friendurl",dir="/WEB-INF/jsp/setting/friendurl",description="网站设置－友情链接",auth=true)
public class FriendUrlAction extends BaseAction{

	FriendUrlService friendUrlService = new FriendUrlService();
	
	@ActionUri(uri="([/])?",description="网站设置－友情链接管理")
	public String index() {
		List<FriendUrl> list = friendUrlService.query();
		put("list", list);
		return "index.jsp";
	}

	/**
	 * 保存
	 */
	@ActionUri(uri="save([/])?",description="网站设置－保存友情链接")
	public void save(String id,String sitename,String url,String logo,Integer sorter) {
		if(!(url.startsWith("http://") || url.startsWith("https://"))){
			printJson(new Error("网址须以http://或https://开头."));
			return;
		}
		if(!StringUtils.isEmpty(id) &&!StringUtils.isEmpty(sitename)){
			FriendUrl friendUrl = new FriendUrl();
			friendUrl.setSitename(sitename);
			friendUrl.setUrl(url);
			friendUrl.setLogo(logo);
			friendUrl.setSorter(sorter!=null?sorter:0);
			friendUrl.setId(id);
			if(friendUrlService.save(friendUrl)!=null){
				printJson(new Success("已保存."));
			}else{
				printJson(new Error("保存失败."));
			}
		}else {
			printJson(new Error("网站名称不能为空."));
		}
	}

	/**
	 * 删除
	 */
	@ActionUri(uri="del([/])?",description="网站设置－删除友情链接")
	public void del(String ids) {
		Integer num = friendUrlService.delete(ids.split(","));
		if(num>0){
			printJson(new Success(Success.SUCCESS_DATA, "删除完成."));
		}else{
			printJson(new Error(Error.ERROR_DATA, "删除失败."));
		}
	}
}
