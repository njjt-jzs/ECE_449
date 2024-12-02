% Store the maximum and minimum differences in a 3D array
revol_a = 2;
revol_b = 3;
revol_c = 2; % Assuming there are three sets of data

differences = zeros(revol_a, revol_b, revol_c);

% Iterate over each MATLAB variable
for i = 1:revol_a
    for j = 1:revol_b
        for k = 1:revol_c
            % Load the MATLAB variable from the MAT file
            filename = fullfile('C:\Users\Jinzhi Shen\Desktop\fusf_redo\test_scan', sprintf('matlab%d_%d_%d.mat', i, j, k));
            loaded_data = load(filename);  % Load the variable from the MAT file
            data = loaded_data.wave;

            max_val = max(data(:));
            min_val = min(data(:));

            val = max_val - min_val;
            differences(i, j, k) = val;
        end
    end
end

[X, Y, Z] = meshgrid(1:revol_b, 1:revol_a, 1:revol_c);

V = differences;

xslice = [2];   
yslice = [];
zslice = 2;
slice(X,Y,Z,V,xslice,yslice,zslice)