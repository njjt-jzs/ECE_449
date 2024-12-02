% Store the maximum and minimum differences in a cell array
revol_a = 2;
revol_b = 15;
differences = zeros(revol_a, revol_b);

% Iterate over each MATLAB variable
for i = 1:revol_a
    for j = 1:revol_b
        % Load the MATLAB variable from the MAT file
        filename = fullfile('C:\Users\Jinzhi Shen\Desktop\fusf_redo\test_scan', sprintf('matlab%d_%d.mat', i,j));
        loaded_data = load(filename);  % Load the variable from the MAT file
        data = loaded_data.wave;

        max_val = max(data(:));
        min_val = min(data(:));

        val = max_val - min_val;
        differences(i,j) = val;
    end
end

% Create meshgrid
[X, Y] = meshgrid(1:revol_b, 1:revol_a);

% Create a surface plot
figure;
surf(X, Y, differences);
xlabel('Column Index (revol_b)');
ylabel('Row Index (revol_a)');
zlabel('Difference');
title('Differences Surface Plot');
