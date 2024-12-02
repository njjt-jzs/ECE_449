
s = serialport("COM7", 115200);
pause(2);
s.Timeout = 25;
%%1:+x 2:-x 3:+y 4:-y 5:+z 6:-z
%%message = "25";
%% 4 set of numbers will be used to represent full three axies motion:
%% 3 numbers will be used for one axies, and the first one if used as indication for direction
%% separate by comma / not if it is not working
data = '';
message = "s,1,5,20"; %% two kinds of message: s with axis, step-size, step_amount 

%%message = "L,1,5"; %% L follwed by request to move (the axis and step size of a single move)
%% 1 is x, 2 is y, 3 is z

data = writeread(s, message);
disp(data);
flush(s);

clear s;