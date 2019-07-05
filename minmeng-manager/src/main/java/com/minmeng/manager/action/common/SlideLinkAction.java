package com.minmeng.manager.action.common;

import java.util.List;

import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.Error;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;

import com.minmeng.entity.common.SlideLink;
import com.minmeng.service.common.SlideLinkService;
import com.minmeng.manager.action.BaseAction;

/**
 * @description 网站设置>滚动链接
 * @company 贵州沃尔达科技有限公司
 * @version 1.0 2014-8-30 创建@杨大江
 */
@ActionPath(path="/setting/slide-link",dir="/WEB-INF/jsp/setting/slide-link",description="网站设置－滚动链接设置",auth=true)
public class SlideLinkAction extends BaseAction{

	SlideLinkService slService = new SlideLinkService();
	
	@ActionUri(uri="([/])?",description="网站设置－滚动链接设置")
	public String index() {
		List<SlideLink> list = slService.query();
		put("list", list);
		return "index.jsp";
	}

	/**
	 * 保存
	 */
	@ActionUri(uri="save([/])?",description="网站设置－保存滚动链接")
	public void save(String id,String text,String url,Integer sorter) {
		if(!StringUtils.isEmpty(id) &&!StringUtils.isEmpty(text)){
			SlideLink slideLink = new SlideLink();
			slideLink.setText(text);
			slideLink.setUrl(url);
			slideLink.setSorter(sorter!=null?sorter:0);
			slideLink.setId(id);
			if(slService.save(slideLink)!=null){
				printJson(new Success("已保存."));
			}else{
				printJson(new Error("保存失败."));
			}
		}else {
			printJson(new Error("链接标题不能为空."));
		}
	}

	/**
	 * 删除
	 */
	@ActionUri(uri="del([/])?",description="网站设置－删除滚动链接")
	public void del(String ids) {
		Integer num = slService.delete(ids.split(","));
		if(num>0){
			printJson(new Success(Success.SUCCESS_DATA, "删除完成."));
		}else{
			printJson(new Error(Error.ERROR_DATA, "删除失败."));
		}
	}
}
