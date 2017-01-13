
% Niutono metodas
function pagrindine
clc,close all
scrsz = get(0,'ScreenSize')

x=[-10:0.5:10];y=[-10:0.5:10];

Z=pavirsius(@f,x,y);
fig1=figure(1);
set(fig1,'Position',[50 scrsz(4)/1.8 scrsz(3)/3 scrsz(4)/3],'Color','w');
hold on,grid on,axis equal,axis([min(x) max(x) min(y) max(y) 0 5]);
view([0 0 1]);xlabel('x'),ylabel('y');
xx=axis; fill([xx(1),xx(1),xx(2),xx(2)],[xx(3),xx(4),xx(4),xx(3)],'b','FaceAlpha',0.2);

eps=1e-5;itmax=30;

for i=-10:0.5:10
    for j= -10:0.5:10
    x=[i;j];
ff=f(x); dff=df(x);
figure(1);
alpha=1;   %0.9   %0.8; %  0.5   % zingsnio sumazinimo koeficientas
artinys=x;
for iii=1:itmax
    dff=df(x); deltax=-dff\ff; x1=x+alpha*deltax; ff1=f(x1);
figure(1);

    tikslumas=norm(deltax)/(norm(x)+norm(deltax));
    
%     fprintf(1,'\n iteracija %d  tikslumas %g',iii,tikslumas);
    
    if tikslumas < eps, 
%         fprintf(1,'\n sprendinys x ='); 
%         fprintf(1,' %g  ',x); 

       if(-6<x(1)&&x(1)<-3&&5<x(2)&&x(2)<8), scatter(artinys(1),artinys(2), 'b', 'full');
        end
        if(-5<x(1)&&x(1)<-2&&4<x(2)&&x(2)<5), scatter(artinys(1),artinys(2), 'r', 'full');
        end
        if(-4<x(1)&&x(1)<-1&&3<x(2)&&x(2)<4), scatter(artinys(1),artinys(2), 'g', 'full');
        end
        if(-6<x(1)&&x(1)<-3&&-8<x(2)&&x(2)<-5), scatter(artinys(1),artinys(2), 'y', 'full');
        end
        if(-5<x(1)&&x(1)<-2&&-6<x(2)&&x(2)<-3), scatter(artinys(1),artinys(2), 'c', 'full');
        end
        if(-4<x(1)&&x(1)<-1&&-3<x(2)&&x(2)<-2), scatter(artinys(1),artinys(2), 'm', 'full');
        end

        break;
    elseif iii == itmax,
%         fprintf(1,'\n ****tikslumas nepasiektas. Paskutinis artinys x =  %g',x');
        scatter(artinys(1),artinys(2), '+k');
%         break;
    end
    
    x=x1;ff=ff1;    
end
    end
end
 fprintf(1,' \n ');   
    return
end


%   Lygciu sistemos funkcija 
    function fff=f(x)
    fff=[(x(1)^2+x(2)^2)/5-2*cos(x(1)/2)-6*cos(x(2))-8;
         (x(1)/2)^5+(x(2)/2)^4-4];
    return
    end
 
%  Jakobio matrica
    function dfff=df(x)
        dfff=[(2*x(1))/5 + sin(x(1)/2), (2*x(2))/5 + 6*sin(x(2));
              (5*x(1)^4)/32, x(2)^3/4];
    return
    end
    
    function Z=pavirsius(funk,x,y)
    for i=1:length(x)
        for j=1:length(y)
            Z(i,j,1:2)=funk([x(i),y(j)]);
        end
    end
        
    return
    end