%% will generate revol+1 data point as we ask to move revol and has one data at origin

input_axis_1D = 'x'; %% x,y,z
step_size = 5;
total_length = 125;



oneD_scan(input_axis_1D, step_size, total_length);





%% the function that do the 1D scan, the input to this function is 
%% info_axis : choosing it is x-scan, y-scan or z-scan
%% step_size_1D : choosing the step size of each step
%% total_length : the steps that we should take to move in 1D
function oneD_scan(input_axis_1D, step_size_1D, total_length)
init_helper
    revol = round(total_length/abs(step_size_1D)); %% take the whole number to do whole rounds of scan
    data_generator('1');
    for i= 2:revol
            
            i_str = num2str(i); % Convert integer i to a string
            motor_mover(step_size_1D,input_axis_1D);
            data_generator(i_str);

    end

    oneD_plothelper(revol);
clear_helper

end




%%%%%%%%%%
% start of helper functions
%%%%%%

%% redefine the function for both use since no matter 1D, 2D, 3D we all only move motor on one axis at a time
%% name for 1D will be 1,2,3,4...
%% name for 2D will be 1_1,1_2, ...
%% name for 3D will be 1_1_1, 1_1_2, ...

function motor_mover(step_size,input_axis_1D)

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



 %% Fun gen sending burst signal begin
    function data_generator(round_num)
    %%visainst = visa('ni', 'USB0::0x0957::0x1507::MY48003157::0');

    fopen(visainst);

    % set the wave for the square, 10 khz, 5vpp, 30% duty cycle
    fprintf(visainst, 'TRIG:SOUR BUS;*TRG;*WAI;*TRG;*WAI');
    fclose(visainst);


    %% Fun gen sending burst signal end

    %% Scanning process begin
    %% start the laser scan on chanel3
   mso4000 = visa( 'ni','USB0::0x1AB1::0x04B1::DS4A175000664::0::INSTR' );
   mso4000.InputBufferSize = 2048;

   fopen(mso4000);
   flushinput(mso4000);
   %% checking in 100 data collected whether we received a laser trigger signal
   %% laser signal is around 10hz while the data acquisition rate is 4G/HZ which means we acquire 100 data 
   %% 40,000 kHz which is much larger than 10hz

    fprintf(mso4000, ':WAV:SOUR CHAN4' );

    fprintf(mso4000, ':wav:data?' );

    
    [data,len]= fread( mso4000, 2048);

    fclose( mso4000 );
    
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

   pause(2);
end

function clear_helper() 
        clear s;
        fclose(visainst);
        fclose( mso4000 );
end
