% Load the MATLAB variable from the MAT file
filename = 'C:\Users\Jinzhi Shen\Desktop\fusf_redo\test_scan\matlab_1_1.mat'; % Change the filename as needed
loaded_data = load(filename); % Load the variable from the MAT file
wave = loaded_data.wave;

% Ensure wave is a row vector
wave = wave(:)';

% Perform FFT on the wave data
N = 2048; % Length of FFT
fftSpec = fft(wave, N);

% Calculate the frequency axis
sampling_rate = 1; % Example sampling rate (Hz)
freqAxis = (0:N-1) * (sampling_rate / N);

% Calculate the magnitude of the FFT
magnitude_fft = abs(fftSpec);

% Plot the magnitude of the FFT
figure;
plot(freqAxis, magnitude_fft);
title('FFT of the Wave Data');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0, sampling_rate / 2]); % Display up to half the sampling rate (Nyquist frequency)
grid on;
