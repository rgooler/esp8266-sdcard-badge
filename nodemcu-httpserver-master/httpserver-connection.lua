-- httpserver-connection
-- Part of nodemcu-httpserver, provides a buffered connection object that can handle multiple
-- consecutive send() calls, and buffers small payloads to send once they get big.
-- For this to work, it must be used from a coroutine and owner is responsible for the final
-- flush() and for closing the connection.
-- Author: Philip Gladstone, Marcos Kirsch

BufferedConnection = {}

-- parameter is the nodemcu-firmware connection
function BufferedConnection:new(connection)
   print('httpserver-connection:BufferedConnection:new')
   local newInstance = {}
   newInstance.connection = connection
   newInstance.size = 0
   newInstance.data = {}

   -- Returns true if there was any data to be sent.
   function newInstance:flush()
      print('httpserver-connection:newInstance:flush')
      if self.size > 0 then
         self.connection:send(table.concat(self.data, ""))
         self.data = {}
         self.size = 0
         return true
      end
      return false
   end

   function newInstance:getpeer()
      print('httpserver-connection:newInstance:getpeer')
      return self.connection:getpeer()
   end

   function newInstance:send(payload)
      print('httpserver-connection:newInstance:send')
      print(payload)
      print(payload:len())
      print(self.size)
      local flushThreshold = 1400
      print("flushThreshold="..flushThreshold)
      local newSize = self.size + payload:len()
      print("newSize="..newSize)
      while newSize >= flushThreshold do
         --STEP1: cut out piece from payload to complete threshold bytes in table
         print('STEP1')
         local pieceSize = flushThreshold - self.size
         local piece = payload:sub(1, pieceSize)
         payload = payload:sub(pieceSize + 1, -1)
         --STEP2: insert piece into table
         print('STEP2')
         table.insert(self.data, piece)
         piece = nil
         self.size = self.size + pieceSize --size should be same as flushThreshold
         --STEP3: flush entire table
         print('STEP3')
         if self:flush() then
            coroutine.yield()
         end
         --at this point, size should be 0, because the table was just flushed
         newSize = self.size + payload:len()
      end

      print('aaaaaa')
      --at this point, whatever is left in payload should be < flushThreshold
      if payload:len() ~= 0 then
         --leave remaining data in the table
         print('table.insert')
         table.insert(self.data, payload)
         print('self.size')
         print("payload:len()"..payload:len())
         self.size = self.size + payload:len()
         print('pass')
      end
      print('scab')
   end
   print('return')
   return newInstance

end

return BufferedConnection
