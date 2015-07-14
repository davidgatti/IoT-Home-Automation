// This #include statement was automatically added by the Spark IDE.
#include "HttpClient/HttpClient.h"

byte hotSensorInterrupt = 2;  // 0 = digital pin 2
byte hotSensorPin       = 2;

byte coldSensorInterrupt = 3;  // 1 = digital pin 3
byte coldSensorPin       = 3;

// The hall-effect flow sensor outputs approximately 4.5 pulses per second per
// litre/minute of flow.
float calibrationFactor = 4.5;

volatile byte hotPulseCount, coldPulseCount;

float hotFlowRate, coldFlowRate;
unsigned int hotFlowMilliLitres, coldFlowMilliLitres;
unsigned long hotTotalMilliLitres, coldTotalMilliLitres;
boolean hotFlag, coldFlag;

unsigned long oldTime;

void setup() {

  // Initialize a serial connection for reporting values to the host
  Serial.begin(38400);

  pinMode(hotSensorPin, INPUT);
  digitalWrite(hotSensorPin, HIGH);

  pinMode(coldSensorPin, INPUT);
  digitalWrite(coldSensorPin, HIGH);

  hotFlag, coldFlag = false;
  hotPulseCount, coldPulseCount = 0;
  hotFlowRate, coldFlowRate = 0.0;
  hotFlowMilliLitres, coldFlowMilliLitres = 0;
  hotTotalMilliLitres, coldTotalMilliLitres = 0;
  oldTime = 0;

  // The Hall-effect sensor is connected to pin 2 which uses interrupt 0.
  // Configured to trigger on a FALLING state change (transition from HIGH
  // state to LOW state)
  attachInterrupt(hotSensorInterrupt, hotPulseCounter, FALLING);
  attachInterrupt(coldSensorInterrupt, coldPulseCounter, FALLING);
}

/**
 * Main program loop
 */
void loop() {

  if((millis() - oldTime) > 1000) {

    // Removign the interupt listner so we can calcualte the value.
    detachInterrupt(hotSensorInterrupt);
    detachInterrupt(coldSensorInterrupt);

    // Hot water
    hotFlowRate = ((1000.0 / (millis() - oldTime)) * hotPulseCount) / calibrationFactor;
    hotFlowMilliLitres = (hotFlowRate / 60) * 1000;
    hotTotalMilliLitres += hotFlowMilliLitres;

    // Cold water
    coldFlowRate = ((1000.0 / (millis() - oldTime)) * coldPulseCount) / calibrationFactor;
    coldFlowMilliLitres = (coldFlowRate / 60) * 1000;
    coldTotalMilliLitres += coldFlowMilliLitres;

    // If the the water stoped flowing, then we can save the collected data.
    if(hotTotalMilliLitres > 0 && hotFlowRate == 0) {
      hotFlag = true;
    }

    if(coldTotalMilliLitres > 0 && coldFlowRate == 0) {
      coldFlag = true;
    }

    oldTime = millis();

    unsigned int frac;

    // if we finished mesuring hot water, lets save the data
    if(hotFlag) {
        Spark.publish("Hot", String(hotTotalMilliLitres));
        Spark.publish("waterflow", "{ \"acPointer\": \"Pointer\", \"acClassName\": \"Accessories\", \"acObjectId\": \"3wEtpxS126\", \"tag\": \"hot\", \"value\": " + String(hotTotalMilliLitres) + "}", 60, PRIVATE);
        hotTotalMilliLitres = 0;
        hotFlag = false;
    }

    // if we finished mesuring cold water, lets save the data
    if(coldFlag) {
        Spark.publish("Cold", String(coldTotalMilliLitres));
        Spark.publish("waterflow", "{ \"acPointer\": \"Pointer\", \"acClassName\": \"Accessories\", \"acObjectId\": \"3wEtpxS126\", \"tag\": \"cold\", \"value\": " + String(coldTotalMilliLitres) + "}", 60, PRIVATE);
        coldTotalMilliLitres = 0;
        coldFlag = false;
    }

    // Evry seccond we reset the value since we are storing it using *TotalMilliLitres variable.
    hotPulseCount = 0;
    coldPulseCount = 0;

    // Reataching the interupt listner to the pins
    attachInterrupt(hotSensorInterrupt, hotPulseCounter, FALLING);
    attachInterrupt(coldSensorInterrupt, coldPulseCounter, FALLING);
  }
}


void hotPulseCounter() {
  hotPulseCount++;
}

void coldPulseCounter() {
  coldPulseCount++;
}
