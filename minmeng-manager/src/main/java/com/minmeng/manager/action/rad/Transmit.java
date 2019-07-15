package com.minmeng.manager.action.rad;


import com.alibaba.fastjson.JSON;
import com.minmeng.entity.cms.ContentAttach;
import com.minmeng.entity.cms.ContentInfo;
import com.minmeng.entity.common.Attach;
import com.minmeng.entity.common.Cat;
import com.minmeng.manager.action.BaseAction;
import com.minmeng.manager.utils.HttpSender;
import com.minmeng.manager.utils.PropertiesUtil;
import com.minmeng.manager.utils.ReleaseUtil;
import com.minmeng.service.cms.ContentAttachService;
import com.minmeng.service.cms.ContentInfoService;
import com.minmeng.service.common.AttachService;
import com.minmeng.service.common.CatService;
import org.apache.http.protocol.HTTP;
import org.fixwork.mapping.ActionPath;
import org.fixwork.mapping.ActionUri;
import org.fixwork.util.StringUtils;
import org.fixwork.util.Success;
import org.fixwork.util.Utils;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

@ActionPath(path="/",dir="/WEB-INF/jsp/")
public class Transmit extends BaseAction {

    ContentInfoService contentInfoService = new ContentInfoService();
    ContentAttachService contentAttachService = new ContentAttachService();
    AttachService attachService = new AttachService();
/*
    @ActionUri(uri="receive2([/])?",description="接收")
    public boolean receive2(ContentInfo contentInfo) throws UnsupportedEncodingException {
        System.out.println(contentInfo);
        return true;
    }*/
    CatService catService = new CatService();
    @ActionUri(uri="edit([/])?",description="获取所有cat")
    public void getCat(String cid,String id) throws IOException {
        Cat cat = catService.get(cid);
        String catType = cat.getCatType();
        response.sendRedirect(path+"/edit1?cid="+cid+"&id="+id);
    }
    @ActionUri(uri="edit1([/])?",description="编辑列表栏目")
    public String edit1(ContentInfo info,String cid){
        Map<String, Object> map = toMapObject(getRequest().getParameterMap());
        cid = (String) map.get("cid");
        put("id", !StringUtils.isEmpty(info.getId())?info.getId(): Utils.createId());
        put("catId",info.getCat()!=null?info.getCat().getId():cid);
        if(info!=null){
            put("info", info);
            String content = info.getContent();
            put("content",!StringUtils.isEmpty(content)? Utils.htmlspecialchars(content):"");
            List<Attach> images = info.getImages();
            if(images!=null ){
                int size = images.size();
                String[] array = new String[size];
                for(int i=0;i<size;i++){
                    Attach image = images.get(i);
                    array[i] = image.getUrl();
                }
                put("images",array);
            }
            List<Attach> files = info.getFiles();
            if(files!=null ){
                int size = files.size();
                String[] array = new String[size];
                for(int i=0;i<size;i++){
                    Attach file = files.get(i);
                    array[i] = file.getUrl();
                }
                put("files",array);
            }
        }
        return "rad/edit.jsp";
    }


    @ActionUri(uri="receive([/])?",description="接收")
    public String receive() throws IOException {
        HttpServletRequest request = getRequest();
        request.setCharacterEncoding("UTF-8");
        BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
        String line = null;
        StringBuilder sb = new StringBuilder();
        while((line = br.readLine())!=null){
            sb.append(line);
        }
        // 将资料解码
        String data = sb.toString();

        String cid = PropertiesUtil.getByName("conf/i18n/zh-CN.properties", "MWYW_CID");
        ContentInfo contentInfo = JSON.parseObject(data, ContentInfo.class);
        Cat cat = new Cat();
        if(cid!=null&&!"".equals(cid.trim())){
            cat.setId(cid);
        }
        contentInfo.setCat(cat);

       /*
        ContentInfo contentInfo = new ContentInfo();
        contentInfo.setId(id);
        Cat cat2 = new Cat();
        contentInfo.setCat(cat2);
        contentInfo.setTitle(title);
        contentInfo.setSubtitle(subtitle);
        contentInfo.setContent(content);
        contentInfo.setWebUrl(webUrl);
        contentInfo.setSource( source);
        contentInfo.setVideo(video);
        contentInfo.setHref(href);
        contentInfo.setKeywords(keywords);
        contentInfo.setCreateTime(createTime);
        contentInfo.setUpdateTime(updateTime);
        contentInfo.setLikeTotal(Integer.valueOf(likeTotal));
        contentInfo.setBrower(Integer.valueOf(brower));
        contentInfo.setStatus(status);
        contentInfo.setRecom(recom);
        contentInfo.setVideo(video);
        contentInfo.setHref(href);
        contentInfo.setCreater(creater);
        contentInfo.setUpdater(updater);
        // 接收
        contentInfo.setRelease(2);
        infoService.save(contentInfo);
        System.out.println("接收成功"+id);*/
        ContentInfo c = contentInfoService.save(contentInfo);
        List<Attach> attaches = contentInfo.getImages();
        if(attaches!=null){
            for(int i = 0 ; i < attaches.size() ; i++) {
                attachService.save(attaches.get(i));
                contentAttachService.save(new ContentAttach(contentInfo.getId(),attaches.get(i).getId()));
            }
        }
        List<Attach> attachess = contentInfo.getFiles();
        if(attachess!=null){
            for(int i = 0 ; i < attachess.size() ; i++) {
                attachService.save(attachess.get(i));
                contentAttachService.save(new ContentAttach(contentInfo.getId(),attachess.get(i).getId()));
            }
        }

        if(c!=null){
            System.out.println("接收成功-------------"+contentInfo.getId());
            return "test";
        }else {
            System.out.println("接收失败-------------");
            return "test00";
        }

    }

    @ActionUri(uri = "release([/])?", description = "推送")
    public boolean release(String idstr) {
        boolean flag = false;
        try {
            Map<String, Object> map = toMapObject(getRequest().getParameterMap());
            idstr = (String) map.get("idstr");
            String[] ids = idstr.split(",");
            for (String id : ids) {
                ContentInfo content = contentInfoService.get(id);
                content.setRelease(2);
                String con = JSON.toJSONString(content);
                String encoderJson = URLEncoder.encode(con, HTTP.UTF_8);
                content.setRelease(1);
                List<String> paths = ReleaseUtil.getRelease();
                for (String path:paths
                     ) {
                    HttpSender.post(path, con);
                }
                contentInfoService.update(content);
                printJson(new Success("推送成功"));

            }
            return true;
        }catch (Exception e){
            e.printStackTrace();
            printJson(new Error("推送失败"));
            return false;
        }
    }

}
