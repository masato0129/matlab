% データ生成
data = [[0; 0; 0] [20; 0; 0] [0; 20; 0] [0.5; 0.5; 0.5] [2; 2; 2] [3; 3; 3]];

% 引数
threshDist = 1.5;
iter = 30;

% 初期化
num = 3; %　必要点数
number = size(data,2); % データ数
bestInNum = 0;
bestParam.a = 0;
bestParam.b = 0;
bestParam.c = 0;
bestParam.d = 0;

for i=1:iter
    % ランダムに3点抽出
    idx = randperm(number,num);
    sample = data(:,idx);
    
    % 平面計算　ax + by + cz +d
    ab = sample(:,2) - sample(:,1);
    ac = sample(:,3) - sample(:,1);
    
    n = cross(ab,ac);
    nNorm = n / norm(n);
    d = nNorm' * sample(:,1);
    
    % 点と平面の距離
    distance = abs(nNorm(1)*data(1,:) + nNorm(2)*data(2,:) + nNorm(3)*data(3,:) + d);
    
    % 閾値より近い点を計算する
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