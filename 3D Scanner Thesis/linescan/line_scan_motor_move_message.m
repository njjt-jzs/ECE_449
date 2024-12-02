s = serialport("COM5", 115200);
s.OutputBufferSize = 20;
data = '';
pause(2);

%%message = "s,3,20,1,125"; %% two kinds of message: s with axis, step-size,direction,step_amount 

message = "L,3,25,1"; %% L follwed by request to move (the axis and step size, direction of a single move)
%% 1 is x, 2 is y, 3 is z
writeline(s, message);

    while true
        if strlength(data) == 0
            data = readline(s);
        else 
            
            disp(data);
            delete(s);
            clear;
            break;
        end
   


    end