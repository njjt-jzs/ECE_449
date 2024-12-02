filename = fullfile('C:\Users\Jinzhi Shen\Desktop\fusf_redo\test_scan', sprintf('matlab_%d_%d_%d.mat', 1,1,1));
            loaded_data = load(filename);  % Load the variable from the MAT file
            data = loaded_data.wave;

time_interval = 2e-09;
dt = time_interval;
fs = 1/dt;
data_form = data(1:1000);
plot(data_form);

ime_array = linspace(0, (1000 - 1) * time_interval, 1000);

%time domian signal
plot(ime_array,data_form);

% Calculate the average of data_form
data_average = mean(data_form);

%Subtract the average from each element in data_form
data_form_subtracted = data_form - data_average;

t_f = fft(data_form_subtracted);
m = length(t_f);
freq = (-m/2:(m/2-1)) *fs/(m-1);
figure
plot(freq,fftshift(abs(t_f)));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum');
[max_fft, max_index] = max(fftshift(abs(t_f)));
max_frequency = freq(max_index);

% Display the frequency at which the maximum value occurs
disp('Frequency at which the maximum value occurs:');
disp(abs(max_frequency));