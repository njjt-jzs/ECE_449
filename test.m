% Define the frequency range
omega = linspace(-2*pi, 2*pi, 1000);

% Define the rectangular function in frequency domain
rect_omega = double(abs(omega) <= pi);

% Define the sinc-like function in frequency domain
sinc_like = sin(7 * omega / 2) ./ sin(omega / 2);
sinc_like(isnan(sinc_like)) = 7; % Handle the NaN at omega = 0

% Perform convolution of rect and sinc-like function in frequency domain
conv_result = conv(rect_omega, sinc_like, 'same');
conv_result = conv_result / max(conv_result); % Normalize for display

% Define the frequency axis for the convolution result
omega_conv = linspace(-2*pi, 2*pi, length(conv_result));

% Plot the rectangular function
subplot(3, 1, 1);
plot(omega, rect_omega, 'LineWidth', 1.5);
title('Rectangular Function in Frequency Domain');
xlabel('\omega');
ylabel('Amplitude');
grid on;

% Plot the sinc-like function
subplot(3, 1, 2);
plot(omega, sinc_like, 'LineWidth', 1.5);
title('Sinc-like Function in Frequency Domain');
xlabel('\omega');
ylabel('Amplitude');
grid on;

% Plot the convolution result
subplot(3, 1, 3);
plot(omega_conv, conv_result, 'LineWidth', 1.5);
title('Convolution of Rectangular and Sinc-like Functions');
xlabel('\omega');
ylabel('Amplitude');
grid on;
