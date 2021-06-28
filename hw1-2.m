clear all; close all;
ts = 1 / 2000;          % Sampling Interval for Simulation;
fs = 1 / ts;

T1 = -0.05; T2 = 0.05;

time = T1:ts:T2;
df = 0.01;              % For Frequency Resolution;

B = 100;                % For Signal Bandwidth;

tau = 1/100;
x = triangle(time, ts, tau);    % Original Signal;

[X, x1, df_x] = fft_mod(x, ts, df);
X = X / fs;
X = fftshift(abs(X));

freq = (0:df_x:df_x*(length(x1)-1)) - fs/2;

AXIS_TIME = [-inf inf 0, 1.5];
figure
plot(time, x); axis(AXIS_TIME); grid on;
xlabel('time [sec]'); title('Original Signal x(t)');

AXIS_FREQ = [-5*B, 5*B, 0, 1.5*max(abs(X))];
figure
plot(freq, X); axis(AXIS_FREQ); grid on;
xlabel('frequency [Hz]'); title('Spectrum of Original Signal x(t)');

Aliasing_fs = 4*B;                          % Sampling Frequency for Aliasing Effect;
str_fs = [num2str(Aliasing_fs), 'Hz'];
Aliasing_index = round(fs / Aliasing_fs);

x_hat = zeros(1, length(x));
x_hat(1:Aliasing_index:end) = x(1:Aliasing_index:end);

[X_hat, x_hat1, df_x_hat] = fft_mod(x_hat, ts, df);
X_hat = X_hat / Aliasing_fs;
X_hat = fftshift(abs(X_hat));

figure
plot(time, x, 'k'); hold on;
stem(time, x_hat); hold on;
axis(AXIS_TIME); grid on;
xlabel('time [sec]'); title(['Aliasing Effect, Sampling Rrequency = ', str_fs]);

figure
plot(freq, X_hat);axis(AXIS_FREQ); grid on;
xlabel('frequency [Hz]'); title(['Aliasing Effect, Sampling Rrequency = ', str_fs]);