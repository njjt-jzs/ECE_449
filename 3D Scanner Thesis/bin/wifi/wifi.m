% 设置ESP8266的IP地址和端口号
esp8266_ip = '192.168.4.1'; % 或者你的ESP8266的Station IP地址
esp8266_port = 5000; % ESP8266 TCP服务器的端口号

% 创建TCP客户端对象
tcpClient = tcpip(esp8266_ip, esp8266_port);

% 设置连接超时时间
set(tcpClient, 'Timeout', 5);

% 打开连接
fopen(tcpClient);

% 发送数据到ESP8266
fprintf(tcpClient, 'abc');

disp(response);

% 关闭连接
fclose(tcpClient);
delete(tcpClient);
clear tcpClient;
