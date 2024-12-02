function motor_mover_line(step_size_1D,input_axis_1D,step_amount_1D)

if (input_axis_1D == 'x')
    a = 1;
elseif (input_axis_1D == 'y')
    a = 2;
elseif (input_axis_1D == 'z')
    a = 3;
end


if (step_size > 0) 
    c = 1;
    intermediate  = sprintf('%d,%d,%d,%d', a, step_size_1D, c, step_amount_1D);
 else
    % Pad the step_size with zeros
    c = 0;
    intermediate = sprintf('%d,%d,%d,%d', a, abs(step_size_1D), c, step_amount_1D);
 end

message = ['s,', intermediate];


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
