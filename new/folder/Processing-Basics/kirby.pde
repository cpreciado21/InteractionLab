int x, y;

void setup() { //runs once
  size(800, 800);
  x= 0; 
  y=0; 
  background(#fffaf0);
  frameRate(100);
}
void draw() { //runs continously
  background(#fffaf0);
  translate(x, 0);
  translate(0, y);
  fill(#FC9D9A);
  stroke(0);
  strokeWeight(3);
  ellipse(250, 400, 125, 70); //left arm
  ellipse(550, 400, 125, 70); //right arm
  stroke(0);
  fill(#FC9D9A);
  ellipse(400, 400, 300, 300); //head
  fill(#0a56f6);
  strokeWeight(2);
  stroke(0);
  ellipse(350, 370, 50, 75); //left eye blue
  ellipse(450, 370, 50, 75); //right eye blue
  fill(0);
  noStroke();
  ellipse(350, 365, 40, 65); //left eye black
  ellipse(450, 365, 40, 65); //right eye black
  noStroke();
  fill(255);
  ellipse(350, 355, 25, 35); //left eye white
  ellipse(450, 355, 25, 35); //right eye white
  fill(255, 0, 0);
  stroke(0);
  strokeWeight(3);
  ellipse(330, 535, 120, 65); //left foot
  ellipse(475, 535, 120, 65); //right foot
  fill(255, 0, 100);
  arc(400, 420, 35, 70, 0, PI, OPEN); //mouth
  x++;
}
