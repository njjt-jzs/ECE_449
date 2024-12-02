    s = serialport("COM7", 115200);
    s.OutputBufferSize = 20;
    pause(2);
tic;
motor_mover_line(5,'x',4,s);

elapsedTime = toc;
fprintf('Time spent on motor_mover calls: %.4f seconds\n', elapsedTime);

clear s;


function motor_mover_line(step_size_1D,input_axis_1D,step_amount_1D,s)
    data = '';
    
if (input_axis_1D == 'x')
    a = 1;
elseif (input_axis_1D == 'y')
    a = 2;
elseif (input_axis_1D == 'z')
    a = 3;
end


if (step_size_1D > 0) 
    c = 1;
    intermediate  = sprintf('%d,%d,%d,%d', a, step_size_1D, c, step_amount_1D);
 else
    % Pad the step_size with zeros
    c = 0;
    intermediate = sprintf('%d,%d,%d,%d', a, abs(step_size_1D), c, step_amount_1D);
 end

message = ['s,', intermediate];


%%pause(2);

data = writeread(s, message);
disp(data);
flush(s);
end
