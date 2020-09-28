% MTH 5050 - HW 5 - Part b
% Designing a low pass filter that eliminates high frequencies

close all; clear variables; clc;

rng default  % For random noise generator
M = 256;     % Sampling points (FFT is more efficient when it's a power of 2)
t = 0:1/M:1-1/M;   % Equally space points
f = sin(2*pi*5*t) + sin(2*pi*100*t)+ randn(size(t)) ; % Signal with noise

Fs = 512;  % Sampling frequency should be twice the largest frequency
wc = 50;   % Threshold Freq = 50 Hz
hs = (-M/2:M/2);
% The filter in the physical domain is the sinc function
h = sinc(2*wc.*hs./Fs)*(2*wc/Fs);

% Zero pad the signal and impulse response:
xzp = [ f zeros(1,M) ];
hzp = [ h zeros(1,M-1) ];

F = fft(xzp);           % Transform signal
H = fft(hzp);           % Transform filter
    
psdx = abs(F);          % Power spectrum of original signal
FH = F .* H; 
psdl = abs(FH);         % Power spectrum of filtered signal
fhat = real(ifft(FH));  % Inverse Fourier Transform to get f*g
figure; 
% use 10*log10() to see the power spectrum in more detail
plot(1:M,10*log10(psdx(1:M)),'-b','Linewidth',1.5); hold on;
plot(1:M,10*log10(psdl(1:M)),'-r');  % PSD plot of corrected signal
title('Power Spectral Density of input signal and filtered signal using FFT')
xlabel('Frequency (Hz)');ylabel('Power (dB)'); legend('Original','Filtered');

% Plot original signal
figure; plot(t,f); hold on;
% Plot corrected signal
plot(t,fhat(M/2+1:end-M/2),'-r','Linewidth',1.5); %Ignore the response time of filtered signal                                        
title('Original signal and filtered signal');
xlabel('Time (seconds)'); ylabel('f(t)'); legend('Original','Filtered');
