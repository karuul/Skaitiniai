
function ode
clc, clear all,
close all
global m m1 m2 v0 v1 v2 ks k1 k2;
m1 = 0.3; % Pirmojo objekto masë (kg)
m2 = 0.3; % Antrojo objekto masë (kg)
m = m1 + m2;
v0 = 60; % Pradinis greitis (m/s)
ks = 0.005; % Sujungtø kûnø oro pasiprieðinimo koef. (kg/m)
ts = 2; % Judëjimo kartu laikas (s)
k1 = 0.05; % Oro pasiprieðinimo koef. 1-am objektui (kg/m)
k2 = 0.01; % Oro pasiprieðinimo koef. 2-am objektui (kg/m)
tmax = 10; % Objektø buvimo ore laikas

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sprendimas ode45 funkcija
[T,X]=ode45(@DY,[0 ts], v0);
v1 = X(end);
v2 = v1;
[T1,X1]=ode45(@DY1,[ts tmax], v1);
[T2,X2]=ode45(@DY2,[ts tmax], v2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1); hold on;
plot(T,X,'y.-');
plot(T1,X1,'g.-');
plot(T2,X2,'r.-');
title('Sprendimas su ode45 funkcija')
ylabel('Greitis, m/s')
xlabel('Laikas, s')
legend('Objektai krito kartu', '1-asis objektas', '2-asis objektas')

function dy=DY(t, v)
    g = 9.8; % Laisvojo kritimo pagreitis
    if (v < 0)
        dy = -(m.*g - ks.*v.^2)/m;
    else
        dy = -(m.*g + ks.*v.^2)/m; 
    end
return, end

function dy1=DY1(t, v)
    g = 9.8; % Laisvojo kritimo pagreitis
    if (v < 0)
        dy1 = -(m1.*g - k1.*v.^2)/m1;
    else
        dy1 = -(m1.*g + k1.*v.^2)/m1;
    end
end

function dy2=DY2(t, v)
    g = 9.8; % Laisvojo kritimo pagreitis
    if (v < 0)
        dy2 = -(m2.*g - k2.*v.^2)/m2;
    else
        dy2 = -(m2.*g + k2.*v.^2)/m2;
    end
end

end