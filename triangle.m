function Y = triangle(time, ts, tau)

min_time = min(time);
max_time = max(time);
Y = min_time : ts : max_time;  % Y: 삼각 펄스를 의미하는 변수
i = 1;

while i <= (max_time - min_time) / ts + 1
	if time(1,i) > tau * -1 && time(1,i) < tau  % 시간 값이 -tau ~ tau 사이인 경우에만 삼각 펄스를 그림
		Y(1,i) = 1 - abs(time(1,i))/tau;
	else
		Y(1,i) = 0;
	end

	i = i + 1;
end