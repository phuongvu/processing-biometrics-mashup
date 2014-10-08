int pulsePin = 0;
int tempSensorPin = 1;
int gsrPin = 2;

// Misc
int blinkPin = 13;

// GSR value declaration
int gsrValue;
// GSR reading period
unsigned long time;
int secForGSR;
int curMillisForGSR;
int preMillisForGSR;

// these variables are volatile because they are used during the interrupt service routine!
volatile int BPM;                   // used to hold the pulse rate
volatile int Signal;                // holds the incoming raw data
volatile int IBI = 600;             // holds the time between beats, must be seeded!
volatile boolean Pulse = false;     // true when pulse wave is high, false when it's low
volatile boolean QS = false;        // becomes true when Arduoino finds a beat.


void setup()
{
  Serial.begin(9600); //Start the serial connection with the computer
  interruptSetup();
  pinMode(blinkPin, OUTPUT);        // pin that will blink to your heartbeat!
  secForGSR = 1; // How often do we get a GSR reading
  curMillisForGSR = 0;
  preMillisForGSR = -1;
}

void loop()
{
  time = millis();
    
  // Temp sensor
  int tempReading = analogRead(tempSensorPin);
  float voltage = tempReading * 5.0;
  voltage /= 1024.0;
  float temperatureC = (voltage - 0.5) * 100;
  sendDataToProcessing('T', temperatureC);

  // Pulse sensor
  sendDataToProcessing('S', BPM);

  // GSR
  int gsrReading = analogRead(gsrPin);
  sendDataToProcessing('G', gsrReading);
  
  delay(50);
}

void sendDataToProcessing(char symbol, int data ) {
  Serial.print(symbol);                // symbol prefix tells Processing what type of data is coming
  Serial.println(data);                // the data to send culminating in a carriage return
}

