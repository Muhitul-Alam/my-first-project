% =========================================================================
% Project Title: DSB-SC Modulation and Coherent Demodulation Simulation
% Author: Muhitul-Alam
% Description: This script simulates the generation, transmission, and 
%              coherent detection of a DSB-SC signal using a low-pass filter.
% =========================================================================

clear; clc; close all;

%% Parameters
Fs = 10000;               % Sampling frequency (Hz)
t = 0:1/Fs:0.5;           % Time vector (0.5 seconds)
Am = 1;                   % Amplitude of message signal
Ac = 2;                   % Amplitude of carrier signal
fm = 10;                  % Frequency of message signal (Hz)
fc = 100;                 % Frequency of carrier signal (Hz)

%% 1. Signal Generation
message = Am * cos(2*pi*fm*t);  % Message (Modulating) Signal
carrier = Ac * cos(2*pi*fc*t);  % Carrier Signal

%% 2. DSB-SC Modulation
% Modulated Signal s(t) = m(t) * c(t)
modulated = message .* carrier;

%% 3. Coherent Demodulation
% Multiply the received signal by a local carrier
mixed = modulated .* cos(2*pi*fc*t);

% Design a Low-Pass Butterworth Filter to extract the message
[b, a] = butter(5, (2*fm*1.5)/Fs); % Cutoff slightly above message frequency
demodulated = filter(b, a, mixed);

% Scale the demodulated signal to match original amplitude tracking
demodulated = demodulated * (2 / Ac); 

%% 4. Plotting the Results
figure('Name', 'DSB-SC Modulation & Demodulation', 'NumberTitle', 'off');

% Message Signal
subplot(4,1,1);
plot(t, message, 'b', 'LineWidth', 1.5);
title('1. Message Signal (m(t))');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Carrier Signal
subplot(4,1,2);
plot(t, carrier, 'r');
title('2. Carrier Signal (c(t))');
xlabel('Time (s)'); ylabel('Amplitude');
xlim([0 0.1]); % Zoomed in to see carrier oscillations
grid on;

% Modulated Signal
subplot(4,1,3);
plot(t, modulated, 'k');
title('3. DSB-SC Modulated Signal (s(t))');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Demodulated Signal
subplot(4,1,4);
plot(t, demodulated, 'g', 'LineWidth', 1.5);
title('4. Demodulated Signal (Recovered m(t))');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Adjust layout
sgtitle('DSB-SC Communication System Simulation');
