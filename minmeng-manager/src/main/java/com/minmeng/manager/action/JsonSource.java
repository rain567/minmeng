package com.minmeng.manager.action;

import java.util.List;

import org.fixwork.mapping.JSONObjectStr;

/**
 * @Description 菜单JSON源
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-20
 */
@JSONObjectStr("result")
public class JsonSource {
	
	private String id;
	private String name;
	private String url;
	private List<JsonSource> items;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public List<JsonSource> getItems() {
		return items;
	}
	public void setItems(List<JsonSource> items) {
		this.items = items;
	}
	
}
