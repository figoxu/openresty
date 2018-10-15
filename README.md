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


## 二级域名Lua范例
* 在hosts里配置
```
127.0.0.1  figo.figohome.cn
127.0.0.1  henry.figohome.cn
```
* 通过 http://henry.figohome.cn/  , http://figo.figohome.cn/ 访问测试网页

## 基于OpenResty的网站开发框架
* http://lor.sumory.com/

## upstream使用balancer_by_lua来进行设置
https://blog.csdn.net/zyt425916200/article/details/78113547
https://openresty-reference.readthedocs.io/en/latest/Directives/#balancer_by_lua_file
* openresty相关文档： https://openresty-reference.readthedocs.io/en/latest/Lua_Nginx_API/

## OpenResty动态上下架
https://leokongwq.github.io/2018/01/31/openresty-health-check-dynamic-up-down.html
* 健康检查 http://blog.51cto.com/quietmadman/1725302
* conf.d/figoautoupstreams.conf