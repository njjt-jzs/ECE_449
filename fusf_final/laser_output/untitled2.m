differences = cell(1,6);

% Iterate over each MATLAB variable
for i = 1:6
    % Find the maximum and minimum values
    max_val = max(matlab_{i}(:));
    min_val = min(matlab_{i}(:));
    
    % Calculate the difference
    difference = max_val - min_val;
    
    % Store the difference in the cell array
    differences{i} = difference;
end