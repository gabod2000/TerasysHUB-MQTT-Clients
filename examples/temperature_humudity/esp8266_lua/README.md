## Temperature and Humidity Example with ESP8266 Lua via TeraSysHub MQTT
Below steps will guide you to run ESP8266 based TeraSysHub MQTT example via Lua based firmware. The temperature and humidity sensor will be [DHT11](https://www.adafruit.com/product/386).

### Wiring the HW
* DHT11 is a One Wire protocol based sensor so you need to provide 3.3V, Ground and Data pins. 
* Our Data pin is ESP8266's **GPIO 5**. Notice that it is equivalent to **D1** in NodeMCU fashion. Check **Hardware.cpp** file for details.
* You need to construct your ESP8266 and DHT wiring as given diagram below :
![Alt text](../img/sensorwiring.png?raw=true "ESP8266-DHT11 Wiring")

### Preparing Firmware
* You need to burn Lua firmware to your ESP8266 before proceeding. You can generate your own firmware by the 
following [this link](https://learn.adafruit.com/diy-esp8266-home-security-with-lua-and-mqtt/how-to-re-flash-your-esp8266) for one of the best practice of firmware burning. When you navigate to [NodeMCU custom build page](https://nodemcu-build.com/index.php), do not forget to select **MQTT, DHT and OneWire** options from **Select Modules to Include** tab. Provide your e-mail address and start build. Once build is completed, you will be notified and firmware download link will be provided.
* OR, use directly [this firmware](bin/nodemcu-mqtt-dht-int.bin) which we already generated for you.
* Download the [ESPTool](https://github.com/espressif/esptool) to burn your firmware. 
* We offer to use **pip** to install *ESPTool* :
```
pip install esptool
```
* Copy downloaded image under downloaded **esptool** directory and change directory into it.
* Use below command to burn downloaded firmware :
```
python ./esptool.py --port /dev/tty{YOUR_DEVICE_NAME} write_flash 0x00000 {YOUR_DOWNLOADED_FIRMWARE}
```

### Running with MQTT Sample
* Now you are ready to get the sample code. First, clone the TeraSysHUB client repository via git or just download as [zip](https://github.com/gabod2000/TerasysHUB-MQTT-Clients) :
```
$ git clone https://github.com/gabod2000/TerasysHUB-MQTT-Clients.git
```
* Now, switch to ESP8266 Lua releated directory :
```
$ cd TerasysHUB-MQTT-Clients/examples/temperature_humudity/esp8266_lua
```
* Open **init.lua** file and modify below credentials with yours :
```
STATION_CFG.ssid = "YOUR_WIFI_SSID"
STATION_CFG.pwd = "YOUR_WIFI_PASS"
MQTT_USER = "YOUR_MQTT_USER"
MQTT_PASS = "YOUR_MQTT_PASS"
MQTT_TEMPERATURE_TOPIC = "TEMPERATURE_TOPIC_TO_PUBLISH_DATA"
MQTT_HUMIDITY_TOPIC = "HUMIDITY_TOPIC_TO_PUBLISH_DATA"
```
* Get [LuaTool](https://github.com/4refr0nt/luatool).
* Navigate into the luatool directory where **luatool.py** resides.
* Write our two lua script into the device with below commands :
```
./luatool.py --port /dev/tty{YOUR_DEVICE_NAME} --baud 115200 --src {PATH_TO_YOUR_INIT_LUA_FILE} --dest init.lua --verbose
./luatool.py --port /dev/tty{YOUR_DEVICE_NAME} --baud 115200 --src {PATH_TO_YOUR_MQTT_SENSOR_LUA_FILE} --dest mqtt_sensor.lua --verbose
```

### Receive Data on User App
* Follow these steps to subscribe to your topics via user Web application :
[User App Guide](https://github.com/gabod2000/Terasys-MQTT/tree/master/user)
* Once you subscribed correctly to your topics, you will start to receive MQTT messages like below :
![Alt text](../img/userapp.png?raw=true "User App Subscribed Topics")
* Notice that sample topics are given below which start with user name:
```
terasys@terasys.com/temperature
terasys@terasys.com/humidity
```
