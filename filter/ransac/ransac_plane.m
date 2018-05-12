function [bestParam,bestInNum] = ransac_plane(data, iter, threshDist, limInNum)
%{
    % データ生成
    %data = [[0; 0; 10] [0; 10; 10] [10; 0; 10] [0; 10; 12] [0; 10; 12] [0; 10; 12]];
    beam1 = [4.02 ; 0.00; 15];
    beam2 = [2.01 ; 3.48; 15];
    beam3 = [-2.01; 3.48; 15];
    beam4 = [-4.02; 0.00; 15];
    beam5 = [-2.01;-3.48; 15];
    beam6 = [2.01 ;-3.48; 15];
    data = [beam1 beam2 beam3 beam4 beam5 beam6];

    % 引数
    threshDist = 1.5;
    iter = 30;
    limInNum = 4;
%}
    % 初期化
    num = 3; %　平面を求めるために必要な点数
    number = size(data,2); % データ数
    bestInNum = 0;
    bestParam.a = 0;
    bestParam.b = 0;
    bestParam.c = 0;
    bestParam.d = 0;

    for i=1:iter
        % ランダムに3点抽出
        idx = randperm(number,num);
        idx = [1,2,3];
        sample = data(:,idx);

        % 平面計算　方程式 ax + by + cz +d = 0
        ab = sample(:,2) - sample(:,1);
        ac = sample(:,3) - sample(:,1);

        n = cross(ab,ac);
        nNorm = n / norm(n);
        d = nNorm' * sample(:,1);

        % 点と平面の距離
         distance = abs(nNorm(1)*data(1,:) + nNorm(2)*n(2,:) + nNorm(3)*data(3,:) - d)/ ...
             sqrt( sum(nNorm.^2));


% 閾値より近い点を計算する
        inlierIdx = find(abs(distance)<=threshDist);
        inlierNum = length(inlierIdx);

        if inlierNum >= limInNum && inlierNum>bestInNum
            bestInNum = inlierNum;
            bestParam.a = nNorm(1);
            bestParam.b = nNorm(2);
            bestParam.c = nNorm(3);
            bestParam.d = d;
        end
    end
end