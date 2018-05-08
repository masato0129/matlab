% �f�[�^����
data = [[0; 0; 0] [20; 0; 0] [0; 20; 0] [0.5; 0.5; 0.5] [2; 2; 2] [3; 3; 3]];

% ����
threshDist = 1.5;
iter = 30;

% ������
num = 3; %�@�K�v�_��
number = size(data,2); % �f�[�^��
bestInNum = 0;
bestParam.a = 0;
bestParam.b = 0;
bestParam.c = 0;
bestParam.d = 0;

for i=1:iter
    % �����_����3�_���o
    idx = randperm(number,num);
    sample = data(:,idx);
    
    % ���ʌv�Z�@ax + by + cz +d
    ab = sample(:,2) - sample(:,1);
    ac = sample(:,3) - sample(:,1);
    
    n = cross(ab,ac);
    nNorm = n / norm(n);
    d = nNorm' * sample(:,1);
    
    % �_�ƕ��ʂ̋���
    distance = abs(nNorm(1)*data(1,:) + nNorm(2)*data(2,:) + nNorm(3)*data(3,:) + d);
    
    % 臒l���߂��_���v�Z����
    inlierIdx = find(abs(distance)<=threshDist);
    inlierNum = length(inlierIdx);
    if inlierNum>=4 && inlierNum>bestInNum
        bestInNum = inlierNum;
        bestParam.a = nNorm(1);
        bestParam.b = nNorm(2);
        bestParam.c = nNorm(3);
        bestParam.d = d;
    end
end