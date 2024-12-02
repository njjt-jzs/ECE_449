% Initialize arrays to store all wave segments
wave_segments = cell(200, 1); % Cell array to store the segments
a = (1*0.001/(10^(-257/20))) * 10^(-9); %% 1 mV to 1kPa
% Load and process all .mat files
for i = 1:200
    % Load each .mat file dynamically
    data = load(sprintf('C:\\Users\\shenJ\\Desktop\\twoD_data\\matlab_%d.mat', i));
    wave = data.wave;

    % Find the maximum value and its index
    [max_val, max_idx] = max(wave);

    % Define the range (100 values before and after the max)
    range = max(1, max_idx - 15):min(length(wave), max_idx + 10);

    % Extract the section around the maximum value
    wave_segments{i} = wave(range) * 6.25*10^(-1)*a;
end


% 初始化2D矩阵以存储热图数据
n_points = 200; % 数据点数
n_frames = length(wave_segments{1}); % 每个波段的帧数
heatmap_data = zeros(n_points, n_frames); % 热图数据矩阵

% 填充热图数据矩阵，每一列表示某一时刻的波段值
for i = 1:n_points
    % 确保所有帧数对齐
    wave_length = length(wave_segments{i});
    heatmap_data(i, 1:wave_length) = wave_segments{i};
end

% Compute global color axis limits
mini = min(heatmap_data(:));
maxi = max(heatmap_data(:));
caxis([mini, maxi]);
% Create the initial plot outside the loop
Z = heatmap_data(:, 1); % Use the first frame's data to initialize
h = imagesc(reshape(Z, [1, 200])); % Create the initial plot


% Access the current axes and configure them
ax = gca;
ax.YTick = []; % Remove y-axis ticks
ax.YTickLabel = {}; % Remove y-axis tick labels
xticks(1:10:200); % Set x-axis ticks
xticklabels((1:10:200) * 20); % Convert to μm for x-axis labels

% Configure axis labels and title
xlabel('y-axis (μm)');
ylabel(''); % Hide y-axis label
title('1D Scan Peak to Peak Pressure');

c = colorbar;

% Set the tick label format for the color bar to show values in kPa
c.Ruler.TickLabelFormat = '%g kPa';

% Customize color bar ticks and labels
%%c.Ticks = linspace(min_val, max_val, 5); % Set custom ticks

% Animation loop
for t = 1:n_frames
    % Update the plot's data
    Z = heatmap_data(:, t);
    set(h, 'CData', reshape(Z, [1, 200])); % Update the data in the existing plot
    
    % Force MATLAB to render the updated frame
    drawnow;

    % Pause to control frame rate
    pause(0.2); % Adjust the duration as needed
end

