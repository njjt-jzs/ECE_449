#include <WiFi.h>  // Use <ESP8266WiFi.h> if using an ESP8266

const char* ssid = "ESP8266";  // SSID of the AP
const char* password = "12345678";  // Password of the AP

WiFiServer server(50);  // Create a server that listens on port 50

void setup() {
  Serial.begin(115200);
  
  // Set up the access point
  WiFi.softAP(ssid, password);
  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);

  server.begin();  // Start the server
}

void loop() {
  WiFiClient client = server.available();  // Check for incoming clients

  if (client) {
    Serial.println("New Client Connected");
    while (client.connected()) {
      if (client.available()) {
        String line = client.readStringUntil('\n');
        Serial.println(line);
        client.println("Hello from Arduino");
      }
    }
    client.stop();
    Serial.println("Client Disconnected");
  }
}

