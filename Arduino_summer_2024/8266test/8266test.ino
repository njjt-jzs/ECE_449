void setup() {
  // 初始化串口
  Serial.begin(115200);
  Serial1.begin(115200);

  // 等待一段时间，确保串口已经建立连接
  delay(1000);
}

void loop() {
  // 向ESP8266发送AT指令
  Serial1.println("AT");

  // 等待一小段时间，确保ESP8266有时间处理指令并返回响应
  delay(100);

  // 读取ESP8266的响应并通过Serial端口输出
  while (Serial1.available()) {
    char c = Serial1.read();
    Serial.write(c);
  }

  // 等待一段时间，以免过度读取串口缓冲区
  delay(1000);
}
