
%% will generate revol+1 data point as we ask to move revol and has one data at origin

input_axis_1D = 'x'; %% x,y,z
step_size = 5;
total_length = 125;



oneD_scan(input_axis_1D, step_size, total_length);





function oneD_scan(input_axis_1D, step_size_1D, total_length)
    init_helper;
    step_amount_1D = round(total_length/abs(step_size_1D)); %% take the whole number to do whole rounds of scan
    data_generator('1');
    
    motor_mover_line(step_size_1D,input_axis_1D,step_amount_1D);

    for i= 2:(revol+1)
            
            i_str = num2str(i); % Convert integer i
            % to a string
            data_generator(i_str);
            %%pause(); %% this needs to be change to sync oscilloscope
            %%pause is in Arduino

    end
   clear_helper;
  

end




%%%%%%%%%%
% start of helper functions
%%%%%%

%% motor mover helper funciton

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
    intermediate  = fprintf(tcpClient, '%d,%d,%d,%d', a, step_size_1D, c, step_amount_1D);
 else
    % Pad the step_size with zeros
    c = 0;
    intermediate = fprintf('%d,%d,%d,%d', a, abs(step_size_1D), c, step_amount_1D);
 end

message = ['s,', intermediate];


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
   %% s = serialport("COM6", 115200);
   %% s.OutputBufferSize = 20;

%% open funciton generator port
    visainst = visa('ni', 'USB0::0x0957::0x1507::MY48003157::0');
    fopen(visainst);

%% open oscilloscope
   mso4000 = visa( 'ni','USB0::0x1AB1::0x04B1::DS4A175000664::0::INSTR' );
   mso4000.InputBufferSize = 2048;
   fopen(mso4000);
   pause(2);

%% open wifi port
   esp8266_ip = '192.168.4.1'; 
   esp8266_port = 5000; 
   tcpClient = tcpip(esp8266_ip, esp8266_port);
   set(tcpClient, 'Timeout', 5);
   fopen(tcpClient);
end

function clear_helper() 
        clear s;
        fclose(visainst);
        fclose( mso4000 );

        %% clear wifi access point
        fclose(tcpClient);
        delete(tcpClient);
        clear tcpClient;
end
