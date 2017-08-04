function starts(String,Start)
  return string.sub(String,1,string.len(Start)) == Start
end

return function (connection, req, args)
    collectgarbage()
    dofile("httpserver-header.lc")(connection, 200, 'json')
	connection:send('{')

	local mbOffset = nil
	local mbLen = nil
	local mbData = nil
	local mbCmd = nil
	local mbFilename = nil
	local fieldsCount = 0
	local fileSize = 0
	local i = 0
	local binaryData = ''
	local currentByte = nil
	
    for name, value in pairs(args) do
    	fieldsCount = fieldsCount + 1
        if (name == "offset") then
			mbOffset = tonumber(value, 10)
		elseif (name == "len") then
			mbLen = tonumber(value, 10)
		elseif (name == "data") then
			mbData = value
		elseif (name == "filename") then
			mbFilename = value
		elseif (name == "filesize") then
			fileSize = tonumber(value, 10)
		elseif (name == "cmd") then
			mbCmd = value
		else
			fieldsCount = fieldsCount - 1
		end
    end
	
	if (mbCmd == 'upload') then
		if (fieldsCount > 5) then
			local outfile = mbFilename
			if string.len(mbFilename) > 11 then
			    outfile = 'http.' .. string.sub(mbFilename,0,8) .. string.sub(mbFilename,-4,-1)
			else
				outfile = 'http.' .. mbFilename
			end
			if (mbFilename ~= 'upload.lc') then
				connection:send('"offset":"' .. mbOffset .. '",')
				connection:send('"len":"' .. mbLen .. '",')
				connection:send('"filename":"' .. mbFilename .. '"')
				

				
				for i=1,string.len(mbData),2 do
					currentByte = tonumber(string.sub(mbData, i, i + 1), 16)
					binaryData = binaryData .. string.char(currentByte)
				end
				
				if (mbOffset > 0) then
					file.open(outfile .. '.dnl','a+')
				else			
					file.open(outfile .. '.dnl','w+')
				end
				file.seek("set", mbOffset)
				file.write(binaryData)				
				file.close()
				
				binaryData = nil
				
				if (fileSize == mbLen + mbOffset) then
						
				
					if (mbFilename == 'upload.lua') then
						-- nothing
					elseif (mbFilename == 'upload.lc') then
						-- nothing
					elseif (mbFilename == 'index.html') then
						-- nothing
					elseif (mbFilename == 'index.html.gz') then
						-- nothing
					elseif (string.sub(mbFilename, -4) == '.lua' ) then
						-- file.remove(string.sub(mbFilename, 0, -3) .. "lc")
						-- node.compile(mbFilename)
						-- file.remove(mbFilename)
					elseif (string.sub(mbFilename, -4) == '.lc') then
						-- file.remove(string.sub(mbFilename, 0, -3) .. "lc")
						-- node.compile(mbFilename)
						-- file.remove(mbFilename)
					else
						--file.remove(mbFilename)					
					    file.rename(outfile .. '.dnl', outfile)
					    file.remove(outfile .. '.dnl')
					end
				end		
			end
		end
	elseif (mbCmd == 'list') then
		local remaining, used, total=file.fsinfo()

		local headerExist = 0
		
		connection:send('"files":{')
		
		for name, size in pairs(file.list()) do
			
			if starts(name, "http.") then
				local url = string.sub(name, 6, string.len(name))

				if (url == 'upload.lua') then
					-- nothing
				elseif (url == 'upload.lc') then
					-- nothing
				elseif (url == 'index.html') then
					-- nothing
				elseif (url == 'index.html.gz') then
					-- nothing
				else
					if (headerExist > 0) then 
						connection:send(',')
					end
										
					connection:send('"' .. url .. '":"' .. size .. '"')
				
					headerExist = 1
				end
			end
		end
		
		connection:send('},')
		
		connection:send('"total":"' .. total .. '",')
		connection:send('"used":"' .. used .. '",')
		connection:send('"free":"' .. remaining .. '"')
	end
	
	connection:send('}')	
	collectgarbage()
end