/* Sweep
 by BARRAGAN <http://barraganstudio.com>
 This example code is in the public domain.

 modified 8 Nov 2013
 by Scott Fitzgerald
 http://www.arduino.cc/en/Tutorial/Sweep
*/

#include <Servo.h>

Servo left;  // create servo object to control a servo
Servo right;
// twelve servo objects can be created on most boards

int pos = 0;    // variable to store the servo position

void setup() {
  left.attach(9);  // attaches the servo on pin 9 to the servo object
  right.attach(10);
}

void loop() {
  for (pos = 0; pos <= 180; pos += 1) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
    left.write(pos);              // tell servo to go to position in variable'pos'
    right.write(pos);
    
    delay(15);                       // waits 15ms for the servo to reach the position
  }
  for (pos = 180; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
    left.write(pos);              // tell servo to go to position in variable 'pos'
    right.write(pos);
    delay(15);                       // waits 15ms for the servo to reach the position
  }
}

