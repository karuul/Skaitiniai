
% Niutono metodas
function pagrindine
clc,close all

eps=1e-10
itmax=100
x=[1;1;1;1];
% x=[-0.828147  6.95332  -4.33552  2.98925]'

for iii=1:itmax
     deltax=-df(x)\f(x);
    x=x+deltax;
    tikslumas=norm(deltax)/(norm(x)+norm(deltax));
    
            fprintf(1,'\n iteracija %d  tikslumas %g',iii,tikslumas);
    if tikslumas < eps
        fprintf(1,'\n sprendinys x =');        fprintf(1,'  %g',x);
        fprintf(1,'\n funkcijos reiksme f =');  fprintf(1,'  %g',f(x));
        break
    elseif iii == itmax
        fprintf(1,'\n ****tikslumas nepasiektas. Paskutinis artinys x =');
        fprintf(1,'  %g',x);
        fprintf(1,'\n funkcijos reiksme f =');
        fprintf(1,'  %g',f(x));
        break
    end
    
end
    return
end

%   Lygciu sistemos funkcija 
function F=f(X) 
 F(1)=3*X(1)+5*X(2)+3*X(3)+X(4)-8;
 F(2)=X(1)^2+2*X(2)*X(4)-5;
 F(3)=-3*X(2)^2-3*X(1)*X(2)+2*X(4)^3+16;
 F(4)=5*X(1)-15*X(2)+3*X(4)+22;
 F=F(:);
 return
end 

    
%  Jakobio matrica
function DF=df(X) 
 DF(1,1)=3;       DF(1,2)=5;       DF(1,3)=3;   DF(1,4)=1;
 DF(2,1)=2*X(1);    DF(2,2)=2*X(4);     DF(2,3)=0;  DF(2,4)=2*X(4);
 DF(3,1)=-3*X(1);  DF(3,2)=-3*X(1)-6*X(2);  DF(3,3)=0;     DF(3,4)=6*X(3)^2;
 DF(4,1)=5;     DF(4,2)=-15;    DF(4,3)=0;      DF(4,4)=3;
 return
end
