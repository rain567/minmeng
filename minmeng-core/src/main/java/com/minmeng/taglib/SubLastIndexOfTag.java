package com.minmeng.taglib;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class SubLastIndexOfTag  extends SimpleTagSupport {
	String source = "";// 源
	String regex = "";
	
	public void doTag() throws JspException, IOException {
		
		String result = "";
		if(source.lastIndexOf(regex) != -1)
			result = source.substring(source.lastIndexOf(regex) +1,source.length());
		// 输出处理结果到页面上
		getJspContext().getOut().println(result);
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getRegex() {
		return regex;
	}

	public void setRegex(String regex) {
		this.regex = regex;
	}
	
}
