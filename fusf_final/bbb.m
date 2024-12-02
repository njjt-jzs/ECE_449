revol_a = 100;
revol_b = 4;
differences = zeros(revol_a, revol_b);
a = (1*0.001/(10^(-257/20))) * 10^(-9); %% 1 mV to 1kPa

% Iterate over each MATLAB variable and calculate differences
for i = 1:revol_a
    for j = 1:revol_b
        % Load the MATLAB variable from the MAT file
        filename = fullfile('C:\Users\Jinzhi Shen\Desktop\fusf_redo\test_scan', sprintf('matlab_%d_%d.mat', i, j));
        loaded_data = load(filename); % Load the variable from the MAT file
        data = loaded_data.wave;
        
        % Calculate max and min values
        max_val = max(data(:));
        min_val = min(data(:));
        
        % Calculate the difference and store it in the array
        differences(i, j) = (max_val - min_val)*6.25*10^(-1)*a;
    end
end
different_matrix = differences';
% Create meshgrid for plotting
[X, Y] = meshgrid(1:revol_b, 1:revol_a);

% Plot the differences as a 2D heatmap
figure;
imagesc(differences');

% Use the hot colormap (or any colormap you prefer)
colormap(hot);
c = colorbar; % Add a colorbar
c.Ruler.TickLabelFormat = '%g kPa';


% Set x-axis and y-axis labels
xlabel('y-axis (μm)');
ylabel('z-axis (μm)');
title('2D Scan Peak to Peak Pressure');


% Multiply the x-axis tick labels by 10 to represent a length of 10 units per pixel
xticklabels(xticks * 20);
yticklabels(yticks * 100);

% Set the y-axis tick marks as you prefer (keep the current default or adjust as needed)
yticks(0:revol_a);
set(gca, 'YDir', 'normal');
axis equal;
set(gca, 'DataAspectRatio', [1 0.1 1]);
% Plot the 3D scatter plot
figure;
xticks(0:revol_b);
yticks(0:revol_a);
plot3(X(:), Y(:), differences(:), 'o');
xlabel('z-axis (μm)');
ylabel('y-axis (μm)');
zlabel('Peak to Peak Pressure (kPa)');
title('2D Scan Peak to Peak Pressure');
view(3); % Adjust view angle for vertical z-axis
xticklabels(xticks * 100);
yticklabels(yticks * 20);


% Create a surface plot
figure;
surf(X, Y, differences);
xlabel('z-axis');
ylabel('y-axis');
zlabel('Sound level (kPa)');
title('Ultrasound Field in surface');
view(3); % Adjust view angle for vertical z-axis

