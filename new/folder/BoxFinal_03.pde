import de.voidplus.leapmotion.*;
import processing.serial.*;
import processing.sound.*;

int seq = 0;
/**
 * sequence
 * 0: intro
 * 1: acc
 * 2: leapMotion
 */



PImage imgDeer;
PImage imgCat;
int imgDeerX, imgDeerY, imgDeerZ;
int opacity;

SoundFile soundfile;
PFont font; 
PImage hp; //deathlyhallow image
String intro = "Welcome to Hogwarts";
String patronus1 = "To summon your patronus: ";
String patronus2 = "tilt your wand";
String tri1 = "Place your wand in the middle";
String tri2 = "Wave your wand to the right"; 

float handX, handY;
int x, y, r;

Serial myPort;
String myString;


// ======================================================
// Table of Contents:
// ├─ 1. Callbacks
// ├─ 2. Hand
// ├─ 3. Arms
// ├─ 4. Fingers
// ├─ 5. Bones
// ├─ 6. Tools
// └─ 7. Devices
// ======================================================


LeapMotion leap;

void setup() {
  size(800, 600);
  background(30);


  hp = loadImage("deathlyhallows.png");
  font = createFont("HARRYP__.TTF", 45); 
  textFont( font);
  soundfile = new SoundFile(this, "Harry_Potter_Theme_Song.mp3");
  soundfile.loop();

  x = width/2; //for hidden ellipse
  y = height/2;
  r = 75;

  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);
  // ...
  myPort.clear();
  imgDeer = loadImage("Patronus.png");

  leap = new LeapMotion(this); 
  //port = new Serial(this, Serial.list()[4], 57600);
}


// ======================================================
// 1. Callbacks

void leapOnInit() {
  // println("Leap Motion Init");
}
void leapOnConnect() {
  // println("Leap Motion Connect");
}
void leapOnFrame() {
  // println("Leap Motion Frame");
}
void leapOnDisconnect() {
  // println("Leap Motion Disconnect");
}
void leapOnExit() {
  // println("Leap Motion Exit");
}


// update
// check & compare
// display

