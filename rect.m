function X = rect(time, ts, tau)

min_time = min(time);  % min_time: 시간 변수 time의 최소값
max_time = max(time);  % max_time: 시간 변수 time의 최대값
X = min_time : ts : max_time;  % X: 사각 펄스를 의미하는 변수
                               % 하나의 값이 아닌 사각 펄스를 의미하는 변수이므로 공간을 미리 할당해놓음
i = 1;  % i: 아래 while문의 보조 변수

while i <= (max_time - min_time) / ts + 1  % 이 공식은 시간 변수 내의 공간 갯수를 의미하는 것임
                                           % 예시) t = 0:1:5 이면 1*6 형태의 벡터이므로 공간은 6개임
	if abs(time(1,i)) <= tau/2  % 시간 값이 -tau/2 ~ tau/2 사이인 경우에만 사각 펄스를 그림
		X(1,i) = 1;
	else
		X(1,i) = 0;
	end

	i = i + 1;
end