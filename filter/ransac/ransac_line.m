function [bestParameter1,bestParameter2] = ransac_line(data,num,iter,threshDist,inlierRatio)
 % data: a 2xn dataset with #n data points
 % num: the minimum number of points. For line fitting problem, num=2
 % iter: the number of iterations
 % threshDist: the threshold of the distances between points and the fitting line
 % inlierRatio: the threshold of the number of inliers 
 % �Q�lURL : https://en.wikipedia.org/wiki/Random_sample_consensus
 %% Plot the data points
 % ������
 number = size(data,2); % Total number of points
 bestInNum = 0; % Best fitting line with largest number of inliers
 bestParameter1=0;
 bestParameter2=0; % parameters for best fitting line
 
 for i=1:iter
 %% Randomly select 2 points
 % �����_����2�|�C���g�𒊏o
    idx = randperm(number,num);
    sample = data(:,idx);   
 
 %% Compute the distances between all points with the fitting line 
 % ���ׂĂ̓_�ƃ��f�����Ƃ̋������v�Z����B
    %���f�����̌v�Z
    kLine = sample(:,2)-sample(:,1);% two points relative distance
    %���f�����̖@���x�N�g�����v�Z
    kLineNorm = kLine/norm(kLine);
    normVector = [-kLineNorm(2),kLineNorm(1)];%Ax+By+C=0 A=-kLineNorm(2),B=kLineNorm(1)
    %�@���x�N�g���Ƃ��ׂĂ̓_�Ɠ��ς��Ƃ邱�ƂŁA���f��������̋������v�Z����B
    distance = normVector*(data - repmat(sample(:,1),1,number));
     
 %% Compute the inliers with distances smaller than the threshold
 % 臒l���߂��_���v�Z����
     inlierIdx = find(abs(distance)<=threshDist);
     inlierNum = length(inlierIdx);
     
 %% Update the number of inliers and fitting model if better model is found     
 % ���悢���f�������������ꍇ�A���f�������X�V����B
    if inlierNum>=round(inlierRatio*number) && inlierNum>bestInNum
         bestInNum = inlierNum;
         parameter1 = (sample(2,2)-sample(2,1))/(sample(1,2)-sample(1,1));
         parameter2 = sample(2,1)-parameter1*sample(1,1);
         bestParameter1 = parameter1;
         bestParameter2 = parameter2;
    end
 end
 
%  Plot the best fitting line
%  figure;plot(data(1,:),data(2,:),'o');hold on;
%  xAxis = 1:6; 
%  yAxis = bestParameter1*xAxis + bestParameter2;
%  plot(xAxis,yAxis,'r-');
%  grid on;
end
