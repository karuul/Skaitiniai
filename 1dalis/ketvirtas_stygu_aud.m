
clc,close all

%------------------------   PRADINIAI DUOMENYS  ---------------------------


f='x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2'

range=[-5.05 ; -4.90 ];
%range=[-2.10 ; -1.20 ];
%range=[-0.30 ; 0.60 ];
%range=[2.40 ; 3.30 ];
 
%f = '(2*x.*cos(x)) - (x/2 + 0.5).^3'
%range=[-2.00 ; -1.00 ];
%range=[0.00 ; 1.00 ];
%range=[1.00 ; 2.00 ];

eps=1e-9;  % parenkame tikslumo reiksme 
nitmax=100;% parenkame didziausia leistina iteraciju skaiciu
method='chords';


% braizomas funkcijos grafikas
npoints=1000; x=range(1): (range(2)-range(1))/(npoints-1) :range(2);  
figure(1); grid on; hold on;
str=[f,'=0;   Method of ',method]; title(str);
plot(x,eval(f),'r-');
plot(range,[0 0],'b-');

%------------------------   SPRENDIMAS  -----------------------------------

xn=range(1);xn1=range(2);prec=1;
nit=0;
while prec > eps
    nit=nit+1;
    if nit > nitmax, fprintf('Virsytas leistinas iteraciju skaicius');break;end
    plot(xn,0,'mp');h = findobj(gca,'Type','line');h1=h(1); % paskutinio grafinio objekto valdiklis irasomas handle masyvo priekyje
    plot(xn1,0,'cp');h = findobj(gca,'Type','line');h2=h(1);
    
            x=xn;fxn=eval(f);x=xn1;fxn1=eval(f);
            k=abs(fxn/fxn1);xmid=(xn+k*xn1)/(1+k);
            plot(xmid,0,'gs');plot([xn,xn1],[fxn,fxn1],'g-');h = findobj(gca,'Type','line');h3=h(1:2);
        
    x=xmid;fxmid=eval(f);
    
    % jeigu pradzioje tikriname kairi taska
    x=xn;fxn=eval(f);
    if sign(fxmid) == sign(fxn), xn=xmid;
    else, xn1=xmid;
    end
    
    input('Press Enter'), figure(1); % skaiciavimas stabdomas iki bus paspaustas Enter klavisas
    delete(h1);delete(h2);delete(h3);
    
    prec=abs(fxmid); 
    fprintf(1,'iteracija %d    tikslumas= %g \n',nit,prec);
end
plot(xmid,0,'k*');plot(xmid,0,'ko');
fprintf(1,'\n tikslumas pasiektas, saknis xmid=%g\n\n',xmid);


% ................................................................................
disp('.... Patikriname saknies reiksme, naudodami MATLAB funkcija fsolve: ....')
