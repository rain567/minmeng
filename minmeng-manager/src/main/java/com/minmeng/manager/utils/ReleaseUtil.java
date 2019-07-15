package com.minmeng.manager.utils;

import javax.servlet.http.HttpServletRequest;

import com.minmeng.entity.cms.ContentInfo;
import com.minmeng.service.cms.ContentInfoService;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

public class ReleaseUtil {
	public static List<String> getRelease(){

		//properties地址
		String path = "conf/i18n/zh-CN.properties";
		List<String> paths = new ArrayList<String>();
		String url = "";

		if (!PropertiesUtil.getByName(path, "HTTP_BIJIE").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_BIJIE");
			paths.add(url);
		}
		System.out.println(PropertiesUtil.getByName(path, "HTTP_GUIYANG"));
		if (!PropertiesUtil.getByName(path, "HTTP_GUIYANG").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_GUIYANG");
			paths.add(url);
		}
		if (!PropertiesUtil.getByName(path, "HTTP_LIUPANSHUI").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_LIUPANSHUI");
			paths.add(url);
		}
		if (!PropertiesUtil.getByName(path, "HTTP_QIANDONGNAN").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_QIANDONGNAN");
			paths.add(url);
		}
		if (!PropertiesUtil.getByName(path, "HTTP_QIANNAN").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_QIANNAN");
			paths.add(url);
		}
		if (!PropertiesUtil.getByName(path, "HTTP_QIANXINAN").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_QIANXINAN");
			paths.add(url);
		}
		if (!PropertiesUtil.getByName(path, "HTTP_QUANSHENG").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_QUANSHENG") ;
			paths.add(url);
		}

		return paths;
	}

	/*public static Boolean getRelease(String id) throws IOException {

		//properties地址
		String path = "conf/i18n/zh-CN.properties";

		String url = "";

		if (!PropertiesUtil.getByName(path, "HTTP_BIJIE").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_BIJIE");
			pushRelease(url, id);
			return true;
		}
		System.out.println(PropertiesUtil.getByName(path, "HTTP_GUIYANG"));
		if (!PropertiesUtil.getByName(path, "HTTP_GUIYANG").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_GUIYANG");
			pushRelease(url, id);
			return true;
		}
		if (!PropertiesUtil.getByName(path, "HTTP_LIUPANSHUI").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_LIUPANSHUI");
			pushRelease(url, id);
			return true;
		}
		if (!PropertiesUtil.getByName(path, "HTTP_QIANDONGNAN").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_QIANDONGNAN");
			pushRelease(url, id);
			return true;
		}
		if (!PropertiesUtil.getByName(path, "HTTP_QIANNAN").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_QIANNAN");
			pushRelease(url, id);

			return true;
		}
		if (!PropertiesUtil.getByName(path, "HTTP_QIANXINAN").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_QIANXINAN");
			pushRelease(url, id);
			return true;
		}
		if (!PropertiesUtil.getByName(path, "HTTP_QUANSHENG").equals("")) {
			url = PropertiesUtil.getByName(path, "HTTP_QUANSHENG") ;
			pushRelease(url, id);
			return true;
		}

		return false;
	}*/

	public static void pushRelease2(String url, String param) throws IOException {
		HttpSender.sendPost(url, param);
	}

	public static void pushRelease(String url, String id) throws IOException {

		ContentInfoService contentInfoService = new ContentInfoService();

		ContentInfo contentInfo = contentInfoService.get(id);

		String param = "";

		if (contentInfo.getId() != null) {
			param += "id=" + contentInfo.getId() + "&";
		}
		if (contentInfo.getCat().getId() != null) {
			param += "cat=" + contentInfo.getCat().getId() + "&";
		}
		if (contentInfo.getTitle() != null) {
			param += "title=" + contentInfo.getTitle() + "&";
		}
		if (contentInfo.getSubtitle() != null) {
			param += "subtitle=" + contentInfo.getSubtitle() + "&";
		}
		if (contentInfo.getContent() != null) {
			param += "content=" + contentInfo.getContent() + "&";
		}
		if (contentInfo.getWebUrl() != null) {
			param += "webUrl=" + contentInfo.getWebUrl() + "&";
		}
		if (contentInfo.getSource() != null) {
			param += "source=" + contentInfo.getSource() + "&";
		}
		if (contentInfo.getKeywords() != null) {
			param += "keywords=" + contentInfo.getKeywords() + "&";
		}
		if (contentInfo.getCreateTime() != null) {
			param += "createTime=" + contentInfo.getCreateTime() + "&";
		}
		if (contentInfo.getUpdater() != null) {
			param += "updateTime=" + contentInfo.getUpdater() + "&";
		}
		if (contentInfo.getLikeTotal() != null) {
			param += "likeTotal=" + contentInfo.getLikeTotal() + "&";
		}
		if (contentInfo.getBrower() != null) {
			param += "brower=" + contentInfo.getBrower() + "&";
		}
		if (contentInfo.getStatus() != null) {
			param += "status=" + contentInfo.getStatus() + "&";
		}
		if (contentInfo.getRecom() != null) {
			param += "recom=" + contentInfo.getRecom() + "&";
		}
		if (contentInfo.getVideo() != null) {
			param += "video=" + contentInfo.getVideo() + "&";
		}
		if (contentInfo.getHref() != null) {
			param += "href=" + contentInfo.getHref() + "&";
		}
		if (contentInfo.getCreater() != null) {
			param += "creater=" + contentInfo.getCreater() + "&";
		}
		if (contentInfo.getUpdater() != null) {
			param += "updater=" + contentInfo.getUpdater() + "&";
		}
		if (contentInfo.getRelease() == 0) {
			param += "release=" + /*contentInfo.getRelease()*/"2";
		}

		HttpSender.sendPost(url,param);

	}
}
