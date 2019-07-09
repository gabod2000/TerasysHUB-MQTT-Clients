#include <Arduino.h>

#include "Hardware.h"
#include "WiFiCore.h"
#include "MQTTConnector.h"
#include "Global.h"
#include "Credentials.h"

#define PUBLISH_PERIOD 5000

String measurement = "";

void setup()
{
  HWInit();
  WiFiBegin(STA_SSID, STA_PASS);
  MQTTBegin();
}

void loop()
{
  if (MQTTConnected())
  {
    measurement = Temperature();
    if (measurement != INCORRECT_MEASUREMENT)
    {
      MQTTPublish(MQTT_TEMPERATURE_TOPIC, measurement.c_str());
    }
    measurement = Humidity();
    if (measurement != INCORRECT_MEASUREMENT)
    {
      MQTTPublish(MQTT_HUMIDITY_TOPIC, measurement.c_str());
    }
    delay(PUBLISH_PERIOD);
  }
  MQTTLoop();
}
