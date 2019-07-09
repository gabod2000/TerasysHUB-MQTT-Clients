--- connect to the wifi network ---
wifi.setmode(wifi.STATION) 
wifi.sta.config(STATION_CFG)
wifi.sta.connect()

local ipTimer = tmr.create()
ipTimer:alarm(1000, 1, function() 
  checkNetwork()  
end)

function checkNetwork()
  if wifi.sta.getip() == nil then
    print("Connecting to AP...")
  else
    print("IP: ",wifi.sta.getip())
    ipTimer:unregister()
  end
end

-- initiate the mqtt client
local mqtt = mqtt.Client(wifi.ap.getmac(), 120, MQTT_USER, MQTT_PASS)

mqtt:on("connect", function(con) print ("TeraSys MQTT Connected") end)
mqtt:on("offline", function(con) print ("TeraSys MQTT Disconnected!") end)

-- on receive message
mqtt:on("message", function(conn, topic, data)
  print(topic .. ":" )
  if data ~= nil then
    print(data)
  end
end)

mqtt:connect(MQTT_HOST, MQTT_PORT, 0, function(conn)
  print("connected")
end)

local sensorTimer = tmr.create()
ipTimer:alarm(5000, 1, function() 
  sensorRead()  
end)

function sensorRead()
  -- periodic read from dht11
  local status, temp, humi, temp_dec, humi_dec = dht.read(DHT_PIN)
  if status == dht.OK then    --check status is ok and print temperature and humidity
    print(string.format("DHT Temperature:%d.%03d;Humidity:%d.%03d",
      math.floor(temp),
      temp_dec,
      math.floor(humi),
      humi_dec
    ))
    mqtt:publish(MQTT_TEMPERATURE_TOPIC, temp_dec, 0, 0, function(conn)
      print("sent temp")
    end)
    mqtt:publish(MQTT_HUMIDITY_TOPIC, humi_dec, 0, 0, function(conn)
      print("sent humidity")
    end)
  elseif status == dht.ERROR_CHECKSUM then
    print( "DHT Checksum error." )
  elseif status == dht.ERROR_TIMEOUT then
    print( "DHT timed out." )
  end
end



