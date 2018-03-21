#include <Servo.h>
Servo left_servo;  
Servo right_servo;

int intpos = 0;    
int finalpos = 90;
void setup() {
  left_servo.attach(9);  // attaches the left servo to pin 9 
  right_servo.attach(10); // attaches the right servo to pin 10
}

void loop() {
  for (pos = intpos; pos <= finalpos; pos += 1) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
    left_servo.write(pos);              // tell servo to go to position in variable 'pos'
    right_servo.write(pos);
    delay(15);                       // waits 15ms for the servo to reach the position
  }
  for (pos = finalpos; pos >= intpos; pos -= 1) { // goes from 180 degrees to 0 degrees
    left_servo.write(pos);              // tell servo to go to position in variable 'pos'
    right_servo.write(pos);
    delay(15);                       // waits 15ms for the servo to reach the position
  }
}
