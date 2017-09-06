port = 3456
print("ESP8266 UDP Server")
wifi.setmode(wifi.SOFTAP)
wifi.setphymode(wifi.PHYMODE_G)
wifi.ap.config({ssid="pc",pwd="ufes2016"})
ip = wifi.ap.getip()
print("Server IP Address:",ip) 

-- local data = "package sent"

-- local function printer()
--     print(data)
-- end

srv = net.createServer(net.UDP)
srv:listen(port, ip, function(sck)
    sck:on("receive", function(sck, pl) 
        print(pl)
    end)
end)

tmr.alarm(2, 2000, 1, function() 
    srv:send("ola, dogs")
end)