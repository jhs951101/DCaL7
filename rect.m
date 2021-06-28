function X = rect(time, ts, tau)

min_time = min(time);  % min_time: �ð� ���� time�� �ּҰ�
max_time = max(time);  % max_time: �ð� ���� time�� �ִ밪
X = min_time : ts : max_time;  % X: �簢 �޽��� �ǹ��ϴ� ����
                               % �ϳ��� ���� �ƴ� �簢 �޽��� �ǹ��ϴ� �����̹Ƿ� ������ �̸� �Ҵ��س���
i = 1;  % i: �Ʒ� while���� ���� ����

while i <= (max_time - min_time) / ts + 1  % �� ������ �ð� ���� ���� ���� ������ �ǹ��ϴ� ����
                                           % ����) t = 0:1:5 �̸� 1*6 ������ �����̹Ƿ� ������ 6����
	if abs(time(1,i)) <= tau/2  % �ð� ���� -tau/2 ~ tau/2 ������ ��쿡�� �簢 �޽��� �׸�
		X(1,i) = 1;
	else
		X(1,i) = 0;
	end

	i = i + 1;
end