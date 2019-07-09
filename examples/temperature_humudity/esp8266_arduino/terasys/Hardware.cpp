#include "Hardware.h"
#include "Global.h"
#include <DHT.h>

#define DHTPIN  5
#define DHTTYPE DHT11
#define IS_FAHRENHEIT false

DHT dht(DHTPIN, DHTTYPE);

const uint8_t hw_delay = 10;

String Temperature()
{
  float t = dht.readTemperature(IS_FAHRENHEIT);
  if (isnan(t))
  {    
    Serial.println("Failed to read from DHT sensor!");
    return INCORRECT_MEASUREMENT;
  }
  else
  {
    Serial.println(t);
    return String(t);
  }
}

String Humidity()
{
  float h = dht.readHumidity();
  if (isnan(h))
  {
    Serial.println("Failed to read from DHT sensor!");
    return INCORRECT_MEASUREMENT;
  }
  else
  {
    Serial.println(h);
    return String(h);
  }
}

void SerialInit()
{
  Serial.begin(SERIAL_BAUD_RATE);
  Serial.setDebugOutput(true);
  delay(hw_delay);
  dht.begin();
}

void GPIOInit()
{
  /* Set initial state for your GPIOs. */
}

void HWInit()
{
  SerialInit();
  GPIOInit();
}

void HWRestart()
{
  ESP.restart();
}

