statusd_my = { interval = 100 }
local my_timer = statusd.create_timer()

local function update_my()
   local f = io.popen('~/.ion3/status.sh', 'r')
   local output = f:read('*l')
   f:close()

   statusd.inform("my", output)
   my_timer:set(statusd_my.interval, update_my)
end

update_my()
