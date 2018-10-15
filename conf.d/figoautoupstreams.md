
# upstreams API
## 获取所有的upstream的信息
```
http://figoautoupstreams.me/upstreams
```
## 获取指定upstream的信息
```
http://figoautoupstreams.me/upstreams/{upstream_name}
```
## 获取指定upstream下指定server_name的节点信息
```
http://figoautoupstreams.me/upstreams/{upstream_name}/{server_name}
```
## 指定upstream下指定server_name节点上下线
```
http://figoautoupstreams.me/upstreams/{upstream_name}/{server_name}/down
http://figoautoupstreams.me/upstreams/{upstream_name}/{server_name}/up
```

## 上下架测试命令
```
curl http://figoautoupstreams.me/upstreams/dynamic/127.0.0.1:3456/up
curl http://figoautoupstreams.me/upstreams/dynamic/127.0.0.1:3457/up
curl http://figoautoupstreams.me/upstreams/dynamic/127.0.0.1:3458/up
curl http://figoautoupstreams.me/upstreams/dynamic/127.0.0.1:3456/down
curl http://figoautoupstreams.me/upstreams/dynamic/127.0.0.1:3457/down
curl http://figoautoupstreams.me/upstreams/dynamic/127.0.0.1:3458/down
```
测试网站如下
```
curl http://figoautoupstreams.me/figo/hello
```
* 上下架upstream，可以实现动态更换后台的效果

## 扩展思考
* 在线上部署脚本时，可以使用上下架的命令
* 配合bash shell里的sleep $second 来让给下架程序提供冷却时间
```
echo "start"
sleep 60
echo "end"
```
* 可以试验验证上述上下架程序的平滑性

## lua-upstream-nginx-module
https://github.com/openresty/lua-upstream-nginx-module
* 目前只能固定配置好upstream，进行上下架处理
* 后续lua-upstream支持，可以考虑使用 add 方法，动态扩展upstream 的peer
* 运营，则需要把/upstreams的api使用内网能访问的server_name进行配置，避免被公网操纵