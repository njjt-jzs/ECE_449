% Sample time-domain signal
Fs = 100;               % Sampling frequency
t = 0:1/Fs:2;           % Time vector from 0 to 2 seconds
f = 5;                  % Signal frequency in Hz
signal = sin(2*pi*f*t); % Sinusoidal signal

% Set up the video writer
video = VideoWriter('time_domain_signal.avi'); % Create a video file
video.FrameRate = 30;                          % Set frame rate
open(video);

% Create figure for plotting
figure;

for i = 1:length(t)
    % Plot up to the current time point
    plot(t(1:i), signal(1:i), 'b', 'LineWidth', 1.5);
    hold on;
    
    % Mark the current time point
    plot(t(i), signal(i), 'ro', 'MarkerSize', 8);
    
    % Axis settings
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Time-Domain Signal Animation');
    axis([0 max(t) -1.5 1.5]);
    
    hold off;
    
    % Capture the plot as a frame
    frame = getframe(gcf);
    writeVideo(video, frame); % Write the frame to the video file
    
    pause(0.01); % Pause to control the speed of the animation
end

% Close the video file
close(video);

disp('Video created successfully!');
