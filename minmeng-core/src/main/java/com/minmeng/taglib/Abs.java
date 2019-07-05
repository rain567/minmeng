package com.minmeng.taglib;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 取正
 * @author 贵州万嘉：杨大江
 * @version 1.1
 */
public class Abs extends SimpleTagSupport {

	Object number;
	public void doTag() throws JspException, IOException {
		// 输出处理结果到页面上
		if(number instanceof Integer){
			print(""+Math.abs(Integer.valueOf(number.toString())));
		}else if(number instanceof Double){
			print(""+Math.abs(Double.valueOf(number.toString())));
		}else if(number instanceof Long){
			print(""+Math.abs(Long.valueOf(number.toString())));
		}else if(number instanceof Float){
			print(""+Math.abs(Float.valueOf(number.toString())));
		}else{
			print(number.toString());
		}
	}
	
	void print(String out) throws IOException{
		getJspContext().getOut().println(out);
	}

	public Object getNumber() {
		return number;
	}

	public void setNumber(Object number) {
		this.number = number;
	}
	
}
