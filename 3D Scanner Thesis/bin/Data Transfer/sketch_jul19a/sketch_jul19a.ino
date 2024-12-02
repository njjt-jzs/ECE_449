#include <SoftwareSerial.h>

SoftwareSerial oscilloscopeSerial(10, 11); // RX, TX 引脚配置

void setup() {
  Serial.begin(115200); 
  oscilloscopeSerial.begin(115200); 

 
  //oscilloscopeSerial.println(":WAV:SOUR CHAN4");
  delay(100); 
  oscilloscopeSerial.println(":WAV:DATA?");
}

void loop() {
  oscilloscopeSerial.print('A');

}