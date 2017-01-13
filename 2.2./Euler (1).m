function Euler
clc, clear all,
close all

global m v0 h0 k1 k2 g
g = 9.8;
m = 0.2;
v0 = 50;
h0 = 100;
k1 = 0.01;
k2 = 0.005;
maxTime = 15;

eulerFunc(0.025, 'm');
eulerFunc(0.05, 'c');
eulerFunc(0.1, 'k');
eulerFunc(0.2, 'r');
eulerFunc(0.3, 'b');

% eulerFunc(0.7, 'y');
% eulerFunc(0.8, 'c');
% eulerFunc(0.9, 'm');

dv =@(t,v)(-k1*sign(v)*v(1)^2 - m*g) / m;
ds =@(t,v)v(1);

% sprendimas ode45 funkcija
[t,v]=ode45(dv, 0:0.5:maxTime, v0);
figure(1); hold on;
plot(t, v, 'g', 'LineWidth', 3);
xlabel('t'); 
ylabel('m/s')

return

function eulerFunc(timeStep, color)  
    spalva=color;
    t0=0; %laiko pradzia 
    ntimeSteps=maxTime/timeStep;
    figure(1), hold on, grid on, %axis(range);

    t=t0;
    v=v0;
    h=h0;

    plot(t,v,'ro');
    pntx=t;
    pnty=v;

%     figure(2), hold on, grid on,
%     plot(t,h,'ro');

    for i=1:ntimeSteps

     dv=DY(t,v);
     v=v+timeStep*dv(1);
     h=h+timeStep*dv(2);
     t=t+timeStep;
     if(h < 0)
         break;
     end
     figure(1), hold on, grid on,
     plot(t,v,[spalva,'.'],'MarkerSize',8)
     plot([pntx,t],[pnty,v],[spalva,'-']);
     xlabel('t'); 
     ylabel('m/s')
     
%      figure(2), hold on, grid on,
%      plot(t, h,[spalva,'*'],'MarkerSize',8)
%      xlabel('t'); 
%      ylabel('m')
     pntx=t;
     pnty=v;
    end
    
return
end

function unction dv=DY(t,v)
    if(sign(v) == 1) 
    dv = [(-k1*v(1)^2 - m*g) / m;
     v(1)];
    else
    dv = [(k2*v(1)^2 - m*g) / m;
     v(1)];
    end
return,
end

end