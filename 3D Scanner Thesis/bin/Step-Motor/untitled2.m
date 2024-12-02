% Identify the COM port
serialPort = 'COM6'; % Replace with your actual COM port

% Create a serial object
s = serial(serialPort, 'BaudRate', 115200, 'Terminator', 'LF'); % Replace with your baud rate

% Open the serial port
fopen(s);

% Read data from the serial port
data = fscanf(s);

% Display the received data
disp(['Received Data: ', data]);

% Close the serial port
fclose(s);

% Delete the serial object
delete(s);
clear s;
