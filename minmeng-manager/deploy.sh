
# 清空目录
remove(){
    echo "[exec]清空服务目录"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng/indexed/*"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-bijie/indexed/*"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-guiyang/indexed/*"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-liupanshui/indexed/*"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-qiandongnan/indexed/*"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-qianxinan/indexed/*"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-qiannan/indexed/*"
   
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/BaseAction.class"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-bijie/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/BaseAction.class"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-guiyang/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/BaseAction.class"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-liupanshui/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/BaseAction.class"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-qiandongnan/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/BaseAction.class"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-qianxinan/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/BaseAction.class"
    ssh root@mmgzsw.org.cn "rm -rf remote:/data/projects/minmeng-qiannan/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/BaseAction.class"
}
# 发送文件
upload(){
    echo "[exec]发送文件"
    scp -r ./target/classes/com/minmeng/manager/action/BaseAction.class root@mmgzsw.org.cn:/data/projects/minmeng/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/
    scp -r ./target/classes/com/minmeng/manager/action/BaseAction.class root@mmgzsw.org.cn:/data/projects/minmeng-bijie/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/
    scp -r ./target/classes/com/minmeng/manager/action/BaseAction.class root@mmgzsw.org.cn:/data/projects/minmeng-guiyang/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/
    scp -r ./target/classes/com/minmeng/manager/action/BaseAction.class root@mmgzsw.org.cn:/data/projects/minmeng-liupanshui/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/
    scp -r ./target/classes/com/minmeng/manager/action/BaseAction.class root@mmgzsw.org.cn:/data/projects/minmeng-qiandongnan/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/
    scp -r ./target/classes/com/minmeng/manager/action/BaseAction.class root@mmgzsw.org.cn:/data/projects/minmeng-qianxinan/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/
    scp -r ./target/classes/com/minmeng/manager/action/BaseAction.class root@mmgzsw.org.cn:/data/projects/minmeng-qiannan/manager/ROOT/WEB-INF/classes/com/minmeng/manager/action/

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