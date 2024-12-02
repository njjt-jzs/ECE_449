[X, Y] = meshgrid(1:6, 1);  
Z = zeros(size(X));  


differences = [10, 20, 30, 40, 50, 60];  

for i = 1:6
    Z(:, i) = differences(i);  
end


imagesc(Z);

colorbar;

xlabel('Variable Index');
ylabel('Y');
title('Heatmap of Differences');
