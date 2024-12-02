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
        data = loaded_data.wave;

        % Sort the data in ascending order
        sorted_data = sort(data(:));

        % Calculate the average of the maximum ten values
        max_avg = mean(sorted_data(end-9:end));

        % Calculate the average of the minimum ten values
        min_avg = mean(sorted_data(1:10));

        % Calculate the difference using the averages
        differences(i,j) = max_avg - min_avg;
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

% Define the function to fit
model_func = @(params, indices) params(1) ./ ((21 - indices(:, 2)).^2 + indices(:, 1).^2);

% Initial guess for the parameters
initial_guess = 1;

% Perform least squares curve fitting
params_fit = lsqcurvefit(model_func, initial_guess, [X(:), Y(:)], differences(:));

% Calculate the fitted values
fit_values = model_func(params_fit, [X(:), Y(:)]);

% Reshape the fitted values to the same size as differences
fit_values_reshaped = reshape(fit_values, size(differences));

% Calculate the loss (residual sum of squares)
loss = sum((fit_values - differences(:)).^2);

% Display the fitted parameters and loss
disp('Fitted Parameters:');
disp(params_fit);
disp(['Loss: ', num2str(loss)]);
