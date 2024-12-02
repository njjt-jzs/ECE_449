% Number of time steps
t = 1:20;

% Starting locations of 30 points
x = 100 * rand(30, 1);
y = 100 * rand(30, 1);

% Starting temperatures for each point
T = 20 + 500 * rand(30, 1);

% Create figure
figure;
scatterPlot = scatter(x, y, 100, T, 'filled'); % Initial scatter plot
caxis([min(T), max(T)]); % Set color axis limits
colorbar; % Display colorbar
title('Temperature Animation');
xlabel('X Coordinate');
ylabel('Y Coordinate');

% Simulate temperature changes over time
for i = 1:length(t)
    % Update temperatures (example: random noise added)
    T = T + randn(size(T)) * 10;
    
    % Update scatter plot data
    scatterPlot.CData = T;
    
    % Pause to create animation effect
    pause(0.5);
end
