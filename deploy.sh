
# 清空目录
remove(){
    echo "[exec]清空服务目录"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng/web/ROOT/WEB-INF/jsp/mobile/*"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng/resources/ROOT/res/css/mobile/style.css"
}
# 发送文件
upload(){
    echo "[exec]发送文件"
    scp -r ./minmeng-web/src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng/web/ROOT/WEB-INF/jsp/mobile/
    scp -r ./minmeng-web/src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-bijie/web/ROOT/WEB-INF/jsp/mobile/
    scp -r ./minmeng-web/src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-guiyang/web/ROOT/WEB-INF/jsp/mobile/
    scp -r ./minmeng-web/src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-liupanshui/web/ROOT/WEB-INF/jsp/mobile/
    scp -r ./minmeng-web/src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-qiandongnan/web/ROOT/WEB-INF/jsp/mobile/
    scp -r ./minmeng-web/src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-qianxinan/web/ROOT/WEB-INF/jsp/mobile/
    scp -r ./minmeng-web/src/main/webapp/WEB-INF/jsp/mobile/* root@mmgzsw.org.cn:/data/projects/minmeng-qiannan/web/ROOT/WEB-INF/jsp/mobile/


    scp -r ./minmeng-resources/src/main/webapp/res/css/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css/mobile/
    scp -r ./minmeng-resources/src/main/webapp/res/css-guiyang/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-guiyang/mobile/
    scp -r ./minmeng-resources/src/main/webapp/res/css-bijie/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-bijie/mobile/
    scp -r ./minmeng-resources/src/main/webapp/res/css-liupanshui/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-liupanshui/mobile/
    scp -r ./minmeng-resources/src/main/webapp/res/css-qiandongnan/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-qiandongnan/mobile/
    scp -r ./minmeng-resources/src/main/webapp/res/css-qianxinan/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-qianxinan/mobile/
    scp -r ./minmeng-resources/src/main/webapp/res/css-qiannan/mobile/style.css root@mmgzsw.org.cn:/data/projects/minmeng/resources/ROOT/res/css-qiannan/mobile/

}
# 发送文件
start(){
    echo "[exec]启动服务器"
    ssh root@gzztctx.com "cd /home/projects/ssip/site/"
    ssh root@gzztctx.com "node /home/projects/ssip/site/server.js"
}
echo '[exe]打包项目'
remove
upload

#nohup node > logs/node.log &