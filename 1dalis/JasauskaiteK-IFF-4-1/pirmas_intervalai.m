clear all; close all ; clc;

f = @(x)x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2;
x = -5.1:0.01:3.1;

% f = @(x)1.9*x.*sin(x)-(x/1.5-3).^2;
% x =  -10:0.1:10;

plot(x, f(x), 'g', 'LineWidth', 2);
%ylim([-2,2])
grid on; hold on;

i = -10;
zingsnis = 0.14;
%zingsnis = 0.6;

while (i <= 10)
    ats=f(i);
    ats2=f(i+zingsnis);
    P =sprintf('i=%d, ats=%d, i2=%d, ats2=%d',i,ats,i+zingsnis,ats2);   
    if (ats > 0 && ats2 < 0) || (ats < 0 && ats2 > 0) || ( ats ==  0 || ats2 == 0)
        G =sprintf('[%0.2f ; %0.2f ]',i,i+zingsnis);
        disp(G);
        plot(i, 0, '>' , ...
            'MarkerFaceColor', 'r', 'MarkerSize' , 7)
        plot(i+zingsnis, 0, '<' , ...
            'MarkerFaceColor', 'r', 'MarkerSize' , 7)   
    end
    i = i + zingsnis;
end
