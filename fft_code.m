%%%%%%%%%%% APPENDIX %%%%%%%%%%%%%
% MTH 5050 - HW 5 - Part a

close all; clear variables;  clc; 

% Import audio file
dolphinFile = 'dolphin.wav';
[t,fs] = audioread(dolphinFile);
dolphinSound = t(2.5e4:2.9e4); % Analyze a subset of the audio
t = 10*(0:1/fs:(length(dolphinSound)-1)/fs);

figure(1);
plot(t,dolphinSound);
title('Bottlenose Dolphin Sound Wave');
xlabel('Time (seconds)')
ylabel('Amplitude')

y = fft(dolphinSound);    

figure(2)
f = (0:n-1)*(fs/n)/10; % frequency vector
% Power is the squared magnitude of a signal's Fourier transform,
% normalized by the number of frequency samples
power = abs(y).^2/n;   % power spectrum      
plot(f,power);
xlabel('Frequency (Hz)');
ylabel('Normalized Power (dB)');
xlim([0 1000]);
title('Power Spectral Density Plot of a Dolphin''s sound wave');

