%global x_move y_move z_move;
global x_move y_move z_move;
x_move = 0;
y_move = 0;
z_move = 0;

input_dimension = input('Enter type of scan :', "s"); %% the motion could be 1D 2D 3D
input_axis = input('Enter axis info of scanning :', "s"); %% x,y,z being selected or not
input_string_len = input('Enter length on three axis:' , "s"); %% input of the area in step size that you want to scan on each axis 
                                               % limitation of 1000 so input should be in form like "10,10,10" 
step_sizes_cell_len = strsplit(input_string_len, ',');
global len_x len_y len_z;
len_x = str2double(step_sizes_cell_len{1});
len_y = str2double(step_sizes_cell_len{2});
len_z = str2double(step_sizes_cell_len{3});

%% the movement's direction is determined in step's being positive or negative
                                            
input_string_step = input('Enter step_size info: ', 's');

step_sizes_cell = strsplit(input_string_step, ',');

global step_x step_y step_z;
step_x = str2double(step_sizes_cell{1});
step_y = str2double(step_sizes_cell{2});
step_z = str2double(step_sizes_cell{3});

abs_step_x = abs(step_x);
abs_step_y = abs(step_y);
abs_step_z = abs(step_z);


% Check the input dimension
if strcmp(input_dimension, "1D")

 %% basic judge on whether this 1D scan could be performed
 

 %% judgement logic ends

 
 %    disp('Initiate 1D scan');

     if strcmp(input_axis, "100")
         input_axis_1D = "x";
          step_size = step_x;
          total_length = len_x;
     elseif strcmp(input_axis, "010")
         input_axis_1D = "y";
          step_size = step_y;
          total_length = len_y;
     elseif strcmp(input_axis, "001")
         input_axis_1D = "z";
          step_size = step_z;
          total_length = len_z;
     end

     oneD_scan(input_axis_1D, step_size, total_length);

elseif strcmp(input_dimension, "2D")
     %%disp('Initiate 2D scan');
     if strcmp(input_axis, "110")
         input_axis_2D = "xy";
         len_a = len_x;
         len_b = len_y;
         step_a = step_x;
         step_b = step_y;
     elseif strcmp(input_axis, "101")
         input_axis_2D = "xz";
         len_a = len_x;
         len_b = len_z;
         step_a = step_x;
         step_b = step_z;
     elseif strcmp(input_axis, "011")
         input_axis_2D = "yz";
         len_a = len_y;
         len_b = len_z;
         step_a = step_y;
         step_b = step_z;
     end
      
      twoD_scan(input_axis_2D,len_a,len_b,step_a,step_b)
      %% for 2D scan, we will begin to apply the global variable usage

elseif strcmp(input_dimension, "3D")
     disp('Initiate 3D scan');
     threeD_scan();
else
     disp('Error input, quit the program');
end




%% the function that do the 1D scan, the input to this function is 
%% info_axis : choosing it is x-scan, y-scan or z-scan
%% step_size_1D : choosing the step size of each step
%% total_length : the steps that we should take to move in 1D
function oneD_scan(input_axis_1D, step_size_1D, total_length)
    global x_move y_move z_move;
    global len_x len_y len_z;
    global step_x step_y step_z;
    revol = round(total_length/abs(step_size_1D)); %% take the whole number to do whole rounds of scan
    data_generator('1');
    for i= 2:revol
            
            i_str = num2str(i); % Convert integer i to a string
            motor_mover(step_size_1D,input_axis_1D);
            data_generator(i_str);

            %% keep record of what we have moved to
            if strcmp(input_axis_1D, 'x') 
                x_move = x_move + step_x;
            elseif strcmp(input_axis_1D, 'y') 
                y_move = y_move + step_y;
            elseif strcmp(input_axis_1D, 'z') 
                z_move = z_move + step_z;
            end

    end

    oneD_plothelper(revol);

end

function twoD_scan(input_axis_2D,len_a,len_b,step_a,step_b)

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
 revol_a = abs(len_a/step_a);
 revol_b = abs(len_b/step_b);
j = 1;
   for i= 1:revol_a
        if mod(i, 2) == 0
        str = [num2str(i) '_' num2str(revol_b)];
        else
        str = [num2str(i) '_' num2str(1)];
        end
       data_generator(str);
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
           motor_mover(step_size_a,a_axis);
           step_size_b = -step_size_b;
   end

   %%twoD_plothelper(revol_a,a_axis,revol_b,b_axis);

end

function threeD_scan()
    global x_move y_move z_move;
    global len_x len_y len_z;
    global step_x step_y step_z; %% now we are able to do use the global varaible

    revol_a = abs(len_x/step_x);
    revol_b = abs(len_x/step_x);
    revol_c = abs(len_x/step_x);

    for k = 1:revol_c  %% so let's imagine this as doing layers on z-axis of xy 2D scan
        if mod(i, 2) == 0
        str = [num2str(i) '_' num2str(revol_b) '_'num2str(k)];
        else
        str = [num2str(i) '_' num2str(1)];
        end
       data_generator(str);
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
           motor_mover(step_size_a,a_axis);
           step_size_b = -step_size_b;
   end
    end

end
%%%%%%%%%%
% start of helper functions
%%%%%%

%% redefine the function for both use since no matter 1D, 2D, 3D we all only move motor on one axis at a time
%% name for 1D will be 1,2,3,4...
%% name for 2D will be 1_1,1_2, ...
%% name for 3D will be 1_1_1, 1_1_2, ...

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
        message = ['0000,', padded_step_size,'0000'];
    elseif strcmp(input_axis_1D, "z")
        message = ['0000,', '0000',padded_step_size];
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
    %% motor motion end

    %% Fun gen sending burst signal begin
    function data_generator(round_num)
    visainst = visa('ni', 'USB0::0x0957::0x1507::MY48003157::0');

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

%% the helper function that helps to plot the oneD diagram
function oneD_plothelper(revol)
    % Store the maximum and minimum differences in a cell array
    differences = zeros(1, revol);

    % Iterate over each MATLAB variable
    for i = 1:revol
        % Load the MATLAB variable from the MAT file
        filename = fullfile('C:\Users\Jinzhi Shen\Desktop\fusf_redo\test_scan', sprintf('matlab_%d.mat', i));
        loaded_data = load(filename);  % Load the variable from the MAT file
        data = loaded_data.wave;

        max_val = max(data(:));
        min_val = min(data(:));

        val = max_val - min_val;
        differences(i) = val;
    end

    [X, Y] = meshgrid(1:revol, 1); 
    Z = zeros(size(X));  %%initialize the z matrix
    for i = 1:revol
        Z(:, i) = differences(i);  % euqals the value in z to the value in 
    end

    %plot the image with color bar
    imagesc(Z);  
    colorbar;

    % Note that currently for better viewing, the 1D diagram is also shown
    % as 2D plot 
    xlabel('Variable Index : step_size * 0.01 mm');
    ylabel('Y');
    title('1D ultrasound field');


    % Plot differences in normal stirng plot way
    figure;
    plot(differences, '-o', 'LineWidth', 2, 'MarkerSize', 10);
    xlabel('Variable Index');
    ylabel('Difference');
    title('Maximum - Minimum Differences');
    grid on; % add grid


    end






