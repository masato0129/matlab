close all;
clear;

data = 20*(rand(2,6));
data = data.*rand(2,6);
x_range = 1:6;
y_range = ones(1,6)*15 + x_range;
rowdat = [x_range; y_range];
[a,b] = ransac_line(rowdat,2,30,0.5,0.5);
ransac_line = a*x_range + b;

plot(rowdat(1,:),rowdat(2,:),'o'); hold on
plot(x_range,ransac_line,'-'); hold on
