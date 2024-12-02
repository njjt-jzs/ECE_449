% Define the zeros and poles based on the problem
zeros = [-1, exp(1j*5*pi/6), exp(-1j*5*pi/6), exp(1j*2*pi/3), exp(-1j*2*pi/3)];
poles = [0.5, 0.5*exp(1j*pi/6), 0.5*exp(-1j*pi/6), 0.5*exp(1j*pi/3), 0.5*exp(-1j*pi/3)];

% Gain factor (given in the problem that H(1) = 1.0)
gain = 1;

% Convert zeros and poles to second-order sections
[sos, g] = zp2sos(zeros, poles, gain);

% Extract the numerator and denominator coefficients from the SOS matrix
% Each row in the sos matrix contains [b0 b1 b2 1 a1 a2], we need only first 3 columns for numerator and last 3 for denominator
num = sos(:, 1:3);  % Numerator coefficients [b0 b1 b2]
den = sos(:, 4:6);  % Denominator coefficients [1 a1 a2]

% Create the dsp.SOSFilter object
sosFilter = dsp.SOSFilter(num, den);  % Now pass the num and den matrices

% Example: Apply the filter to a random input signal
inputSignal = randn(1024, 1); % Example input signal (random noise)
outputSignal = sosFilter(inputSignal);

% Plot the magnitude response of the filter
fvtool(sosFilter);
