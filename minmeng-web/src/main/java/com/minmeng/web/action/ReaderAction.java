package com.minmeng.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Reader;
import java.nio.channels.Channels;
import java.nio.channels.FileChannel;
import java.nio.channels.WritableByteChannel;

import org.apache.log4j.Logger;
import com.j2mvc.framework.action.Action;
import com.j2mvc.framework.i18n.I18n;
import com.j2mvc.framework.mapping.ActionPath;
import com.j2mvc.framework.mapping.ActionUri;

import com.minmeng.entity.common.Attach;
import com.minmeng.service.common.AttachService;


@ActionPath(path="/reader/")
public class ReaderAction  extends Action {
	final static Logger log = Logger.getLogger(Reader.class);
	String savePath = I18n.i18n.get("ATTACH_SAVE_PATH");
	AttachService service = new AttachService ();

	@ActionUri(uri="([/])?")
	public void reader(String f){
		response.reset();
		Attach attach = service.get(f);
		String filePath = attach!=null ? attach.getFilePath():"";
		/* 读取文件 */
		File file = new File(filePath);
		if(!file.exists()){
			print("文件指定路径错误");
			return;
		}
		//检查扩展名
		String fileExt = file.getName().substring(file.getName().lastIndexOf(".") + 1).toLowerCase();
        response.setContentType("application/"+fileExt+";charset=utf-8");  
        OutputStream out;
		try {
			out = response.getOutputStream();//响应输出流  
			FileInputStream is = new FileInputStream(file);//文件读取流  
	        FileChannel channel = is.getChannel();//文件通道  
	  
	        WritableByteChannel channel_out = Channels.newChannel(out);//响应输出通道  
	        channel.transferTo(0,channel.size(),channel_out);//将文件通道转给响应通道进行输出  
	          
	        out.flush();  
	        out.close();
		} catch (IOException e) {
			print("文件读取错误,信息："+e.getMessage());
		}  

	}

	@Override
	public String onStart() {
		// TODO Auto-generated method stub
		return null;
	}


}
