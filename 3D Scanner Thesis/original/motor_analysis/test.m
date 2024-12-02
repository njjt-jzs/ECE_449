    s = serialport("COM7", 115200);
    s.OutputBufferSize = 20;
    pause(2);

tic;
motor_mover(5,'x',s);
%%flush(s);
motor_mover(4,'x',s);
%%flush(s);
motor_mover(4,'x',s);
motor_mover(4,'x',s);


elapsedTime = toc;
fprintf('Time spent on motor_mover calls: %.4f seconds\n', elapsedTime);

clear s;

function motor_mover(step_size,input_axis_1D,s)
    %%s = serialport("COM7", 115200);
    %%s.OutputBufferSize = 20;
    data = '';
    if (step_size > 0) 
    padded_step_size = num2str(step_size,'%04.f');
    else
    % Pad the step_size with zeros
    a = num2str(abs(step_size), '%03.f');

    % Add '1' at the beginning of the padded string
    padded_step_size = ['1', a(end-2:end)];
    end

    %%1:+x 2:-x 3:+y 4:-y 5:+z 6:-z 
    %% change here for different operation
    if strcmp(input_axis_1D,"x")
        message = [padded_step_size, ',0000,0000'];
    elseif strcmp(input_axis_1D, "y")
        message = ['0000,', padded_step_size,',0000'];
    elseif strcmp(input_axis_1D, "z")
        message = ['0000,', '0000,',padded_step_size];
    end

%%pause(2);


data = writeread(s, message);
disp(data);
flush(s);
%%writeline(s, message);
%%    while true
%%        if strlength(data) == 0
%%            data = readline(s);
%%        else 
            
%%            disp(data);
%%            flush(s);
%%            break;
%%        end
    


%%    end
end