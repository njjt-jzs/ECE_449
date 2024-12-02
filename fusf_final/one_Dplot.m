revol = 200   
a = (1*0.001/(10^(-257/20))) * 10^(-9); %% 1 mV to 1kPa
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
        differences(i) = val *6.25*10^(-1)*a;
    end

    [X, Y] = meshgrid(1:revol, 1); 
    Z = zeros(size(X));  %%initialize the z matrix
    for i = 1:revol
        Z(:, i) = differences(i);  % euqals the value in z to the value in 
    end

% Plot the data using imagesc(), converting it to a 2D array
imagesc(reshape(Z, [1, 200]))

% Add a color bar
c = colorbar;

% Set the tick label format for the color bar to show values in kPa
c.Ruler.TickLabelFormat = '%g kPa';

% Access the current axes
ax = gca;

% Remove the y-axis tick marks and labels by setting them to empty arrays
ax.YTick = [];
ax.YTickLabel = {};

% Rescale the x-axis to show real distances in micrometers
xticks(1:10:200); % Adjust the spacing of ticks as needed
xticklabels((1:10:200) * 20); % Convert to μm

% Label the x-axis with the unit in micrometers
xlabel('y-axis (μm)');

% Hide the y-axis label (already empty due to previous step)
ylabel(c, '')

% Add a title to the plot
title('1D Scan Peak to Peak Pressure');

    x = 1:200;
    x_real = x * 20;
    % Plot differences in normal stirng plot way
    figure;
    plot(x_real,differences, '-o', 'LineWidth', 2, 'MarkerSize', 10);
    
    xlabel('y-aixs(μm)');
    ylabel('Peak to Peak Pressure (kPa)');
    title('1D Scan Peak to Peak Pressure');
    grid on; % add grid
