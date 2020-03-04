#!/bin/bash


USER=`whoami`

#彩色的看着舒服点
red() {
  echo -e "\033[31m$1\033[0m \c"
}

green() {
  echo -e "\033[32m$1\033[0m \c"
}

blue() {
  echo -e "\033[34m$1\033[0m \c"
}

blue "### Welcome to Google Cloud Shell Auto Deploy Script ###";echo
green "FBI WARNING: 这只是个弱鸡脚本，高手勿喷哦~ -- By guleon.";echo

red "几点提示:
1、请用普通用户执行
2、要有一台服务器运行frp，国内的就行，用来内网穿透(不懂的：www.baidu.com)
PS:frp的服务端口默认是7000，修改路径如下$HOME/.gcs/etc/frp/frpc.ini
3、这个脚本执行一次就行了，下次使用只需要登录shell就行，不怕重置
4、环境部署好之后，在系统/SwichyOmega 添加socks5代理就行
5、如果一点不懂linux的，建议先学学linux再玩
";echo

green "能行吗?[Y/n]："
read confirm

if [[ x$confirm == x || $confirm == "y" || $confirm == "Y" ]]
then
  green "好嘞 ...";echo
else
  red "拜拜了您嘞...";echo
  exit 0
fi


# 请用普通用户执行
if [[ $USER == "root" ]]
then
  red "请用普通用户执行！";echo
  blue "输入：su 用户名";echo
  exit 1
fi

if [[ -d $HOME/.gcs ]]
then
  green "兄弟，老实交代是不是安装过了,要重新安装吗？[Y/n]"
  read confirm
  
  if [[ x$confirm == x || $confirm == "y" || $confirm == "Y" ]]
  then
    cd $HOME
    kill -9 `pidof v2ray` 2>/dev/null
    kill -9 `pidof frpc` 2>/dev/null
    rm -fr .gcs gcs-auto 2>/dev/null
    mv .bashrc_bak .bashrc
  else
    green "拜拜";echo
    exit 0
fi

green "tell me 代理服务器ip："
read proxy_addr

green "端口号呢："
read proxy_port

red "再次提示：请确认[$proxy_addr]上运行了frp，并开放了[$proxy_port]端口";echo
green "确定?[Y/n]："
read confirm

if [[ x$confirm == x || $confirm == "y" || $confirm == "Y" ]]
then
  green "别急，安装马上开始 ...";echo
else
  red "兄弟，有缘债见...";echo
  exit 1
fi
cd $HOME

blue "下载需要的东西 ...";echo

git clone https://github.com/guleonseon/gcs-auto.git

sleep 2

blue "正在配置环境... ";echo

if [[ -f $HOME/.bashrc ]]
then
  cp $HOME/.bashrc $HOME/.bashrc_bak
fi

#copy .gcs to $HOME
cp -r gcs-auto/.gcs $HOME

#配置frpc
frpconf=$HOME/.gcs/etc/frp/frpc.ini
sed -i "s/8.8.8.8/$proxy_addr/g" $frpconf
sed -i "s/55555/$proxy_port/g" $frpconf

#配置自动运行
cat gcs-auto/profile >> .bashrc
sleep 1
source .bashrc

green "下一步要干嘛？容我思考2秒钟";echo
sleep 2

frp_pid=`pidof frpc`
v2ray_pid=`pidof v2ray`

if [[ x$frp_pid == x || x$v2ray_pid == x ]]
then
  red "糟糕，我有种不详的预感，自己找找原因，咱先撤了！";echo
else
  green "额...环境部署好了, Enjoy it!";echo
fi


