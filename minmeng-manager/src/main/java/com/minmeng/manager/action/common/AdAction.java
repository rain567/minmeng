package com.minmeng.manager.action.common;

import java.util.List;

import org.apache.poi.xwpf.converter.core.utils.StringUtils;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.Error;
import org.fixwork.util.Success;

import com.minmeng.entity.common.Ad;
import com.minmeng.service.common.AdService;
import com.minmeng.manager.action.BaseAction;

/**
 * @description 网站设置>广告
 * @company 贵州沃尔达科技有限公司
 * @version 1.0 2014-8-30 创建@杨大江
 */
@ActionPath(path="/setting/ad",dir="/WEB-INF/jsp/setting/ad",description="网站设置－广告",auth=true)
public class AdAction extends BaseAction{

	AdService adService = new AdService();
	
	@ActionUri(uri="([/])?",description="网站设置－广告管理")
	public String index() {
		List<Ad> list = adService.query();
		put("list", list);
		return "index.jsp";
	}

	/**
	 * 保存
	 */
	@ActionUri(uri="save([/])?",description="网站设置－保存广告")
	public void save(String id,String position,
			String href,
			String text,String image,String status,Integer sorter) {
		if(!StringUtils.isEmpty(id) && !StringUtils.isEmpty(position)){
			Ad ad = new Ad();
			ad.setPosition(position);
			ad.setText(text);
			ad.setImage(image);
			ad.setStatus(status);
			ad.setHref(href);
			ad.setSorter(sorter!=null?sorter:0);
			ad.setId(id);
			if(adService.save(ad)!=null){
				printJson(new Success("已保存."));
			}else{
				printJson(new Error("保存失败."));
			}
		}else {
			printJson(new Error("广告位置不能为空."));
		}
	}

	/**
	 * 删除
	 */
	@ActionUri(uri="del([/])?",description="网站设置－删除广告")
	public void del(String ids) {
		Integer num = adService.delete(ids.split(","));
		if(num>0){
			printJson(new Success(Success.SUCCESS_DATA, "删除完成."));
		}else{
			printJson(new Error(Error.ERROR_DATA, "删除失败."));
		}
	}
}
