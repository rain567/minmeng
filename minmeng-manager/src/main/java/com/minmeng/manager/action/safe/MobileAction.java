package com.minmeng.manager.action.safe;

import org.apache.log4j.Logger;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.Error;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;
import org.fixwork.util.Validations;

import com.minmeng.entity.common.Admin;
import com.minmeng.service.common.AdminService;
import com.minmeng.manager.action.BaseAction;

/**
 * @description 安全管理手机绑定设置
 * @author 杨大江
 * @date 2014-8-22 
 * @version 1.1
 */
@ActionPath(path="/safe/mobile/",dir="/WEB-INF/jsp/safe/",description="安全管理手机绑定设置")
public class MobileAction extends BaseAction {
	static Logger log = Logger.getLogger(MobileAction.class);

	AdminService adminService = new AdminService();
	static String sessionMobileCode = "admin_bind_mobile_code";
	static String sessionMobile = "admin_bind_mobile";
	static String sessionNewMobileCode = "admin_new_mobile_code";
	static String sessionNewMobile = "admin_new_mobile";
	String sessionParam = I18n.i18n.get("SESSION_ADMIN");
	

	/**
	 * 安全设置-填写原手机验证码
	 */
	@ActionUri(uri="bindmobile([/])?")
	public String code(){
		return "bindmobile.jsp";
	}

	/**
	 * 安全设置-发送原手机验证码
	 */
	@ActionUri(uri="sendCode([/])?")
	public void sendCode(String mobile){
		log.debug("发送原手机验证码:"+mobile);
		Admin admin = (Admin) session.getAttribute(sessionParam);
		if(admin==null){
			printJson(new Error("管理员为空."));
			return;
		}else if(!Validations.isMobilephone(mobile)){
			printJson(new Error("手机号码格式不正确，请正确填写重试."));
			return;
		}else if(adminService.getByMobile(mobile, admin.getId()) ==null ){
			printJson(new Error("手机号码未绑定，请正确填写重试."));
			return;
		}
		String mobileCode = String.valueOf((int)((Math.random()*9+1)*100000));
	    String content = new String("你正在使用解除手机绑定功能，您的验证码是：" +
	    						mobileCode + "。请不要把验证码泄露给其他人。"); 
	    log.debug("验证码："+mobileCode);
//	    try {
	    	int result = 1;// SendSms.send(content, mobilephone);
			if(result>0){
				printJson(new Success("成功发送验证码."));
				session.setAttribute(sessionMobileCode, mobileCode);
				session.setAttribute(sessionMobile, mobile);
				session.setMaxInactiveInterval(1000*2); // 保存时长为30分钟
			}else {
				printJson(new Error("发送验证码失败，重新发送.错误代码："+result));
			}
//		} catch (HttpException e) {
//			printJson(new Error("发送验证码失败，HTTP异常，重新发送"));
//		} catch (IOException e) {
//			printJson(new Error("发送验证码失败，IO异常，重新发送"));
//		}
	}
	/**
	 * 安全设置-填写新手机验证证
	 */
	@ActionUri(uri="newmobile([/])?")
	public Object newmobile(String bindCode,String bindMobile){
		put("bindCode", bindCode);
		put("bindMobile", bindMobile);
		return "newmobile.jsp";
	}

	/**
	 * 安全设置-发送新手机验证码
	 */
	@ActionUri(uri="sendNewCode([/])?")
	public void sendNewCode(String mobile){
		Admin admin = (Admin) session.getAttribute(sessionParam);
		if(admin==null){
			printJson(new Error("管理员为空."));
			return;
		}else if(!Validations.isMobilephone(mobile)){
			printJson(new Error("手机号码格式不正确，请正确填写重试."));
			return;
		}else if(adminService.existsMobile(mobile)){
			printJson(new Error("手机号已绑定."));
			return;
		}
		
		String mobileCode = String.valueOf((int)((Math.random()*9+1)*100000));
	    String content = new String("你正在使用绑定手机功能，您的验证码是：" +
	    						mobileCode + "。请不要把验证码泄露给其他人。"); 
	    log.debug("验证码："+mobileCode);
//	    try {
	    	int result = 1;// SendSms.send(content, mobilephone);
			if(result>0){
				printJson(new Success("成功发送验证码."));
				session.setAttribute(sessionNewMobileCode, mobileCode);
				session.setAttribute(sessionNewMobile, mobile);
				session.setMaxInactiveInterval(1000*2); // 保存时长为30分钟
			}else {
				printJson(new Error("发送验证码失败，重新发送.错误代码："+result));
			}
//		} catch (HttpException e) {
//			printJson(new Error("发送验证码失败，HTTP异常，重新发送"));
//		} catch (IOException e) {
//			printJson(new Error("发送验证码失败，IO异常，重新发送"));
//		}
	}
	
