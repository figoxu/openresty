# openresty_praticse

## install
http://openresty.org/en/installation.html
```
brew install openresty/brew/openresty
```
安装完位于： /usr/local/Cellar/openresty/1.11.2.5 目录下

## openresty的常用命令
* /usr/local/Cellar/openresty/1.11.2.5/start.sh 启动openresty
* /usr/local/Cellar/openresty/1.11.2.5/reload.sh 重新加载openresty
* /usr/local/Cellar/openresty/1.11.2.5/test.sh 测试openresty的配置

## 二级域名范例
* 在hosts里配置  figo.figohome.me   henry.figohome.me 指向 127.0.0.1 用于测试
* 通过 http://henry.figohome.me/  , http://figo.figohome.me/ 访问测试网页