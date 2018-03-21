import processing.serial.*;

import cc.arduino.*;
import controlP5.*;

ControlP5 controlP5;

Arduino arduino;
int shoulder = 200;
int chest = 60; //commented out bc decided to use two servos rather than one

void setup() {
  size(400, 400);
  controlP5 = new ControlP5(this);
  controlP5.addSlider("shoulder", 0, 255, shoulder, 20, 10, 255, 20); //will create slider that controls shoulders
  controlP5.addSlider("chest", 60, 100, chest, 20, 40, 255, 20); //will create slider that controls chest shorter range for chest

  // Prints out the available serial ports.
  println(Arduino.list());

  arduino = new Arduino(this, Arduino.list()[4], 57600);

  // Configure pins
  arduino.pinMode(9, Arduino.SERVO); //RIGHT SHOULDER
  arduino.pinMode(8, Arduino.SERVO); //LEFT SHOUlDER
  arduino.pinMode(7, Arduino.SERVO); //LEFT CHEST
  arduino.pinMode(6, Arduino.SERVO);  // RIGHT CHEST
}

void draw() {
  background(shoulder); //add chest if coding on single arduino

  arduino.servoWrite(9, shoulder); //allows sliders to control two servos simulataneously
  arduino.servoWrite(8, shoulder);
  arduino.servoWrite(7, chest);
  arduino.servoWrite(6, chest);
}