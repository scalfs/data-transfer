port = 3456
host = "192.168.4.1" 
counter = 0
size = 128
file.remove("imageRx")

print("ESP8266 TCP Client")
wifi.sta.disconnect()
wifi.setmode(wifi.STATION)
wifi.sta.config("pc","ufes2016") -- connecting to server
wifi.sta.connect() 
print("Looking for a connection")

tmr.alarm(1, 2000, 1, function()
  ip = wifi.sta.getip()
  if(ip~=nil) then
    tmr.stop(1)
    print("Connected!")
    print("Client IP Address:",wifi.sta.getip())
    con=net.createConnection(net.TCP)
    con:connect(port, host)
    if file.open("imageRx", "a+") then con:send("Ohayo") end
    con:on("receive", function(sck, data)
      if data ~="done" then
        file.write(data)
        counter = counter + 1
        print("Downloading... [" .. counter .. "/" .. size .. "]")
      else
        print("Transmission Complete!")
        con:close()
        file.close()
        collectgarbage()
      end
    end)
  else
    print("Connecting...")
  end
end)