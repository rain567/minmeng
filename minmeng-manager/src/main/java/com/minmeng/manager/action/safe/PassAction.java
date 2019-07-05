package com.minmeng.manager.action.safe;

import org.apache.log4j.Logger;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.Error;
import org.fixwork.util.MD5;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;
import org.fixwork.util.Validations;

import com.minmeng.entity.common.Admin;
import com.minmeng.service.common.AdminService;
import com.minmeng.manager.action.BaseAction;

/**
 * @description 安全管理密码设置
 * @author 杨大江
 * @date 2014-8-22 
 * @version 1.1
 */
@ActionPath(path="/safe/pass/",dir="/WEB-INF/jsp/safe/",description="安全管理密码设置")
public class PassAction extends BaseAction {
	static Logger log = Logger.getLogger(PassAction.class);

	AdminService adminService = new AdminService();
	static String sessionMobileCode = "admin_pwd_mobile_code";
	static String sessionMobile = "admin_pwd_mobile";
	String sessionParam = I18n.i18n.get("SESSION_ADMIN");
	

	/**
	 * 安全设置-填写手机验证码
	 */
	@ActionUri(uri="code([/])?")
	public String code(){
		return "resetpass-code.jsp";
	}

	/**
	 * 安全设置-发送手机验证码
	 */
	@ActionUri(uri="sendCode([/])?")
	public void sendCode(String mobilephone){
		Admin sessionEUser = (Admin) session.getAttribute(sessionParam);
		if(sessionEUser==null){
			printJson(new Error("管理员为空."));
			return;
		}else if(!Validations.isMobilephone(mobilephone)){
			printJson(new Error("手机号码格式不正确，请正确填写重试."));
			return;
		}else if(adminService.getByMobile(mobilephone, sessionEUser.getId()) ==null ){
			printJson(new Error("手机号码未绑定，请正确填写重试."));
			return;
		}
		String mobileCode = String.valueOf((int)((Math.random()*9+1)*100000));
	    String content = new String("你正在使用密码修改功能，您的验证码是：" +
	    						mobileCode + "。请不要把验证码泄露给其他人。"); 
	    log.debug("验证码："+mobileCode);
//	    try {
	    	int result = 1;// SendSms.send(content, mobilephone);
			if(result>0){
				printJson(new Success("成功发送验证码."));
				session.setAttribute(sessionMobileCode, mobileCode);
				session.setAttribute(sessionMobile, mobilephone);
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
	 * 安全设置-修改密码
	 */
	@ActionUri(uri="resetpass([/])?")
	public Object resetpass(String code,String mobilephone){
		put("code", code);
		put("mobilephone", mobilephone);
		return "resetpass.jsp";
	}

	/**
	 * 安全设置-保存修改
	 */
	@ActionUri(uri="savePass([/])?")
	public void savePass(
			String code,
			String mobilephone,
			String password,
			String confirmPassword){
		if(checkCode(code, mobilephone)){
			if(!password.equals(confirmPassword)){
				printJson(new Error("重复密码不正确."));
			}else {
				Admin sessionEUser = (Admin) session.getAttribute(sessionParam);
				if(sessionEUser !=null){
					sessionEUser = adminService.get(sessionEUser.getId());
					sessionEUser.setPassword(MD5.md5(password));
					if(adminService.update(sessionEUser)!=null){
						session.removeAttribute(sessionMobileCode);
						session.removeAttribute(sessionMobile);
						printJson(new Success("修改密码完成，跳转登陆界面."));
					}else {
						printJson(new Error("修改密码失败."));
					}
				}else {
					printJson(new Error("管理员为空."));
				}
			}
		}
	}
	/**
	 * 安全设置-检查验证码
	 */
	@ActionUri(uri="checkCode([/])?")
	public boolean checkCode(String code,String mobilephone){
		String mobileCode = (String)session.getAttribute(sessionMobileCode);
		String mobile = (String)session.getAttribute(sessionMobile);
		Admin sessionEUser = (Admin) session.getAttribute(sessionParam);
		if(sessionEUser==null){
			printJson(new Error("管理员为空."));
			return false;
		}else if(!Validations.isMobilephone(mobilephone)){
			printJson(new Error("手机号码格式不正确，请正确填写重试."));
			return false;
		}else if(adminService.getByMobile(mobilephone, sessionEUser.getId()) ==null ){
			printJson(new Error("手机号码未绑定."));
			return false;
		}else if (StringUtils.isEmpty(code)) {
			printJson(new Error("请填写短信验证码"));
			return false;
		}else if (mobileCode == null || "".equals(mobileCode) || 
				mobile == null || "".equals(mobile)) {
			printJson(new Error("短信验证码已过期"));
			return false;
		}else if(mobile.equals(mobilephone) && code.equals(mobileCode)) {
			// 短信验证码正确
			printJson(new Success("短信验证码正确"));
			return true;
		}else {
			printJson(new Error("短信验证码不正确"));
			return false;
		}
	}

	/**
	 * 安全设置-修改密码
	 */
	@ActionUri(uri="modifypass([/])?")
	public Object modifypass(){
		return "modifypass.jsp";
	}

	/**
	 * 安全设置-保存修改
	 */
	@ActionUri(uri="saveModifyPass([/])?")
	public void saveModifyPass(
			String code,
			String oldpassword,
			String password,
			String confirmPassword){
		if(!identifyCode(code)){
			return;
		}
		if(StringUtils.isEmpty(oldpassword)){
			printJson(new Error("请输入原密码."));
			return ;
		}
		if(!password.equals(confirmPassword)){
			printJson(new Error("重复密码不正确."));
		}else {
			Admin sessionEUser = (Admin) session.getAttribute(sessionParam);
			if(sessionEUser ==null){
				printJson(new Error("管理员为空."));
				return;
			}
			sessionEUser = adminService.login(sessionEUser.getUsername(), oldpassword,sitename);
			if(sessionEUser==null){
				printJson(new Error("原密码不正确."));
				return;
			}
			sessionEUser.setPassword(MD5.md5(password));
			if(adminService.update(sessionEUser)!=null){
				printJson(new Success("修改密码完成，跳转登陆界面."));
			}else {
				printJson(new Error("修改密码失败."));
			}
		}
	}
}
