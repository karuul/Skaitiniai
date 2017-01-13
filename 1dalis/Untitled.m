clear all ; close all ; clc ;
ff = @(x)x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2;
saknys = roots([1 7/2 -23/2 -43/2 -15/2])
s(1)=fzero('x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2',-5)
s(2)=fzero('x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2',3)
s(3)=fzero('x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2',-1)
s(4)=fzero('x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2',-0.5)
x = min(saknys)-1:1:max(saknys)+1;
plot(x, ff(x), 'r--')
grid on;
hold on;
plot(saknys,0*saknys,'ko','MarkerFaceColor','r','Markersize',10);
title('1 Uzdavinys','FontSize',15);
legend('daugianaris','saknys')
figure(2)
gg = @(x)1.9*x.*sin(x)-(x/1.5-3).^2
x =  -10:0.1:10;
s(1)=fzero('1.9*x.*sin(x)-(x/1.5-3).^2',1)
s(2)=fzero('1.9*x.*sin(x)-(x/1.5-3).^2',2.5)
s(3)=fzero('1.9*x.*sin(x)-(x/1.5-3).^2',6)
s(4)=fzero('1.9*x.*sin(x)-(x/1.5-3).^2',8)

plot(x, gg(x), 'r--')

grid on;