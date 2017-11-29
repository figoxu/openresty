ngx.say("hello world , said by figo,how r u. that is way i like it")
local headers = ngx.req.get_headers()  
for k,v in pairs(headers) do  
    if type(v) == "table" then  
        ngx.say(k, " : ", table.concat(v, ","), "<br/>")  
    else  
        ngx.say(k, " : ", v, "<br/>")  
    end  
end  

local authStr=headers["authorization"]
ngx.say("basic_auth is :",authStr)

function split(szFullString, szSeparator)  
    local nFindStartIndex = 1  
    local nSplitIndex = 1  
    local nSplitArray = {}  
    while true do  
       local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
       if not nFindLastIndex then  
        nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
        break  
       end  
       nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
       nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
       nSplitIndex = nSplitIndex + 1  
    end  
    return nSplitArray  
end  

local authCode = split(authStr," ")[2]
ngx.say("basic_auth decode is :",ngx.decode_base64(authCode))

local userInfo = split(ngx.decode_base64(authCode),":")
ngx.say("@id:",userInfo[1],"@pwd:",userInfo[2])

ngx.say(userInfo[1]+1000000)

