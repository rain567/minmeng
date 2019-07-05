package com.minmeng.manager.action;

import java.io.IOException;
import java.net.URI;
import java.util.List;

import org.apache.log4j.Logger;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Utils;
import org.fixwork.web.upload.ExtIcon;
import org.fixwork.web.upload.Progress;
import org.fixwork.web.upload.Upload;
import org.fixwork.web.upload.UploadHandler;
import org.fixwork.web.upload.entity.Error;
import org.fixwork.web.upload.entity.Info;

import com.minmeng.entity.common.Attach;
import com.minmeng.service.common.AttachService;

public class UploadAction extends BaseAction{
	Logger log = Logger.getLogger(UploadAction.class);
	String attachPath=  I18n.i18n.get("ATTACH_PATH");
	String savePath = I18n.i18n.get("ATTACH_SAVE_PATH");

	AttachService attachService = new AttachService();
	
	@ActionUri(uri="/upload([/])?",description="上传图片")
	public void upload(String dirname){
		dirname = !StringUtils.isEmpty(dirname)?dirname:"image";
		
		Upload upload =  new Upload(request, response);
		upload.setDirName(dirname);
		if(!StringUtils.isEmpty(savePath))
			upload.setSavePath(savePath);
		if(!StringUtils.isEmpty(attachPath))
			upload.setSaveUrl(attachPath);
		try { 
			//upload.execute();  
			upload.execute(new UploadHandler() {
				
				@Override
				public void success(Info info) {
					printJson(info);
				}
				  
				@Override
				public String getFilename() {
					return Utils.createId();
				}
				
				@Override
				public void error(Error error) {
					printJson(error);
				}

				@Override
				public void success(List<Info> infos) {
					// TODO Auto-generated method stub
					
				}
			});
		} catch (Exception e) { 
			e.printStackTrace();  
		}  
	} 

	@ActionUri(uri="/uploadFile([/])?",description="上传文件")
	public void uploadFile(String dirname){
		dirname = !StringUtils.isEmpty(dirname)?dirname:"file";
		Upload upload =  new Upload(request, response);
		upload.setDirName(dirname);
		if(!StringUtils.isEmpty(savePath))
			upload.setSavePath(savePath);
		if(!StringUtils.isEmpty(attachPath))
			upload.setSaveUrl(attachPath);
		try { 
			//upload.execute();
			upload.execute(new UploadHandler() {
				
				@Override
				public void success(Info info) {
					printJson(info);
				}
				  
				@Override
				public String getFilename() {
					return null;
				}
				
				@Override
				public void error(Error error) {
					printJson(error);
				}

				@Override
				public void success(List<Info> infos) {
					// TODO Auto-generated method stub
					
				}
			});
		} catch (Exception e) { 
			e.printStackTrace();  
		}  
	} 
	/**
	 * 上传进度 
	 */
	@ActionUri(uri="/progress([/])?",description="上传进度")
	public void progress(){
		try {
			new Progress(request,response);
		} catch (IOException e) {
			e.printStackTrace();
		}
	} 

	/**
	 * 文件图标
	 */
	@ActionUri(uri="/exticon([/])?",description="文件图标")
	public void exticon(){
		try {
			new ExtIcon(request,response);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@ActionUri(uri="/fileData([/])?",description="附件数据")
	public void fileData(String urls){
		List<Attach> list =  attachService.query(urls.split(","));
		if(list!=null && list.size()>0){
			printJson(list);
		}else{
			printJson(new Error(Error.ERROR_NULL,"没有附件"));
		} 
	}
	
	public static void main(String ...args){
		String url = "http://localhost:8080/templete-gov-resources/attaches/";
		URI uri = URI.create(url);
		System.out.println(uri.getHost());
		System.out.println(uri.getPath());
	} 
}
