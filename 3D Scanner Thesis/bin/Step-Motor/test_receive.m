% 定义串口和波特率
device = serialport("COM6", 115200);

% 配置回调函数，在接收到终止字符时触发
configureCallback(device, "terminator", @callbackFcn);


function callbackFcn(src, event)

    
disp('hehe');

end
