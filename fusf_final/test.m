% Example data: 2D matrix
Z = rand(100, 4);  % 2D data with 100 rows and 4 columns (100x4 pixels)

% Plot the data using imagesc()
imagesc(Z)

% Add a color bar
c = colorbar;
c.Ruler.TickLabelFormat = '%g kPa';

% Access the current axes
ax = gca;

% Adjust the x-axis: each pixel on the x-axis represents 20 μm
% Set x-tick positions and labels
ax.XTick = 1:1:4;  % Tick positions (4 pixels wide)
ax.XTickLabel = (1:1:4) * 20;  % Convert pixel index to micrometers

% Adjust the y-axis: each pixel on the y-axis represents 100 μm
% Set y-tick positions and labels
ax.YTick = 1:10:100;  % Tick positions (100 pixels tall)
ax.YTickLabel = (1:10:100) * 100;  % Convert pixel index to micrometers

% Label the x-axis and y-axis with units
xlabel('x-axis (20 μm per pixel)');
ylabel('y-axis (100 μm per pixel)');

% Add a title to the plot
title('Plot with scaled x-axis and y-axis');

% Set the aspect ratio to be equal
% This ensures that the size of one pixel on the y-axis is five times the length of one pixel on the x-axis
axis equal;
