package com.minmeng.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletOutputStream;

import org.fixwork.framework.action.Action;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;

import com.minmeng.entity.common.Attach;
import com.minmeng.service.common.AttachService;

@ActionPath(path="/download/")
public class DownloadAction extends Action {

	AttachService service = new AttachService ();

	@ActionUri(uri="([/])?")
	public void download(String f) throws IOException{
		response.reset();
		Attach attach = service.get(f);
		String filePath = attach!=null ? attach.getFilePath():"";
		/* 读取文件 */
		File file = new File(filePath);
		if(!file.exists()){
			print("文件指定路径错误");
			return;
		}
		String contentType = "application/x-msdownload";
		//String filename = URLEncoder.encode(file.getName(), "UTF-8");
		response.reset();
		response.setContentType(contentType);
		response.addHeader("Content-Disposition", "attachment; filename=\"" + new String(file.getName().getBytes("UTF-8"),"iso-8859-1") + "\"");
		int fileLength = (int) file.length();
		response.setContentLength(fileLength);
		/* 如果文件长度大于0 */
		if (fileLength != 0) {
			/* 创建输入流 */
			InputStream inStream = new FileInputStream(file);
			byte[] buf = new byte[4096];
			/* 创建输出流 */
			ServletOutputStream servletOS = response.getOutputStream();
			int readLength;
			while (((readLength = inStream.read(buf)) != -1)) {
				servletOS.write(buf, 0, readLength);
			}
			inStream.close();
			servletOS.flush();
			servletOS.close();
		}
	}

	@Override
	public String onStart() {
		// TODO Auto-generated method stub
		return null;
	}


}
