package com.minmeng.web.action;

import com.minmeng.entity.common.Attach;
import com.minmeng.service.common.AttachService;
import org.apache.log4j.Logger;
import org.fixwork.framework.action.Action;
import org.fixwork.framework.i18n.I18n;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;

import java.io.*;
import java.nio.channels.FileChannel;


@ActionPath(path = "/reader/")
public class ReaderAction extends Action {
    final static Logger log = Logger.getLogger(Reader.class);
    String savePath = I18n.i18n.get("ATTACH_SAVE_PATH");
    AttachService service = new AttachService();

    @ActionUri(uri = "([/])?")
    public void reader(String[] f) {


        f = getRequest().getParameterMap().get("f");
        for (String fid : f) {
            response.reset();
            Attach attach = service.get(fid);
            String filePath = attach != null ? attach.getFilePath() : "";
            /* 读取文件 */
            File file = new File(filePath);
            if (!file.exists()) {
                print("文件指定路径错误");
                return;
            }
            //检查扩展名
            String fileExt = file.getName().substring(file.getName().lastIndexOf(".") + 1).toLowerCase();
            response.setContentType("application/" + fileExt + ";charset=utf-8");
            OutputStream out;
            try {
                //out = response.getOutputStream();//响应输出流
                FileInputStream is = new FileInputStream(file);//文件读取流
                FileChannel channel = is.getChannel();//文件通道

                //WritableByteChannel channel_out = Channels.newChannel(out);//响应输出通道
                //channel.transferTo(0, channel.size(), channel_out);//将文件通道转给响应通道进行输出

                // out.flush();
                //out.close();

            } catch (IOException e) {
                print("文件读取错误,信息：" + e.getMessage());
            } finally {

            }
        }

    }

    @Override
    public String onStart() {
        // TODO Auto-generated method stub
        return null;
    }


}
