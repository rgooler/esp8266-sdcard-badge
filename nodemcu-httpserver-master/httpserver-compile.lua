-- httpserver-compile.lua
-- Part of nodemcu-httpserver, compiles server code after upload.
-- Author: Marcos Kirsch

local compileAndRemoveIfNeeded = function(f)
   if file.open(f .. ".lua") then
      file.close()
      print('Compiling:', f)
      file.remove(f .. ".lc")
      node.compile(f .. ".lua")
      file.remove(f .. ".lua")
      collectgarbage()
   end
end

local serverFiles = {
   'httpserver',
   'httpserver-b64decode',
   'httpserver-basicauth',
   'httpserver-compile',
   'httpserver-conf',
   'httpserver-connection',
   'httpserver-error',
   'httpserver-header',
   'httpserver-init',
   'httpserver-request',
   'httpserver-static',
   'httpserver-wifi',
}
for i, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil
collectgarbage()

