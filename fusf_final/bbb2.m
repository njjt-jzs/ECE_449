revol_a = 21;
revol_b = 24;
a = (1*0.001/(10^(-252/20))) * 10^(-9); %% 1 mV to 1kPa
        differences = zeros(revol_a, revol_b);

    % Iterate over each MATLAB variable
    for i = 1:revol_a
        for j = 1:revol_b

        % Load the MATLAB variable from the MAT file
        filename = fullfile('C:\Users\Jinzhi Shen\Desktop\fusf_redo\test_scan', sprintf('matlab_%d_%d.mat', i,j));
        loaded_data = load(filename);  % Load the variable from the MAT file
        data = loaded_data.wave;

        max_val = max(data(:));
        min_val = min(data(:));

        val = max_val - min_val;
        differences(i,j) = val *20/88 * a;
        end
    end
[X, Y] = meshgrid(1:revol_b, 1:revol_a);
different_matrix = differences';

% Plot the differences as a 2D color map
imagesc(different_matrix);

% Add labels and colorbar
xlabel('y-aixs 50 μm pixel size');
ylabel('z-axis 50 μm pixel size');
colorbar;
title('Ultrasound Field in color (kPa)');

figure;
plot3(X(:), Y(:), differences(:), 'o');
xlabel('Column Index (revol_b)');
ylabel('Row Index (revol_a)');
zlabel('Difference');
title('Differences 3D Plot');

% Create a surface plot
figure;
surf(X, Y, differences);
xlabel('Column Index (revol_b)');
ylabel('Row Index (revol_a)');
zlabel('Difference');
title('Differences Surface Plot');
