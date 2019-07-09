MQTT_HOST = "www.terasyshub.io"
MQTT_PORT = 1883
STATION_CFG={}

-- change below credentials with yours
STATION_CFG.ssid = "YOUR_WIFI_SSID"
STATION_CFG.pwd = "YOUR_WIFI_PASS"
MQTT_USER = "YOUR_MQTT_USER"
MQTT_PASS = "YOUR_MQTT_PASS"
MQTT_TEMPERATURE_TOPIC = "TEMPERATURE_TOPIC_TO_PUBLISH_DATA"
MQTT_HUMIDITY_TOPIC = "HUMIDITY_TOPIC_TO_PUBLISH_DATA"

-- DHT connected pin
DHT_PIN = 1

-- launch to connectivity
dofile("mqtt_sensor.lua")