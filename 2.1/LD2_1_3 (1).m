%
%   Viename periode aprasytai funkcijai atliekama diskrecioji Furje
%   transformacija
%

function LD2_3
clc,close all,clear all
n=1000; n=round(n/2)*2+1; % tasku skaicius, nelyginis
m=(n+1)/2;    % m - harmoniku skaicius
% m=100
T=10;
dazniu_slenkstis= 2;%m    % harmoniku numeriu slenkstis triuksmu filtravimui 
ampl_slenkstis= 0.15;% 0  % harmoniku amplitudziu slenkstis triuksmu filtravimui
dt=T/n;
N=1000; % vaizdavimo tasku skaicius
dttt=T/N;

t=[0:dt:T-dt];
ttt=[-T:dttt:2*T];

% disp('kontrole:'),disp(sum(fC(3,T,t).*fC(0,T,t)))

fff=fnk(T,t); % apskaiciuojame ir pavaizduojame duota tasku seka 
figure(1),hold on,grid on,plot(t,fff,'b.-','MarkerSize',8);
legend(sprintf('Vienas funkcijos periodas n=%d tasku',n))
title('Funkcija su triuksmu')

ac0=dot(fff,fC(0,T,t))/n;
for i=1:m-1
    ac(i)=dot(fff,fC(i,T,t))*2/n;
    as(i)=dot(fff,fS(i,T,t))*2/n;
end
ac,as

figure(2),hold on
bar(0:m-1,[ac0,sqrt(ac.^2+as.^2)],0.01)
xx=axis; 
plot(xx(1:2),ampl_slenkstis*[1 1],'m--','LineWidth',3); % braizo ampl slenkscio linija
plot(dazniu_slenkstis*[1 1],xx(3:4),'g--','LineWidth',3); % braizo dazniu slenkscio linija
title('Furje amplitudziu spektras pagal kompleksinio skaiciaus moduli ')
legend({'amplitudziu spektras';'amplitudes slenkstis';'dazniu slenkstis'})


fffz=ac0*fC(0,T,ttt)
frequencies=[1:m-1];
frequencies=frequencies(find(frequencies < dazniu_slenkstis))
for i=frequencies
    if sqrt(ac(i)^2+as(i)^2) > ampl_slenkstis
        fffz=fffz+ac(i)*fC(i,T,ttt)+as(i)*fS(i,T,ttt);    
    end
end
%funkcija=sin(2.*pi.*t/T).*cos(2.*pi.*3.*t/T)+0.3;
funkcija = sin(pi.*2.*t/T).*sin(pi.*t.*0.5/T).*cos(pi.*3.*t/T)+0.2;
fffnet=fffz(:,2001:3001)
figure(3),hold on,grid on, 
plot(ttt,fffz,'r');
plot(t,fff,'b-','LineWidth',2);
plot(t, funkcija-fffnet, 'y-','LineWidth',2);

legend('Aproksimuojanti f-ja', 'Duota taðkø seka', 'Netiktis', 'Location', 'eastoutside')

dim = [0.75 0.75 0.25 0.25];
str = {sprintf('n=%d taðkø', n),...
    sprintf('m=%d harmonikø', m),... 
    sprintf('a-slenkstis=%g', ampl_slenkstis),...
    sprintf('d-slenkstis=%g', dazniu_slenkstis)};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
title(sprintf('Pagal Furje spektrà atkurta funkcija'));

funkcija = sin(pi.*2.*t/T).*sin(pi.*t.*0.5/T).*cos(pi.*3.*t/T)+0.2+0.1.*cos(2.*pi.*100.*t/T)+0.11.*cos(2.*pi.*88.*t/T);
figure(4),hold on,grid on,plot(t,funkcija,'b.-','MarkerSize',8);
legend(sprintf('Vienas funkcijos periodas n=%d tasku',n))
title('F(t) = sin(pi*2*t/T)*sin(pi*t*0.5/T)*cos(pi*3*t/T)+0.2+0.1*cos(2*pi*100*t/T)+0.11*cos(2*pi*88*t/T)')

%funkcija=sin(2.*pi.*t/T).*cos(2.*pi.*3.*t/T)+0.3;
funkcija = sin(pi.*2.*t/T).*sin(pi.*t.*0.5/T).*cos(pi.*3.*t/T)+0.2;
figure(5),hold on,grid on,plot(t,funkcija,'b.-','MarkerSize',8);
legend(sprintf('Vienas funkcijos periodas n=%d tasku',n))
title('G(t) = sin(pi*2*t/T)*sin(pi*t*0.5/T)*cos(pi*3*t/T)+0.2')

%funkcija=0.1.*cos(2.*pi.*120.*t/T)+0.11.*cos(2.*pi.*20.*t/T);
funkcija = 0.1.*cos(2.*pi.*100.*t/T)+0.11.*cos(2.*pi.*88.*t/T); %triuksmo funkcija
figure(6),hold on,grid on,plot(t,funkcija,'b.-','MarkerSize',8);
legend(sprintf('Vienas funkcijos periodas n=%d tasku',n))
title('R(t) = 0.1*cos(2*pi*100*t/T)+0.11*cos(2*pi*88*t/T)')

return
end

function c=fC(i,T,t), if i==0,c=1*cos(0*t); else, c=cos(2*pi*i/T*t); end, return, end
function s=fS(i,T,t), s=sin(2*pi*i/T*t); return, end

%------------------------------------------------------------------------------------------------------
%function rez=fnk(T,t), rez=sin(2.*pi.*t/T).*cos(2.*pi.*3.*t/T)+0.3+0.1.*cos(2.*pi.*120.*t/T)+0.11.*cos(2.*pi.*20.*t/T); return, end
function rez=fnk(T,t), rez=sin(pi.*2.*t/T).*sin(pi.*t.*0.5/T).*cos(pi.*3.*t/T)+0.2+0.1.*cos(2.*pi.*100.*t/T)+0.11.*cos(2.*pi.*88.*t/T); return, end