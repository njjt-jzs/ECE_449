% 创建数据
x = linspace(0, 10, 100);
y = sin(x);

% 绘制图形并指定 colormap
figure;
plot(x, y);
colormap('jet');  % 使用 jet colormap

% 添加颜色栏
colorbar;
xlabel('x');
ylabel('sin(x)');
title('Plot with Jet Colormap');

% 自定义 colormap
custom_colormap = [0 0 0; 1 0 0; 1 1 0; 1 1 1];  % 自定义 colormap，格式为 [R G B]，取值范围为 0-1
figure;
colormap(custom_colormap);  % 使用自定义的 colormap

% 绘制一些示例图形
subplot(2, 1, 1);
plot(x, y);
title('Plot with Custom Colormap');
xlabel('x');
ylabel('sin(x)');

% 使用自定义 colormap
