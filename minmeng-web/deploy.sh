#!/bin/sh

# 清空
clear(){
    ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng/resources/ROOT/res/css/mobile/style.css"
    ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng/resources/ROOT/res/css-guiyang/mobile/style.css"
    ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng/resources/ROOT/res/css-bijie/mobile/style.css"
    ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng/resources/ROOT/res/css-liupanshui/mobile/style.css"
    ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng/resources/ROOT/res/css-qiandongnan/mobile/style.css"
    ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng/resources/ROOT/res/css-qianxinan/mobile/style.css"
    ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng/resources/ROOT/res/css-qiannan/mobile/style.css"
    
  #  ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng/web/ROOT/WEB-INF/jsp/mobile/*"
  #  ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng-guiyang/web/ROOT/WEB-INF/jsp/mobile/*"
  #  ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng-bijie/web/ROOT/WEB-INF/jsp/mobile/*"
   # ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng-liupanshui/web/ROOT/WEB-INF/jsp/mobile/*"
  #  ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng-qiandongnan/web/ROOT/WEB-INF/jsp/mobile/*"
  #  ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng-qianxinan/web/ROOT/WEB-INF/jsp/mobile/*"
   # ssh root@mmgzsw.org.cn "rm -rf /data/projects/minmeng-qiannan/web/ROOT/WEB-INF/jsp/mobile/*"
}
# 发送文件到测试服
# Mm2019wjzp
upload(){

    scp -r ../minmeng-resources/src/main/webapp/res/css/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css/mobile/
    scp -r ../minmeng-resources/src/main/webapp/res/css/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-guiyang/mobile/
    scp -r ../minmeng-resources/src/main/webapp/res/css/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-bijie/mobile/
    scp -r ../minmeng-resources/src/main/webapp/res/css/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-liupanshui/mobile/
    scp -r ../minmeng-resources/src/main/webapp/res/css/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-qiandongnan/mobile/
    scp -r ../minmeng-resources/src/main/webapp/res/css/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-qianxinan/mobile/
    scp -r ../minmeng-resources/src/main/webapp/res/css/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-qiannan/mobile/
    
   # scp -r ./src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng/web/ROOT/WEB-INF/jsp/mobile/
   # scp -r ./src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-guiyang/web/ROOT/WEB-INF/jsp/mobile/
   # scp -r ./src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-bijie/web/ROOT/WEB-INF/jsp/mobile/
   # scp -r ./src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-liupanshui/web/ROOT/WEB-INF/jsp/mobile/
   # scp -r ./src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-qiandongnan/web/ROOT/WEB-INF/jsp/mobile/
#scp -r ./src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-qianxinan/web/ROOT/WEB-INF/jsp/mobile/
  #  scp -r ./src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-qiannan/web/ROOT/WEB-INF/jsp/mobile/
}
echo "[exec] 清空"
clear
echo "[exec] 开始上传"
upload
echo "uploaded"
