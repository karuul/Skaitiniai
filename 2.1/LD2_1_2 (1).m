% 1 Eilës Splaino interpoliavimas

function LD2_2
clc,close all,clear all 
hL=[]; % busimu objektu valdikliu masyvas A raidei
hL2=[]; % busimu objektu valdikliu masyvas B raidei
f=figure; hold on; grid on
% A raide
XA=[ 2.984  1.024  -0.04086  0.05764  0.1955  3.753]
YA=[ -1.946  0.4064  -1.991  -0.8453  -0.4382  -0.2629]

% B raide
XB=[ 4.2 4.5   3.8897  4.005  4.574  5.074 4.2 ]
YB=[ -0.545 0.5 0.8514 -1.497 -1.462 -1 -0.545 ]

global iper
iper=1;  % 0 - splainas laisvais galais 
         % 1 - periodinis splainas 
         
nA=length(XA);
nB=length(XB);

      % parametru reiksmes yra atstumai tarp interpoliavimo tasku
t(1)=0; for i=2:nA, t(i)=t(i-1)+norm([XA(i) YA(i)]-[XA(i-1) YA(i-1)]); end
t2(1)=0; for i=2:nB, t2(i)=t2(i-1)+norm([XB(i) YB(i)]-[XB(i-1) YB(i-1)]); end


figure(1);axis([-3,4,-3,3]);axis equal;hold on;

% vaizduojame duotus taskus
for i=1:nA, h(i)=plot(XA(i), YA(i),'ko','MarkerFaceColor','k',...
        'ButtonDownFcn',@startDragFcn,'MarkerSize',10); end
for i=1:nB, h2(i)=plot(XB(i), YB(i),'ko','MarkerFaceColor','k',...
        'ButtonDownFcn',@startDragFcn,'MarkerSize',10); end
    % tasku objektu valdikliai issaugomi masyve h;
    % funkcijoje startDragFcn nurodoma, ka reikia atlikti, kai peles
    % klavisa paspaudziame jai esant ties sukurtu grafiniu objektu h(i) 

splainu_parametrinis_interpoliavimas(XA,YA,t);  %interpoliuojame pagal ivestus taskus
splainu_parametrinis_interpoliavimas(XB,YB,t2);  %interpoliuojame pagal ivestus taskus

function splainu_parametrinis_interpoliavimas(X,Y,t)
nP=length(X) % interpoliavimo tasku skaicius
% 
% iper=1;  % 0 - splainas laisvais galais 
%          % 1 - periodinis splainas  
DDFX=splaino_koeficientai(t,X,iper);
DDFY=splaino_koeficientai(t,Y,iper);

for iii=1:nP-1  %------  ciklas per intervalus tarp gretimu tasku

nnn=100;
[SX,sss]=splainas(t(iii:iii+1),X(iii:iii+1),DDFX(iii:iii+1),nnn);
[SY,sss]=splainas(t(iii:iii+1),Y(iii:iii+1),DDFY(iii:iii+1),nnn);
hL(iii)=plot(SX,SY,'k-','LineWidth',2,'MarkerSize',8)

end %-----------------ciklas per intervalus pabaiga
% splaino intervalu objektu valdikliai issaugomi masyve hL

return
end


function DDF=splaino_koeficientai(X,Y,iper)
% apskaiciuojamos antros isvestines splaino mazguose
% iopt=1 - periodinis splainas

n=length(X);
A=zeros(n);b=zeros(n,1);
d=X(2:n)-X(1:(n-1));
 for i=1:n-2
     A(i,i:i+2)=[d(i)/6, (d(i)+d(i+1))/3,d(i+1)/6];
     b(i)=(Y(i+2)-Y(i+1))/d(i+1)-(Y(i+1)-Y(i))/d(i);
 end
 
if iper == 0,  A(n-1,1)=1;A(n,n)=1;
else, A(n-1,[1,2,n-1,n])=[d(1)/3, d(1)/6, d(n-1)/6,d(n-1)/3]; 
      A(n,[1,n])=[1,-1];  
      b(n-1)=(Y(2)-Y(1))/d(1)-(Y(n)-Y(n-1))/d(n-1);
end

DDF=A\b;
 
return
end


function [S,sss]=splainas(X,Y,DDF,nnn)
% splaino intervale tarp dvieju tasku apskaiciavimas
% nnn - vaizdavimo tzku skaicius
% S - splaino reiksmes
% sss - vaizdavimo abscises
d=X(2)-X(1);
sss=X(1):(X(2)-X(1))/(nnn-1):X(2);
S=DDF(1)/2*(sss-X(1)).^2+(DDF(2)-DDF(1))/(6*d)*(sss-X(1)).^3+(sss-X(1))*((Y(2)-Y(1))/d-DDF(1)*d/3-DDF(2)*d/6) +Y(1);

return
end


end   % Sis end uzbaigia pagrindine funkcija
