#ifndef ARDUINO_HARDWARE_H
#define ARDUINO_HARDWARE_H

#include <Arduino.h>

#define INCORRECT_MEASUREMENT ""

void  HWInit();
void  HWRestart();
String Temperature();
String Humidity();

#endif /* ARDUINO_HARDWARE_H */