	/**
	 * 安全设置-保存新手机
	 */
	@ActionUri(uri="saveNewMobile([/])?")
	public void saveNewMobile(String code,String mobile,String bindCode,String bindMobile){
		if(checkAllCode(code, mobile,bindCode,bindMobile)){
			Admin admin = (Admin) session.getAttribute(sessionParam);
			if(admin !=null){
				admin = adminService.get(admin.getId());
				admin.setMobile(mobile);
				if(adminService.update(admin)!=null){
					session.removeAttribute(sessionMobileCode);
					session.removeAttribute(sessionMobile);
					session.removeAttribute(sessionNewMobileCode);
					session.removeAttribute(sessionNewMobile);
					printJson(new Success("手机绑定完成，跳转登陆界面."));
				}else {
					printJson(new Error("手机绑定失败."));
				}
			}else {
				printJson(new Error("管理员为空."));
			}
		}
	}
	/**
	 * 安全设置-检查原手机及验证码
	 */
	@ActionUri(uri="checkBindCode([/])?")
	public boolean checkBindCode(String bindCode,String bindMobile){
		String bindSessionMC = (String)session.getAttribute(sessionMobileCode);
		String bindSessionM = (String)session.getAttribute(sessionMobile);
		Admin admin = (Admin) session.getAttribute(sessionParam);
		if(admin==null){
			printJson(new Error("管理员为空."));
			return false;
		}else if(!Validations.isMobilephone(bindMobile) ){
			printJson(new Error("手机号码格式不正确，请正确填写重试."));
			return false;
		}else if (StringUtils.isEmpty(bindCode)) {
			printJson(new Error("请填写短信验证码"));
			return false;
		}else if (bindCode.equals(bindSessionMC) && 
				bindMobile.equals(bindSessionM)) {
			// 短信验证码正确
			printJson(new Success("短信验证码正确"));
			return true;
		}else {
			printJson(new Error("短信验证码不正确或已过期"));
			return false;
		}
	}
	/**
	 * 安全设置-检查原手机与新手机及验证码
	 */
	@ActionUri(uri="checkAllCode([/])?")
	public boolean checkAllCode(String code,String mobile,String bindCode,String bindMobile){
		String bindSessionC = (String)session.getAttribute(sessionMobileCode);
		String bindSessionM = (String)session.getAttribute(sessionMobile);
		String newSessionC = (String)session.getAttribute(sessionNewMobileCode);
		String newSessionM = (String)session.getAttribute(sessionNewMobile);
		Admin admin = (Admin) session.getAttribute(sessionParam);
		log.debug("检查原手机与新手机及验证码:bindMobile="+bindMobile+";mobile"+mobile);
		if(admin==null){
			printJson(new Error("管理员为空."));
			return false;
		}else if(!Validations.isMobilephone(bindMobile) || !Validations.isMobilephone(mobile)){
			printJson(new Error("手机号码格式不正确，请正确填写重试."));
			return false;
		}else if (StringUtils.isEmpty(code) || StringUtils.isEmpty(bindCode)) {
			printJson(new Error("请填写短信验证码"));
			return false;
		}else if (bindCode.equals(bindSessionC) && 
				bindMobile.equals(bindSessionM) && 
				code.equals(newSessionC) &&
				mobile.equals(newSessionM)) {
			// 短信验证码正确
			printJson(new Success("短信验证码正确"));
			return true;
		}else {
			printJson(new Error("短信验证码不正确或已过期"));
			return false;
		}
	}
}
