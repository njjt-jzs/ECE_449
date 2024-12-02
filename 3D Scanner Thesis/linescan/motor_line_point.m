motor_mover_point(-5, 'x');

function motor_mover_point(step_size_1D,input_axis_1D)
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
    intermediate  = sprintf('%d,%d,%d', a, step_size_1D, c);
 else
    % Pad the step_size with zeros
    c = 0;
    intermediate = sprintf('%d,%d,%d', a, abs(step_size_1D), c);
 end

message = ['L,', intermediate];

disp(message);

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