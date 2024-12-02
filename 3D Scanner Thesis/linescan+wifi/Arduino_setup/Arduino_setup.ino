#include <SoftwareSerial.h>

// Define RX and TX pins for software serial
const int rxPin = 12;
const int txPin = 11;

// Create a SoftwareSerial object
SoftwareSerial mySerial(rxPin, txPin);

void setup() {
  // Begin USB serial communication for debugging
  Serial.begin(115200);
  
  // Begin software serial communication
  mySerial.begin(115200);  // Baud rate for the software serial
}

void loop() {
  // Check if there is data available on the software serial
  if (mySerial.available()) {
    // Read the incoming byte from the software serial
    String incomingByte = mySerial.readStringUntil('\n');
    
    // Print the received byte to the USB serial (Serial Monitor)
    Serial.print("Received: ");
    Serial.print(incomingByte);
  }

  // If you want to send data from USB serial (Serial Monitor) to the software serial, add this:
  if (Serial.available()) {
    // Read the byte from the USB serial input
    char dataFromUSB = Serial.read();
    
    // Send the byte to the software serial port
    mySerial.write(dataFromUSB);
  }
}
