import processing.serial.*;

PFont font;
Serial port;

int tempReading;
int gsrReading;
int beatReading;

boolean pulse = false;

void setup() {

  size(430, 400);
  smooth();
  frameRate(60);

  //  PPG = new int[150];
  font = loadFont("AppleSymbols-20.vlw");

  port = new Serial(this, Serial.list()[2], 9600); // choose the right port and set the baud rate
  port.bufferUntil('\n');          // arduino will end each data packet with a carriage return 
  port.clear();                    // flush the Serial buffer, it's very hygienic
}

void draw() {
  initGraph();
  
  // Drawing GSR
  fill(204, 102, 0);
  text(gsrReading, width/2 - 70, height - 10);
  rect(100, height - 30, 100, -gsrReading);
  // Drawing pulse
  fill(104, 102, 0);
  text(beatReading, width/2 + 30, height - 10);
  rect(205, height - 30, 100, -beatReading);
  // Drawing Temperature
  fill(204, 102, 255);
  text(tempReading, width/2 + 135, height - 10);
  rect(310, height - 30, 100, -tempReading);
}


void initGraph() {
  background(0);
  noStroke();
  fill(0, 0, 0);
  strokeWeight(1);
  text("Biometrics Mashup", 0, 0);

  fill(200);

  stroke(153);

  for (int i = 0; i <= 200; i += 20) {
    line(55, map(i, 0, 200, height - 30, -100), 65, map(i, 0, 200, height - 30, -100));
  }

  noStroke();

  text("Biometrics Indicator", width/2 - 50, 35);
  text("GSR", width/2 - 100, height - 10);
  text("BPM", width/2, height - 10);
  text("TEMP", width/2 + 100, height - 10);
}

