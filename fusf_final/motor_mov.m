motor_mover(10,'x');


function motor_mover(step_size,input_axis_1D)
s = serialport("COM6", 115200);
    s.OutputBufferSize = 20;
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


    while true
        if s.NumBytesAvailable == 0
            write(s, message, 'char');
    
    
 
            %%disp("Sent to Arduino: " + message);
            pause(5);

        else 
            data = read(s,10,"string");
            disp(data);
            break;
        end
    


    end
end