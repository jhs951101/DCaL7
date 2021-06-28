clear all; close all;
ts = 1 / 2000;  % ts: Sampling Interval for Simulation;
fs = 1 / ts;

T1 = -10; T2 = 10;

time = T1:ts:T2;
df = 0.01;  % df: Frequency Resolution;

B = 1;
x = sinc(B*time);  % x: original signal

p_ts = 0.2;         % p_ts: Sampling time for practical sampling;
p_width = 0.04;     % p_width: Pulse width;

pt = zeros(1, length(time));  % pt: 0.04 만큼의 폭을 가진 사각 펄스;
pt(time > -p_width/2 & time <= p_width/2) = 1;

[PF, pt1, df_pt] = fft_mod(pt, ts, df);  % PF: pt를 푸리에 변환한 값
PF = PF/fs;
PF = fftshift(abs(PF));

freq_pt = (0:df_pt:df_pt*(length(pt1)-1)) - fs/2;  % freq_pt: 주파수 영역을 의미하는 x축

p_ts_index = p_ts / ts;  % p_ts_index: Sampling 했을 때 생기는 선의 갯수
p_width_index = p_width / ts;  % p_width_index: p_width 값을 주기로 했을 때 생기는 막대기의 갯수

p_col = fix( length(x) / p_ts_index );  % p_col: Sampling 했을 때 나타나는 선의 세로 길이
p_row = p_ts_index;  % p_row: Sampling 했을 때 생기는 선의 갯수 (= p_ts_index)

y = x(1:p_row*p_col);  % y: original signal 값의 일부

y_hat1 = reshape(y, p_row, p_col);  % y_hat1: Natural Sampling에서 사용될 시간 영역 변수
                                    % sinc() 함수라고 생각해도 무방함

y_hat1( fix(p_width_index/2)+1 : end-fix(p_width_index/2), : ) = 0;
% y_hat1 값 중 특정한 부분만 0으로 바꿔줌

y_hat1 = y_hat1(:)';

y_hat1 = [y_hat1, zeros(1, length(x)-p_row*p_col)];  % 좌표계에 표현될 수 있도록 설정

y_hat2 = reshape(y, p_row, p_col);  % y_hat2: Flat-top Sampling에서 사용될 시간 영역 변수

y_hat2( fix(p_width_index/2)+1 : end-fix(p_width_index/2), : ) = 0;
% 특정한 부분만 0으로 바꿔줌

init_value = y_hat2(end-fix(p_width_index/2)+1, : ); 

init_matrix = ones(fix(p_width_index/2), 1)*init_value;

y_hat2(end-fix(p_width_index/2)+1:end, : ) = init_matrix;
y_hat2(1:fix(p_width_index/2), : ) = [y_hat2(1:fix(p_width_index/2), 1), init_matrix(:, 1:end-1)];
% y_hat1 의 경우, Sampling 막대기들이 original signal의 윤곽을 띄웠다면,
% y_hat2 에서는 Sampling 했을 때 나타나는 막대기들이 사각형 모양이 되도록 해줌

y_hat2 = y_hat2(:)';

y_hat2 = [y_hat2, zeros(1, length(x)-p_row*p_col)];

[X, x1, df_x] = fft_mod(x, ts, df);  % X: original signal 값을 푸리에 변환한 값
X = X / fs;
X = fftshift(abs(X));
freq_x = (0:df_x:df_x*(length(x1)-1)) - fs/2;

[Y_HAT1, y_hat11, df_yhat1] = fft_mod(y_hat1, ts, df);  % Y_HAT1: Natural Sampling 값을 푸리에 변환한 값
Y_HAT1 = Y_HAT1 * (p_ts);
Y_HAT1 = Y_HAT1 / fs;
Y_HAT1 = fftshift(abs(Y_HAT1));
freq_yhat1 = (0:df_yhat1:df_yhat1*(length(y_hat11)-1)) - fs/2;

[Y_HAT2, y_hat22, df_yhat2] = fft_mod(y_hat2, ts, df);  % Y_HAT2: Flat-top Sampling 값을 푸리에 변환한 값
Y_HAT2 = Y_HAT2 * (p_ts);
Y_HAT2 = Y_HAT2 / fs;
Y_HAT2 = fftshift(abs(Y_HAT2));
freq_yhat2 = (0:df_yhat2:df_yhat2*(length(y_hat22)-1)) - fs/2;

AXIS_TIME1 = [-4, 4, -0.5, 1.5];
AXIS_TIME2 = [-2, 2, -0.5, 1.5];  % AXIS_TIME: 좌표계에 표현하기 위해 x축의 범위와 y축의 범위를 의미하는 변수
figure
plot(time, x); 
grid on; axis(AXIS_TIME1);
xlabel('time [sec]'); title('Original signal x(t)');

figure
plot(time, x, 'k'); hold on;
stairs(time, y_hat1, 'b'); hold on;
grid on; axis(AXIS_TIME2);
xlabel('time [sec]'); title('Practical Sampling : Natural Sampling');

figure
plot(time, x, 'k'); hold on;
stairs(time, y_hat2, 'b'); hold on;
grid on; axis(AXIS_TIME2);
xlabel('time [sec]'); title('Practical Sampling : Flat-top Sampling');

AXIS_FREQ1 = [-5*B, 5*B, 0, 1.2];
AXIS_FREQ2 = [-25*B, 25*B, 0, 0.05];
figure
plot(freq_x, X);
grid on; axis(AXIS_FREQ1);
xlabel('frequency [Hz]'); title('Specturm of Original signal x(t)');

figure
plot(freq_pt, PF, 'k'); hold on;
stairs(freq_yhat1, Y_HAT1, 'b'); hold on;
grid on; axis(AXIS_FREQ2);
xlabel('frequency [Hz]'); title('Specturm of Natural Sampling');

figure
plot(freq_pt, PF, 'k'); hold on;
stairs(freq_yhat1, Y_HAT2, 'b'); hold on;
grid on; axis(AXIS_FREQ2);
xlabel('frequency [Hz]'); title('Specturm of Flat-top Sampling');