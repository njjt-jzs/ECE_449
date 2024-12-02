% Store the maximum and minimum differences in a cell array
differences = zeros(1, 6);

% Iterate over each MATLAB variable
for i = 1:6
    % Load the MATLAB variable from the MAT file
    filename = fullfile('test_graphic', sprintf('matlab_%d.mat', i));
    field_name = sprintf('matlab_%d', i);
    loaded_data = load(filename);  % Load the variable from the MAT file
    data = loaded_data.wave;

    max_val = max(data(:));
    min_val = min(data(:));

    val = max_val - min_val;
    differences(i) = val;
end

[X, Y] = meshgrid(1:6, 1);  % 生成 1x6 的网格
Z = zeros(size(X));  % 初始化 Z 矩阵

for i = 1:6
    Z(:, i) = differences(i);  % 将 Z 的每一列设为对应的 differences(i) 值
end

% 绘制热图
imagesc(Z);

% 添加颜色栏
colorbar;

% 添加标签和标题
xlabel('Variable Index');
ylabel('Y');
title('Heatmap of Differences');


% Plot differences
figure;
bar(differences);
xlabel('Variable Index');
ylabel('Difference');
title('Maximum - Minimum Differences');



% Plot differences
figure;
plot(differences, '-o', 'LineWidth', 2, 'MarkerSize', 10);
xlabel('Variable Index');
ylabel('Difference');
title('Maximum - Minimum Differences');
grid on; % add grid



