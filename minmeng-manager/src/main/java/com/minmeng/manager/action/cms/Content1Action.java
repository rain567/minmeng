package com.minmeng.manager.action.cms;

import java.io.File;
import java.util.List;

import org.apache.log4j.Logger;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.DataValidations;
import org.fixwork.util.Error;
import org.fixwork.util.MD5;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;
import org.fixwork.util.Utils;

import com.minmeng.entity.cms.ContentAttach;
import com.minmeng.entity.cms.ContentInfo;
import com.minmeng.entity.common.Attach;
import com.minmeng.entity.common.Cat;
import com.minmeng.service.cms.ContentAttachService;
import com.minmeng.service.cms.ContentInfoService;
import com.minmeng.service.common.AttachService;
import com.minmeng.service.common.CatService;
import com.minmeng.manager.action.BaseAction;

/**
 * @Description 管理员中心>列表内容
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-20
 */
@ActionPath(path="/cms/",dir="/WEB-INF/jsp/cms/")
public class Content1Action extends BaseAction{
	static final Logger log = Logger.getLogger(Content1Action.class);

	String savePath = I18n.i18n.get("ATTACH_SAVE_PATH");
	
	CatService catService = new CatService();
	ContentInfoService infoService = new ContentInfoService();
	AttachService attachService = new AttachService();
	ContentAttachService caService = new ContentAttachService();
	 
   
	@ActionUri(uri="edit1([/])?",description="编辑列表栏目")
	public String edit1(ContentInfo info,String cid){
		put("id", !StringUtils.isEmpty(info.getId())?info.getId():Utils.createId());
		put("catId",info.getCat()!=null?info.getCat().getId():cid);
		if(info!=null){
			put("info", info);
			String content = info.getContent();
			put("content",!StringUtils.isEmpty(content)? Utils.htmlspecialchars(content):"");
			List<Attach> images = info.getImages();
			if(images!=null ){
				int size = images.size();
				String[] array = new String[size];
				for(int i=0;i<size;i++){
					Attach image = images.get(i);
					array[i] = image.getUrl();
				}
				put("images",array);
			}
			List<Attach> files = info.getFiles();
			if(files!=null ){
				int size = files.size();
				String[] array = new String[size];
				for(int i=0;i<size;i++){
					Attach file = files.get(i);
					array[i] = file.getUrl();
				}
				put("files",array);
			}
		}
		return "edit1.jsp";
	}

	@ActionUri(uri="save1([/])?",description="保存列表栏目内容")
	public void save(String catId, ContentInfo info,
			String keywords, String href,
			String video,String source,String[] images,String[] files){
		if(StringUtils.isEmpty(info.getId())){
			printJson(new Error("ID不能为空！"));
			return;
		}
		Cat cat = catService.get(catId);
		if(cat == null ){
			printJson(new Error("栏目不存在！"));
			return;
		}
		if(checkTitle(info.getTitle(), info.getId())){
			info.setCat(cat);
			info.setVideo(video);
			info.setSource(source);
			info.setKeywords(keywords);
			info.setHref(href);
			
			List<Error> errors = DataValidations.dataTooLong(info);
			if(errors!=null && errors.size()>0){
				printJson(new Error( "数据长度超过限制.",errors));
				return;
			}
			if(infoService.save(info)!=null){
				printJson(new Success( "保存完成"));
				caService.clear(info.getId());
				if(images!=null && images.length>0){
					for(String image:images){
						// 保存附件
						Attach att = new Attach();
						String filename = image.substring(image.lastIndexOf("/")+1,image.length());
						
						String dir = image.substring(0,image.lastIndexOf("/"));
						dir = dir.substring(dir.lastIndexOf("/")+1,dir.length());
						
						att.setId(MD5.md5(image));
						att.setAlt(info.getTitle());
						att.setUrl(image);
						att.setType(Attach.Type.IMAGE.toString());
						att.setFilePath(savePath
								+"file"+ File.separator 
								+ dir +File.separator
								+filename);
						att = attachService.save(att);
						if(att!=null){
							ContentAttach ca = new ContentAttach(info.getId(), att.getId());
							caService.save(ca);
						}
					}
				}
	 
				if(files!=null && files.length>0){
					for(String file:files){
						// 保存附件
						Attach att = new Attach();
						String filename = file.substring(file.lastIndexOf("/")+1,file.length());
						
						String dir = file.substring(0,file.lastIndexOf("/"));
						dir = dir.substring(dir.lastIndexOf("/")+1,dir.length());
						
						att.setId(MD5.md5(file));
						att.setAlt(info.getTitle());
						att.setUrl(file);
						att.setType(Attach.Type.FILE.toString());
						att.setFilePath(savePath
								+"file"+ File.separator 
								+ dir +File.separator
								+filename);
						att = attachService.save(att);
						if(att!=null){
							ContentAttach ca = new ContentAttach(info.getId(), att.getId());
							caService.save(ca);
						}
					}
				}
				// 创建索引
				indexed(info);
			}else {
				printJson(new Error( "保存失败."));
			}
		}
	}

	
	@ActionUri(uri="del([/])?",description="删除内容")
	public void del(String ids) {
		if(infoService.delete(ids.split(","))>0){
			printJson(new Success( "删除完成."));
		}else {
			printJson(new Error( "删除失败."));
		}
	}

	@ActionUri(uri="setStatus([/])?",description="设置状态")
	public void setStatus(String id,String status) {
		if(status == null || "".equals(status)){
			printJson(new Error("未设置状态"));
		}else if(infoService.setStatus(id, status)>0){
			printJson(new Success( "设置完成."));
		}else {
			printJson(new Error( "设置失败."));
		}
	}

	@ActionUri(uri="setRecom([/])?",description="设置推荐类型")
	public void setRecom(String id,String recom) {
		if(recom == null  || "".equals(recom) ){
			printJson(new Error("未设置推荐类型"));
		}else if(infoService.setRecom(id, recom)>0){
			printJson(new Success( "设置完成."));
		}else {
			printJson(new Error( "设置失败."));
		}
	}

	@ActionUri(uri="checkTitle([/])?",description="检查标题")
	public boolean checkTitle(String title,String id) {
		if(title == null || "".equals(title)){
			printJson(new Error("标题不能为空！"));
			return false;
		}else if(infoService.existsTitle(title, id)){
			printJson(new Error("标题重复！"));
			return false;
		}else {
			printJson(new Success("标题可用"));
			return true;
		}
	}

	@ActionUri(uri="checkSubTitle([/])?",description="检查副标题（新闻简介）")
	public boolean checkSubTitle(String subtitle) {
		if(subtitle == null || "".equals(subtitle)){
			printJson(new Error("副标题不能为空！"));
			return false;
		}else {
			printJson(new Success("副标题（新闻简介）可用"));
			return true;
		}
	}

}
