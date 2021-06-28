function Y = triangle(time, ts, tau)

min_time = min(time);
max_time = max(time);
Y = min_time : ts : max_time;  % Y: �ﰢ �޽��� �ǹ��ϴ� ����
i = 1;

while i <= (max_time - min_time) / ts + 1
	if time(1,i) > tau * -1 && time(1,i) < tau  % �ð� ���� -tau ~ tau ������ ��쿡�� �ﰢ �޽��� �׸�
		Y(1,i) = 1 - abs(time(1,i))/tau;
	else
		Y(1,i) = 0;
	end

	i = i + 1;
end