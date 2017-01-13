% LD2_1.m
% Funkcijos interpoliavimas ciobysovo baze

function LD2_1
clc,close all

xmin=-3;xmax=2;  % duotas funkcijos apibrezimo intervalas 
N=10;   % interpoliavimo tasku skaicius
X=[xmin:(xmax-xmin)/(N-1):xmax];  % tolygiai paskirstytu interpoliavimo tasku abscises
k=[0:N-1];
XC=(xmax+xmin)/2+(xmax-xmin)/2*cos((2*k+1)*pi/(2*N)); % "Ciobysovo abscises"
Y=funkcija(X);     %  tolygiai paskirstytu interpoliavimo tasku ordinates
YC=funkcija(XC);   %  ordinates "Ciobysovo abscisiu" taskuose
x=min(X):(max(X)-min(X))/1000:max(X);   %x reiksmes vaizdavimui
xc=min(XC):(max(XC)-min(XC))/1000:max(XC);   %x ciobysovo reiksmes vaizdavimui

leg={'duota funkcija',...
    'tolygiai isdestyti mazgai',...
    'interpoliavimas per tolygiai isdestytus mazgus',...
    'netiktis interpoliuojant per tolygiai isdestytus mazgus'};
leg2={'duota funkcija',...
    'Ciobysovo abscises',...
    'interpoliavimas per Ciobysovo mazgus',...
    'netiktis interpoliuojant per Ciobysovo mazgus mazgus'};

figure(1), hold on, grid on,box on,axis equal, set(gcf,'Color','w'); 
plot(x,funkcija(x),'b-')   % vaizduojama duotoji funkcija (t.y. pagal kuria interpoliuojama) 
plot(X,Y,'ro','MarkerFaceColor','r','MarkerSize',8) % vaizduojami tolygiai isdestyti interpoliavimo taskai 

a=x(1); b=x(end);
Xt = (2*X-(b+a))/(b-a); % mazgus transformuojame i intervala
t=(2*x-(b+a))/(b-a);

F=cebkoef(Xt,Y);  % Ciobysovo koeficientai pagal tolygiai paskirstytas abscises
px=klensou(F, t); % Noredami apskaiciuoti polinomo reiksmes, taikom Klensou metoda
plot(x,px,'r-')      % vaizduojama funkcija, interpoliuojanti tolygiai paskirstytuose mazguose 
plot(x,funkcija(x)-px,'r--'),      % vaizduojama netiktis duotos funkcijos atzvilgiu 
legend(leg, 'Location', 'southoutside');

XtC = (2*XC-(b+a))/(b-a); % mazgus transformuojame i intervala
FC=cebkoef(XtC, YC); % ciobysovo koeficientai pagal ciobysovo abscises
pxC=klensou(FC, t); % Noredami apskaiciuoti polinomo reiksmes, taikom Klensou metoda
figure(2), hold on, grid on,box on,axis equal, set(gcf,'Color','w'); 
plot(xc,funkcija(xc),'b-')   % vaizduojama duotoji funkcija (t.y. pagal kuria interpoliuojama) 
plot(XC,YC,'ro')   % vaizduojami interpoliavimo mazgai ties ciobysovo abscisemis
plot(xc,pxC,'r-')   % vaizduojama funkcija, interpoliuojanti ciobysovo mazguose 
plot(xc,funkcija(xc)-pxC,'r--'),  % vaizduojama netiktis duotos funkcijos atzvilgiu
legend(leg2, 'Location', 'southoutside');

return
end

function kfn=cebkoef(X, y)
% cebkoef apskaièiuoja interpoliacinio polinomo, kurá apibrëþia
% interpoliavimo taðkai (x, y), koeficientus Èiobyðevo bazëje.
% Áëjimo parametrai
% (x, y)    - interpoliavimo taðkai.
% Iðëjimo parametrai
% kfn       - interpoliacinio polinomo koeficientai, pradedant
%             vyriausiuoju
    n=numel(X)-1;
    p=zeros(n+1);
    p(:,1)=y;
    for k=1:n
        for i = 1:n+1-k
            p(i,1:k+1)=([p(i+1,1:k-1)/2 p(i+1,k) 0]+[0 0 p(i+1,1:k-1)/2]-...
            [p(i,1:k-1)/2 p(i,k) 0]-[0 0 p(i,1:k-1)/2]+...
            [0 p(i,1:k)*X(i+k)-p(i+1,1:k)*X(i)])/(X(i+k)-X(i));
        end
    end
    kfn=p(1,:);
    
return
end

function px=klensou(a,x)
% KLENSOU apskaièiuoja interpoliacinio polinomo,
% uþraðyto Èiobyðovo polinomo bazëje, reikðmæ.
% Áëjimo parametrai
% a   - polinomo koeficientai,
% x   - argumento reikðmiø masyvas.
% Iðëjimo parametrai
% px  - polinomo reikðmiø masyvas. 
    n=numel(a);
    bk2=0; bk1=0;
    for k=1:n
        bk=a(k)+2*x.*bk1-bk2;
        bk2=bk1; bk1=bk;
    end;
    px=bk-x.*bk2;
end


function fnk=funkcija(x)
% apskaiciuoja interpoliuojamos funkcijos reiksmes taskuose x

% fnk=sin(5*x)+x.^2/10;
% fnk=exp(-10*x.^2);
%fnk=1./(1+3*x.^2);
fnk=exp(-x.^2).*cos(x.^2).*(x-3);
return
end