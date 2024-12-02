#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <WiFiServer.h>

const char* ssid = "ESP8266_AP";
const char* password = "12345678";

WiFiServer server(5000); // 端口号为5000

void setup() {
  Serial.begin(115200);

  // 设置ESP8266为接入点模式
  WiFi.softAP(ssid, password);

  server.begin();
  Serial.println("TCP server started");
}

void loop() {
  WiFiClient client = server.available();
  if (client) {
    Serial.println("Client connected");
    while (client.connected()) {
      if (client.available()) {
        String message = client.readStringUntil('\n');
        Serial.println("Message from client: " + message);
        client.println("Hello from ESP8266");
      }
    }
    client.stop();
    Serial.println("Client disconnected");
  }
}
