% Specify the full path to the text file
filePath = 'C:/Users/shenj/Desktop/aaa.txt';

% Open the file for appending ('a' mode adds to the file without overwriting)
fileID = fopen(filePath, 'w');  % Use 'w' mode to overwrite the file instead of appending

% Check if the file was opened successfully
if fileID == -1
    error('Failed to open the file.');
end

% Write information to the file
fprintf(fileID, 'hwhw');

% Close the file
fclose(fileID);

disp('Information successfully written to aaa.txt on the desktop.');
