%Oilerio metodas
function oileris

clc, clear all,
close all
spalva=['y'; 'm'; 'c'; 'r'; 'g'; 'b']; %spalvos

m1 = 0.3; % Pirmojo objekto masë (kg)
m2 = 0.3; % Antrojo objekto masë (kg)
v0 = 60; % Pradinis greitis (m/s)
ks = 0.005; % Sujungtø kûnø oro pasiprieðinimo koef. (kg/m)
ts = 2; % Judëjimo kartu laikas (s)
k1 = 0.05; % Oro pasiprieðinimo koef. 1-am objektui (kg/m)
k2 = 0.01; % Oro pasiprieðinimo koef. 2-am objektui (kg/m)
tmax = 10; % Objektø buvimo ore laikas
% kg * m/s^2

x=0;% pradinës reikðmës x - laikas, y - greitis

step_variations = 3; % Kiek yra skirtingø þingsniø
%dx=[0.3 0.7 1]; % þingsnis
dx=[0.1 0.15 0.2]; % þingsnis
%disp(dx(1))
figure(1), hold on, grid on, axis([0,10,-30,80]);
title('Stabilumo tyrimas (Oilerio metodas)')
ylabel('Greitis, m/s')
xlabel('Laikas, s')
set(gca,'XTick', 0:1:15);
plot(x,v0,'ro');
h = 0; % Piesti legendom
hend = 1;
for a=1:step_variations
    nsteps=tmax/dx(a); % þingsniø kiekis
    pntx=0;
    pnty1=v0;
    pnty2=v0;
    v1(1) = v0;
    v2(1) = v0;
    x=0;
    for i=1:nsteps+1
        if(x < ts)
            v1(i+1) = v1(i) + dx(a)*DY((m1+m2), ks, v1(i));
            v2(i+1) = v1(i+1);
        else
            v1(i+1) = v1(i) + dx(a)*DY(m1, k1, v1(i));
            v2(i+1) = v2(i) + dx(a)*DY(m2, k2, v2(i));
        end

        plot(x,v1(i),[spalva(2*a-1),'.'],'MarkerSize',2);
        plot(x,v2(i),[spalva(2*a),'.'],'MarkerSize',2);
        
        h(hend) = plot([pntx,x],[pnty1,v1(i)],[spalva(2*a-1),'-']);
        if (i < 2) 
            hend = hend+1;
        end
        h(hend) = plot([pntx,x],[pnty2,v2(i)],[spalva(2*a),'-']);
        if (i < 2) 
            hend = hend+1;
        end
            
        pntx = x;    
        x=x+dx(a);
        pnty1 = v1(i);
        pnty2 = v2(i);
    end
end
%hh = h([1, 3, 5]);
%legend('labs', 'krabs', 'maps', 'Location', 'Best');
legend(h([1 2 3 4 5 6]),'\Deltat = 0.1, 1 objektas',...
    '\Deltat = 0.1, 2 objektas',...
    '\Deltat = 0.15, 1 objektas',...
    '\Deltat = 0.15, 2 objektas',...
    '\Deltat = 0.2, 1 objektas',...
    '\Deltat = 0.2, 2 objektas',...
    'Location', 'Best');
return

function dy=DY(m, k, v)
    g = 9.8; % Laisvojo kritimo pagreitis
    if (v < 0)
        dy = -(m.*g - k.*v.^2)/m;
    else
        dy = -(m.*g + k.*v.^2)/m;
    end
return, end

end