% Timing storage of scalar integer
tic;
x = 42; % Example integer assignment
elapsed_int = toc;

% Timing storage to MAT-file
data = rand(1000); % Example large matrix
tic;
save('example.mat', 'data');
elapsed_matfile = toc;

% Timing storage to CSV file
tic;
writematrix(data, 'example.csv');
elapsed_csv = toc;

fprintf('Time to store integer: %f seconds\n', elapsed_int);
fprintf('Time to store MAT-file: %f seconds\n', elapsed_matfile);
fprintf('Time to store CSV file: %f seconds\n', elapsed_csv);
