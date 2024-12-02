%% The 2D scan will generate revol_a +1 and revol_b +1 data points

input_axis_2D = 'xy';
len_a = ;
len_b = ;
step_a =;
step_b = ;

twoD_scan(input_axis_2D,len_a,len_b,step_a,step_b);


function twoD_scan(input_axis_2D,len_a,len_b,step_a,step_b)
 init_helper;
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

             %% First collect at the origin
             data_generator('1_1');
               for i= 1:revol_a
                    
                    if mod(i, 2) == 1
                    str_start = [num2str(i) '_1'];
                    data_generator(str_start);
                    motor_mover_line(step_size_b,b_axis,revol_b-1);
                    for j= 2:revol_b
                        str = [num2str(i) '_' num2str(j)];
                        data_generator(str);
                        %%pause(); %% this needs to be change to sync oscilloscope
                        %%pause is in Arduino
                    end
                    
                    else
                    str_start = [num2str(i) '_' num2str(revol_b+1)];
                    data_generator(str_start);
                    motor_mover_line(step_size_1D,input_axis_1D,revol_b-1);
                    for j= 2:revol
                        w = revol_b - j + 2;
                        str = [num2str(i) '_' num2str(w)];
                        data_generator(str);
                        %%pause(); %% this needs to be change to sync oscilloscope
                        %%pause is in Arduino

                    end
                    end
                    pause(1);%% have a pause to realign in time
                    if i < revol_a
                       motor_mover_point(step_size_a,a_axis);
                       
                       step_size_b = -step_size_b;
                    end
               end
            
    %%           twoD_plothelper(revol_a,revol_b);
               clear_helper;

end




%%%%%%%%%%
% start of helper functions
%%%%%%

%% redefine the function for both use since no matter 1D, 2D, 3D we all only move motor on one axis at a time
%% name for 1D will be 1,2,3,4...
%% name for 2D will be 1_1,1_2, ...
%% name for 3D will be 1_1_1, 1_1_2, ...

function motor_mover_line(step_size_1D,input_axis_1D,step_amount_1D)
    data = '';
    
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


%%pause(2);

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




 %% Fun gen sending burst signal begin
    function data_generator(round_num)

    % set the wave for the square, 10 khz, 5vpp, 30% duty cycle
    fprintf(visainst, 'TRIG:SOUR BUS;*TRG;*WAI;*TRG;*WAI');


    %% Fun gen sending burst signal end

    %% Scanning process begin
    %% start the laser scan on chanel3

    flushinput(mso4000);
   %% checking in 100 data collected whether we received a laser trigger signal
   %% laser signal is around 10hz while the data acquisition rate is 4G/HZ which means we acquire 100 data 
   %% 40,000 kHz which is much larger than 10hz

    fprintf(mso4000, ':WAV:SOUR CHAN4' );

    fprintf(mso4000, ':wav:data?' );

    
    [data,len]= fread( mso4000, 2048);
    
    wave = data(12:len-1);

    % Define the folder name
    folderName = 'C:\Users\Jinzhi Shen\Desktop\fusf_redo\test_scan';

    % Ensure the folder exists, if not, create it
    if ~exist(folderName, 'dir')
        mkdir(folderName);
    end

    matFileName = fullfile(folderName, sprintf('matlab_%s.mat', round_num));

    
    % Save data to the MATLAB file
    save(matFileName, 'wave', 'len');
    %% scanning process end 
    
    end

function init_helper()    

%% open Arduino communication port
    s = serialport("COM6", 115200);
    s.OutputBufferSize = 20;

%% open funciton generator port
    visainst = visa('ni', 'USB0::0x0957::0x1507::MY48003157::0');
    fopen(visainst);

%% open oscilloscope
   mso4000 = visa( 'ni','USB0::0x1AB1::0x04B1::DS4A175000664::0::INSTR' );
   mso4000.InputBufferSize = 2048;
   fopen(mso4000);
end

function clear_helper() 
        clear s;
        fclose(visainst);
        fclose( mso4000 );
end


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
