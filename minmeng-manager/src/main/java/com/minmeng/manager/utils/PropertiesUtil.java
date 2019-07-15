package com.minmeng.manager.utils;

import java.io.InputStream;
import java.util.Properties;

public class PropertiesUtil {
	
	public static String getByName(String path,String name){
		String result=null;
		 InputStream in = PropertiesUtil.class.getClassLoader().getResourceAsStream(path);
		 Properties prop = new Properties(); 
		 try {
			prop.load(in);
			result = prop.getProperty(name).trim();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		 return result;
	}
	
	public static void main(String[] args) {
		
		String path="conf/i18n/zh-CN.properties";
		
		System.out.println(getByName(path, "HTTP_GUIYANG"));
	}
}
