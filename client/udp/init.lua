port = 3456
counter = 0
file.remove("imageRx")

print("ESP8266 UDP Client")
wifi.sta.disconnect()
wifi.setmode(wifi.STATION)
wifi.setphymode(wifi.PHYMODE_G)
wifi.sta.config("pc","ufes2016") -- connecting to server
wifi.sta.connect() 
print("Looking for a connection")

tmr.alarm(1, 2000, 1, function()
  ip = wifi.sta.getip()
  if(ip~=nil) then
    tmr.stop(1)
    print("Connected!")
    print("Client IP Address:",ip)
    con = net.createConnection(net.UDP, 0)
    con:connect(port, ip)
    con:on("receive", function(sck, data) print(data) end)
  else
    print("Connecting...")
  end
end)