void draw() {
  switch (seq) {
  case 0:
    // intro
    background(30);
    textAlign(CENTER);
    text(intro, 0, 200, 800, 200);
    textSize(100);
    break;
  case 1:
    // intro for patronus
    background(30);
    textSize(70);
    textAlign(CENTER);
    text(patronus1, 5, 150, 800, 200);
    text(patronus2, 5, 250, 800, 200);
    break;
  case 2:
    // deer
    background(30);
    while (myPort.available() > 0) {
      myString = myPort.readStringUntil(10);
      if (myString != null) {
        String[] dataFromArduino = split(trim(myString), ",");
        for (int i=0; i<dataFromArduino.length; i++) {
          //println(dataFromArduino[i]);
        }
        if (dataFromArduino.length==3) {
          imgDeerX = int(dataFromArduino[0]);
          imgDeerY = int(dataFromArduino[1]);
          imgDeerZ = int(dataFromArduino[2]);
        }
      }
    }
    print("opacity ");
    print(opacity);
    print(" imgDeerZ ");
    println(imgDeerZ);
    if (imgDeerZ<10) {
      if (opacity<255) 
        opacity= opacity+3;
      } else {
        if (opacity >0) {
          opacity= opacity-3;
        }
      }
      tint(255, opacity);
      image(imgDeer, 0, 0, width, height);
      //ellipse(imgDeerX, imgDeerY, 200-imgDeerZ, 200-imgDeerZ);

      break;
    case 3:
      // triangle pattern
      leapMotionStuff();
      if (dist(handX, handY, x, y)>r) {
        // if my hand is outside the circle move servo to 180 deg
        myPort.write('C'); // close
      } else {
        // else return to 0
        myPort.write('O'); // open
      }

      background(30);
      tint(255, 255);

      image(hp, 245, 125);
      hp.resize(300, 00);
      textAlign(LEFT);
      text(tri1, 105, 40, 600, 200);
      text(tri2, 105, 450, 600, 200);


      strokeWeight(0);
      fill(255);
      ellipse(handX, handY, 10, 10); //this ellipse is hidden

      strokeWeight(0);
      noFill();
      ellipse(x, y, 2*r, 2*r);
      break;
    }
  }

  void keyPressed() {
    seq++;
    if (seq == 4) {
      seq = 0;
    }
  }



  void leapMotionStuff() {

    int fps = leap.getFrameRate();
    for (Hand hand : leap.getHands ()) {


      // ==================================================
      // 2. Hand

      int     handId             = hand.getId();
      PVector handPosition       = hand.getPosition();
      PVector handStabilized     = hand.getStabilizedPosition();
      PVector handDirection      = hand.getDirection();
      PVector handDynamics       = hand.getDynamics();
      float   handRoll           = hand.getRoll();
      float   handPitch          = hand.getPitch();
      float   handYaw            = hand.getYaw();
      boolean handIsLeft         = hand.isLeft();
      boolean handIsRight        = hand.isRight();
      float   handGrab           = hand.getGrabStrength();
      float   handPinch          = hand.getPinchStrength();
      float   handTime           = hand.getTimeVisible();
      PVector spherePosition     = hand.getSpherePosition();
      float   sphereRadius       = hand.getSphereRadius();

      // --------------------------------------------------
      // Drawing
      //hand.draw();

      handX = handPosition.x;
      handY = handPosition.y;


      // ==================================================
      // 3. Arm

      if (hand.hasArm()) {
        Arm     arm              = hand.getArm();
        float   armWidth         = arm.getWidth();
        PVector armWristPos      = arm.getWristPosition();
        PVector armElbowPos      = arm.getElbowPosition();
      }


      // ==================================================
      // 4. Finger

      Finger  fingerThumb        = hand.getThumb();
      // or                        hand.getFinger("thumb");
      // or                        hand.getFinger(0);

      Finger  fingerIndex        = hand.getIndexFinger();
      // or                        hand.getFinger("index");
      // or                        hand.getFinger(1);

      Finger  fingerMiddle       = hand.getMiddleFinger();
      // or                        hand.getFinger("middle");
      // or                        hand.getFinger(2);

      Finger  fingerRing         = hand.getRingFinger();
      // or                        hand.getFinger("ring");
      // or                        hand.getFinger(3);

      Finger  fingerPink         = hand.getPinkyFinger();
      // or                        hand.getFinger("pinky");
      // or                        hand.getFinger(4);


      for (Finger finger : hand.getFingers()) {
        // or              hand.getOutstretchedFingers();
        // or              hand.getOutstretchedFingersByAngle();

        int     fingerId         = finger.getId();
        PVector fingerPosition   = finger.getPosition();
        PVector fingerStabilized = finger.getStabilizedPosition();
        PVector fingerVelocity   = finger.getVelocity();
        PVector fingerDirection  = finger.getDirection();
        float   fingerTime       = finger.getTimeVisible();

        // ------------------------------------------------
        // Drawing

        // Drawing:
        // finger.draw();  // Executes drawBones() and drawJoints()
        // finger.drawBones();
        // finger.drawJoints();

        // ------------------------------------------------
        // Selection

        switch(finger.getType()) {
        case 0:
          // System.out.println("thumb");
          break;
        case 1:
          // System.out.println("index");
          break;
        case 2:
          // System.out.println("middle");
          break;
        case 3:
          // System.out.println("ring");
          break;
        case 4:
          // System.out.println("pinky");
          break;
        }


        // ================================================
        // 5. Bones
        // --------
        // https://developer.leapmotion.com/documentation/java/devguide/Leap_Overview.html#Layer_1

        Bone    boneDistal       = finger.getDistalBone();
        // or                      finger.get("distal");
        // or                      finger.getBone(0);

        Bone    boneIntermediate = finger.getIntermediateBone();
        // or                      finger.get("intermediate");
        // or                      finger.getBone(1);

        Bone    boneProximal     = finger.getProximalBone();
        // or                      finger.get("proximal");
        // or                      finger.getBone(2);

        Bone    boneMetacarpal   = finger.getMetacarpalBone();
        // or                      finger.get("metacarpal");
        // or                      finger.getBone(3);

        // ------------------------------------------------
        // Touch emulation

        int     touchZone        = finger.getTouchZone();
        float   touchDistance    = finger.getTouchDistance();

        switch(touchZone) {
        case -1: // None
          break;
        case 0: // Hovering
          // println("Hovering (#" + fingerId + "): " + touchDistance);
          break;
        case 1: // Touching
          // println("Touching (#" + fingerId + ")");
          break;
        }
      }


      // ==================================================
      // 6. Tools

      for (Tool tool : hand.getTools()) {
        int     toolId           = tool.getId();
        PVector toolPosition     = tool.getPosition();
        PVector toolStabilized   = tool.getStabilizedPosition();
        PVector toolVelocity     = tool.getVelocity();
        PVector toolDirection    = tool.getDirection();
        float   toolTime         = tool.getTimeVisible();

        // ------------------------------------------------
        // Drawing:
        // tool.draw();

        // ------------------------------------------------
        // Touch emulation

        int     touchZone        = tool.getTouchZone();
        float   touchDistance    = tool.getTouchDistance();

        switch(touchZone) {
        case -1: // None
          break;
        case 0: // Hovering
          // println("Hovering (#" + toolId + "): " + touchDistance);
          break;
        case 1: // Touching
          // println("Touching (#" + toolId + ")");
          break;
        }
      }
    }


    // ====================================================
    // 7. Devices

    for (Device device : leap.getDevices()) {
      float deviceHorizontalViewAngle = device.getHorizontalViewAngle();
      float deviceVericalViewAngle = device.getVerticalViewAngle();
      float deviceRange = device.getRange();
    }
  }