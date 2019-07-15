package com.minmeng.web.action;

import org.fixwork.framework.action.Action;
import org.fixwork.mapping.ActionUri;

/**
 * @Description 错误Action
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-21
 */
public class ErrorAction extends Action{

	@ActionUri(uri="/404([/])?")
	public String error404(){
		return "/404.jsp";
	}

	@Override
	public String onStart() {
		// TODO Auto-generated method stub
		return null;
	}
}
