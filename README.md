# Google Cloud Shell Auto Deploy

一键部署 `google cloud shell` 以下简称 `gcs` 科学上网的脚本

## 几点提示：
- 1、一定要有个服务器，由于用于`gcs`外部有安全组，直接访问是访问不了的，需要内网穿透 (服务器只要有能访问的固定的ip地址和端口就行)
- 2、脚本执行前先切换到普通用户，程序是安装到5GB永久磁盘里的，里面内容不会重置
- 3、安装完程序后，断线或外部vm重置后无需重新安装，只要登录`gcs`后，服务程序会自动执行
- 4、本脚本只保证支持当前版本的`gcs`，其他shell可自行研究、修改

## 安装步骤

### 1、登录`gcs`
[google cloud shell](https://ssh.cloud.google.com/)

### 2、执行以下代码
`bash <(curl -s -L https://raw.githubusercontent.com/guleonseon/gcs-auto/master/install.sh)`

#### PS:如果脚本执行提示成功，可跳至步骤

### 3、[optional]修改自定义配置文件
`cd $HOME/.gcs/etc`
修改中...emmmm...
修改完成！(假装...)
#### 注意: `v2ray-server.ini`里的`port`要和`frpc.ini`里的`local_port`一致
#### `frpc.ini`里的`server_port`要和你代理服务器上的frp的端口保持一致

#### 4、愉快的科学上网
在系统代理或者chrome的[SwithyOmega](https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif)配置你的代理服务器和端口，注意选择`socks5`

#### 结束，撒花

