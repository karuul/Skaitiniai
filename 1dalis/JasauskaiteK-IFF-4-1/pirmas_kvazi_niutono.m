
clc, close all
syms f x 

x0=-5.10; % parenkame pradini artini
x01=-1.90;  % kirstiniu metodui parenkame antra pradini artini  
deltax=0.3; % parenkame pradine zingsnio reiksme (reikalinga tik kirstiniu metodui)
nitmax=100; % parenkame didziausia leistina iteraciju skaiciu


%f='x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2'
%  range=[-5.10 ; -4.96 ]
%  x0=-5.10; 
% x01=-4.96; 
%range=[-1.04 ; -0.90 ]
% x0=-1.04; 
% x01=1.0; 
% range=[-0.62 ; -0.48 ]
%  x0=-0.62; 
%  x01=-0.48; 
% range=[2.88 ; 3.02 ]
% x0=2.88; 
%  x01=3.5;


f = '1.9*x.*sin(x)-(x/1.5-3).^2'
% range=[1.40 ; 2.00 ]
%  x0=1.40; 
% x01=2.00; 
% range=[2.60 ; 3.20 ]
%  x0=2.60; 
% x01=3.20; 
% range=[6.20 ; 6.80 ]
%  x0=6.20; 
% x01=6.80; 
range=[8.60 ; 9.20 ]
 x0=8.60; 
x01=9.20; 
    

eps=1e-9;  % Parenkame tiksluma

 method='secants'; 

if strcmp(method,'secants'),
    x=x01;fxn1=eval(f);x=x0;fxn=eval(f);
    dfxn=(fxn1-fxn)/(x01-x0); end  % Taikant kirstiniu metoda, reiks apskaiciuoti , 
                                   % pradines kirstines krypti pagal du pradinius artinius

% braizomas funkcijos grafikas:
npoints=1000; xrange=range(1): (range(2)-range(1))/(npoints-1) :range(2);  
figure(1); grid on; hold on; axis equal; str=[char(f),'=0;   Method of ',method];title(str);
x=xrange; % simbolinis x keiciamas reiksmemis is parinkto funkcijos vaizdavimo intervalo 

    plot(x,eval(f),'r-');
    plot(range,[0 0],'b-');
    plot(x0,0,'mp');
    h = findobj(gca,'Type','line');
    h1=h(1);

       % input('Press Enter'), figure(1); % skaiciavimas stabdomas iki bus paspaustas Enter klavisas

%------------------------   SPRENDIMAS  -----------------------------------
xn=x0;prec=1;nit=0;
if strcmp(method,'secants'), 
    xn1=x01; 
    plot([xn,xn,xn1,xn1],[0,fxn,fxn1,0],'k-');
end % antras pradinis artinys
while prec > eps    % iteracijos 
    nit=nit+1;
    if nit > nitmax, fprintf('Virsytas leistinas iteraciju skaicius');break;end

            xn1=xn-fxn/dfxn;
            plot([xn,xn,xn1],[0,fxn,0],'k-');
            delete(h1);plot(xn1,0,'mp');h = findobj(gca,'Type','line');h1=h(1);
            x=xn1;fxn1=eval(f);dfxn=(fxn1-fxn)/(xn1-xn);
            xn=xn1;
            fxn=fxn1;           
     
%         pause(1)
        input('Press Enter'), figure(1); % skaiciavimas stabdomas iki bus paspaustas Enter klavisas
        
    x=xn;fxn=eval(f);prec=abs(fxn);
    fprintf(1,'iteracija %d  x= %g  prec= %g \n',nit,xn,prec);
end
plot(xn,fxn,'k*');plot(xn,fxn,'ko');
xn
nit



