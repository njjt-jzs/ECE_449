
input_axis_2D = 'xy';
len_a = 4;
len_b = 4;
step_a = 2;
step_b = 2;



twoD_scan(input_axis_2D,len_a,len_b,step_a,step_b);

function twoD_scan(input_axis_2D,len_a,len_b,step_a,step_b)
[s, visainst, mso4000] = init_helper();
 if strcmp(input_axis_2D, 'xy') 
                a_axis = 'x';
               
                b_axis = 'y';
            elseif strcmp(input_axis_2D, 'yz') 
                a_axis = 'y';
                b_axis = 'z';
            elseif strcmp(input_axis_2D, 'xz') 
                a_axis = 'x';
                b_axis = 'z';
            end
             step_size_b = step_b;
             step_size_a =  step_a;
             revol_a = len_a;
             revol_b = len_b;
            j = 1;
               for i= 1:revol_a
                    if mod(i, 2) == 0
                    str = [num2str(i) '_' num2str(revol_b)];
                    else
                    str = [num2str(i) '_' num2str(1)];
                    end
                    data_generator(str,visainst, mso4000);
                   for j = 2: revol_b
                       if mod(i, 2) == 0
                           w = revol_b - j + 1;
                           str = [num2str(i) '_' num2str(w)];
                        else
                         str = [num2str(i) '_' num2str(j)];
                        end
                       motor_mover(step_size_b,b_axis);
                   
                       data_generator(str);
            
                      
                   end
                   if i < revol_a
                      motor_mover_point(step_size_a,a_axis);
                       
                      step_size_b = -step_size_b;
                   end
               end
            
               %%twoD_plothelper(revol_a,revol_b);
clear_helper(s, visainst, mso4000);
end







function [s, visainst, mso4000] = init_helper()
    % Open Arduino communication port
    s = serialport("COM6", 115200);
    s.OutputBufferSize = 20;

    % Open function generator port
    visainst = visa('ni', 'USB0::0x0957::0x1507::MY48003157::0');
    fopen(visainst);

    % Open oscilloscope
    mso4000 = visa('ni', 'USB0::0x1AB1::0x04B1::DS4A175000664::0::INSTR');
    mso4000.InputBufferSize = 2048;
    fopen(mso4000);
end


function clear_helper(s, visainst, mso4000) 
        clear s;
        fclose(visainst);
        fclose( mso4000 );
end


%% Fun gen sending burst signal begin
function data_generator(round_num,visainst, mso4000)

    % set the wave for the square, 10 khz, 5vpp, 30% duty cycle
    fprintf(visainst, 'TRIG:SOUR BUS;*TRG;*WAI;*TRG;*WAI');
    fclose(visainst);


   %% checking in 100 data collected whether we received a laser trigger signal
   %% laser signal is around 10hz while the data acquisition rate is 4G/HZ which means we acquire 100 data 
   %% 40,000 kHz which is much larger than 10hz

    fprintf(mso4000, ':WAV:SOUR CHAN4' );

    fprintf(mso4000, ':wav:data?' );

    
    [data,len]= fread( mso4000, 2048);

    
    
    wave = data(12:len-1);

    % Define the folder name
    folderName = 'C:\Users\shenj\Desktop\data_buket';

    % Ensure the folder exists, if not, create it
    if ~exist(folderName, 'dir')
        mkdir(folderName);
    end

    matFileName = fullfile(folderName, sprintf('matlab_%s.mat', round_num));

    
    % Save data to the MATLAB file
    save(matFileName, 'wave', 'len');
    %% scanning process end 


   flushinput(mso4000);  % Clears the input buffer 
   flushoutput(mso4000); % Clears the output buffer
    
    end


function motor_mover(step_size,input_axis_1D,s)
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
 
    data = writeread(s, message);
    disp(data);
    flush(s);
end