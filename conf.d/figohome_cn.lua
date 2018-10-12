ngx.log(ngx.ERR,"------>")
ngx.log(ngx.ERR,ngx.var.uri)
ngx.log(ngx.ERR,ngx.var.host)
ngx.log(ngx.ERR,ngx.var.userdomain)
ngx.log(ngx.ERR,ngx.var.backend_uri)
ngx.log(ngx.ERR,ngx.var.request_uri)
ngx.log(ngx.ERR, '>> ERR BY FIGO >>> ')
ngx.var.backend_uri = ngx.var.userdomain..ngx.var.request_uri