port = 3456
imagem = "imageTx"
print("ESP8266 TCP Server")
wifi.setmode(wifi.STATIONAP)
wifi.ap.config({ssid="pc",pwd="ufes2016"})
ip = wifi.ap.getip()
print("Server IP Address:",ip) 

srv = net.createServer(net.TCP)
srv:listen(port, ip, function(conn)
 	conn:on("receive", function(sck, req)
    	print(req)
        file.open(imagem,"r")
    	local response = {file.readline()}

    	local function send(sk)
    	  if #response > 0
    	    then sk:send(table.remove(response, 1))
    	    response[#response + 1]=file.readline()
    	  else
    	    collectgarbage()
    	    response = nil
            file.close()
    	    sk:send("done")
            sk:close()
    	  end
    	end

    	sck:on("sent", send)    	

    	send(sck)
  	end)
end)
