clear all; close all; clc;
figure(1) = image(imread('carxy.jpg'));
[X,Y] = ginput(30)
yylim = ylim
dify = yylim(2)-yylim(1)
Y = dify-Y
dlmwrite('carxxx.txt', X);
dlmwrite('caryyy.txt', Y); fclose all;