#include <Servo.h>
Servo servo;

const int TouchPin = 9;
int count = 0;
bool pressed = false;

void setup() {
  // put your setup code here, to run once:
  pinMode(TouchPin, INPUT);
  servo.attach(10);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int sensorValue = digitalRead(TouchPin);
  Serial.print("Sensor = ");
  Serial.println(sensorValue);
  if (sensorValue == 1) {
    if (pressed == false) {
      count++;
    }
    if (count == 1) {
      servo.write(90);
      delay(1500);
      servo.write(0);
      delay(2000);
    }
    else if (count == 2){
      servo.write(0);
      delay(1500);
      servo.write(90);
      delay(2000);
    }
    pressed = true;
  }
  else {
    pressed = false;
  }
  Serial.print("count = ");
  Serial.println(count % 3);
  delay(500);
}
