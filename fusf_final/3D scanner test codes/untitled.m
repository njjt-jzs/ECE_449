    % Store the maximum and minimum differences in a cell array
    revol_a = 21;
    revol_b = 24;
    differences = zeros(revol_a, revol_b);

    % Iterate over each MATLAB variable
    for i = 1:revol_a
        for j = 1:revol_b

        % Load the MATLAB variable from the MAT file
        filename = fullfile('C:\Users\Jinzhi Shen\Desktop\fusf_redo\test_scan', sprintf('matlab_%d_%d.mat', i,j));
        loaded_data = load(filename);  % Load the variable from the MAT file
        wave = loaded_data.wave;

        wave = wave';

    
        fftSpec = fft( wave', 2048 );

        threshold = 100; % Adjust the threshold as needed

% Find indices of FFT values below the threshold
        low_magnitude_indices = abs(fftSpec) < threshold;

% Set values below the threshold to zero
        fftSpec(low_magnitude_indices) = 0;
      

        restored_wave = ifft(fftSpec, 'symmetric');

        max_val = max( restored_wave(1:1400));
        min_val = min( restored_wave(1:1400));

        val = max_val - min_val;
        differences(i,j) = val;
        end
    end
[X, Y] = meshgrid(1:revol_b, 1:revol_a);
% Reverse the y-axis direction
%%differences = flipud(differences);

% Plot the differences as a 2D color map
imagesc(differences);

% Add labels and colorbar
xlabel('Column Index y 5 * 0.01 scale');
ylabel('Row Index z 5 * 0.01 scale');
colorbar;
title('Differences Heatmap');

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
