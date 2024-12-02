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
  WiFiClient client = server.available(); // 检查是否有客户端连接

  if (client) {
    Serial.println("Client connected");

    while (client.connected()) {
      // 检查是否有客户端发送的消息
      if (client.available()) {
        String message = client.readStringUntil('\n'); // 读取消息
        Serial.println(message);
      }

      // 如果串口有数据可读，也处理这些数据
      if (Serial.available() > 0) {
        String receivedString = Serial.readString();
        //Serial.println(receivedString);
        // 你可以在这里将串口接收到的数据发送回客户端（如果需要）
        client.print(receivedString); // 发送串口数据到客户端
      }

      delay(100); // 小的延时，避免过度消耗CPU资源
    }

    // 客户端断开连接
    client.stop();
    Serial.println("Client disconnected");
  }
}
