% Frequency axis
omega = linspace(-pi, pi, 1000);

% Define the magnitude response R(omega)
R = abs(sin(omega)); % Example magnitude response (you can use any function for R(omega))

% Phase shift term e^(-j3*omega) introduces a linear phase shift
phase_shift = -3 * omega;

% H(e^jω) has the same magnitude as R(omega) but with a phase shift
H_magnitude = R; % Magnitude remains the same
H_phase = phase_shift; % Phase is affected by the -3ω term

% Plot the magnitude and phase responses
figure;

% Plot the magnitude response
subplot(2,1,1);
plot(omega, H_magnitude);
title('Magnitude Response |H(e^{j\omega})| = R(\omega)');
xlabel('Frequency (\omega)');
ylabel('Magnitude');

% Plot the phase response
subplot(2,1,2);
plot(omega, H_phase);
title('Phase Response of H(e^{j\omega}) = -3\omega');
xlabel('Frequency (\omega)');
ylabel('Phase (radians)');
