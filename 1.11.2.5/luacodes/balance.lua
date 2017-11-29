local balancer = require "ngx.balancer"      
local port = {8088, 8089}      
local backend = ""    
local dvid = ngx.req.get_uri_args()["dvid"] or 0  
ngx.log(ngx.ERR, "dvid=", dvid)  
local hash = (dvid % 2) + 1     
ngx.log(ngx.ERR, "hash=", hash)  
backend = port[hash]    
ngx.log(ngx.ERR, "backend=", backend)  
ngx.log(ngx.ERR, "dvid=", dvid, " hash=", hash, " up=", backend)    
local ok, err = balancer.set_current_peer("127.0.0.1", backend)    
if not ok then    
    ngx.log(ngx.ERR, "failed to set the current peer: ", err)    
    return ngx.exit(500)    
end    
ngx.log(ngx.DEBUG, "current peer ", backend) 