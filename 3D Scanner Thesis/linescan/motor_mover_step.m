function motor_mover_step(step_size,input_axis_1D)
s = serialport("COM6", 115200);
    s.OutputBufferSize = 20;
    data = '';
step_size= 5;
input_axis_1D= 'y';


if (input_axis_1D == 'x')
    a = 1;
elseif (input_axis_1D == 'y')
    a = 2;
elseif (input_axis_1D == 'z')
    a = 3;
end


if (step_size > 0) 
    c = 1;
    intermediate  = sprintf('%d,%d,%d,%d', a, step_size, c);
 else
    % Pad the step_size with zeros
    c = 0;
    intermediate = sprintf('%d,%d,%d,%d', a, abs(step_size), c);
 end

message = ['L,', intermediate];

   

pause(2);

writeline(s, message);
    while true
        if strlength(data) == 0
            data = readline(s);
        else 
            
            disp(data);
            break;
        end
    


    end
end
    %% motor motion end