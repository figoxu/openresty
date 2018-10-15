local cjson = require "cjson"
local upstream = require "ngx.upstream"
local get_servers = upstream.get_servers
local get_upstreams = upstream.get_upstreams
local get_primary_peers = upstream.get_primary_peers
local get_backup_peers = upstream.get_backup_peers
local set_peer_down = upstream.set_peer_down
local concat = table.concat


-- 字符串分隔方法
function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function (c) fields[#fields + 1] = c end)
    return fields
end

-- get all upstream config block
local function get_all_upstream()
    local us = get_upstreams()
    local upstreams = {}

    for _, u in ipairs(us) do
        local srvs = get_servers(u)
        upstreams[u] = srvs
    end

    return upstreams
end

-- 获取某个upstream下的所有Server
local function get_servers_by_upstream_name(upstream_name)
    local up = get_all_upstream()[upstream_name]
    if not up then
        return {}
    end

    return up
end

-- 获取所有的 peer
local function get_all_peers(upstream_name)
    local primary_peers = get_primary_peers(upstream_name)
    --	local backup_peers = get_backup_peers(upstream_name)
    --
    --	local primary_cnt = table.getn(primary_peers)
    --	local backup_cnt = table.getn(backup_peers)
    --
    --	local total = table.getn(primary_peers) + table.getn(backup_peers)
    --	local all_peers = {}
    --
    --	for i = primary_cnt + 1, total do
    --		backup_peers[i - primary_cnt]["backup"] = true
    --		table.insert(primary_peers, i, backup_peers[i - primary_cnt])
    --	end
    --
    return primary_peers
end

-- 操作Server节点上下线
local function op_server(upstream_name, server_name, op)
    -- ngx.say(cjson.encode(get_all_peers(upstream_name)))
    local all_peers = get_all_peers(upstream_name)
    for i, peer in ipairs(all_peers) do
        if peer["name"] == server_name then
            target_peer = peer
            break
        end
    end

    if target_peer == nil then
        ngx.say(cjson.encode({code = "E00001", msg = "error peer name"}))
    else
        if op == "down" then
            down_value = true
        else
            down_value = false
        end

        local is_back_up = target_peer["backup"] or false
        set_peer_down(upstream_name, is_back_up, target_peer["id"], down_value)
        ngx.say(cjson.encode({code = "A00000", msg = "Success"}))
    end
end

local http_method = ngx.req.get_method()
local sub_uris = ngx.var.uri:split("/")

-- 节点上下线
if table.getn(sub_uris) == 4 then
    op_server(sub_uris[2], sub_uris[3], sub_uris[4])
end

-- 获取master or backup nodes
if table.getn(sub_uris) == 3 then
    if sub_uris[3] == "primary" then
        ngx.say(cjson.encode(get_primary_peers(sub_uris[2])))
    else
        ngx.say(cjson.encode(get_backup_peers(sub_uris[2])))
    end
    ngx.exit(ngx.HTTP_OK)
end

-- 获取所有upstream or 指定名称的upstream
if sub_uris[2] then
    ngx.say(cjson.encode(get_all_peers(sub_uris[2])))
else
    ngx.say(cjson.encode(get_all_upstream()))
end