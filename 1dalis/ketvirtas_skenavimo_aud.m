clc,close all

%------------------------   PRADINIAI DUOMENYS  ---------------------------


%f='x.^4+4*x.^3-11*x.^2-30*x'
%ff = @(x)x.^4+4*x.^3-11*x.^2-30*x;
f = 'x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2'
ff = @(x)x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2

%range=[-5.10 ; -4.96 ]
%range=[-1.04 ; -0.90 ]
%range=[-0.62 ; -0.48 ]
range=[2.88 ; 3.02 ]

%range=[-2.00 ; -1.00 ];
%range=[0.00 ; 1.00 ];
%range=[1.00 ; 2.00 ];

 

eps=1e-9;  % parenkame tikslumo reiksme 
method='skenvimo';


% braizomas funkcijos grafikas
npoints=1000; x=range(1): (range(2)-range(1))/(npoints-1) :range(2);  
figure(1); grid on; hold on;
str=[f,'=0;   Metodas : ',method]; title(str);
plot(x,eval(f),'r-');
plot(range,[0 0],'b-');
riba1 = range(1);
riba2 = range(2);
interacijos = 1;
rez = 100;
while rez > eps
    zingsnis = riba1 - riba2;
    zingsnis = zingsnis/4;
    zingsnis = abs(zingsnis);
    i = riba1;
    while (i <= riba2)   
        ats=ff(i);
        ats2=ff(i+zingsnis);
        
            if(abs(ats) < abs(ats2))
               rez = abs(ats);
               saknis = i;

            end
           
           if(abs(ats2) < abs(ats))
               rez = abs(ats2);
               saknis = i+zingsnis;
           end
           
           G =sprintf('interacija %d, tikslumas %d, rezis :  [%d ; %d ]',interacijos,rez,i,i+zingsnis);
                disp(G);
            interacijos = interacijos + 1;
                                            
            plot(i, ats, 'o' , ...
            'MarkerFaceColor', 'r', 'MarkerSize' , 7);h = findobj(gca,'Type','line');h1=h(1);
             plot(i+zingsnis, ats2, 'o' , ...
            'MarkerFaceColor', 'r', 'MarkerSize' , 7);h = findobj(gca,'Type','line');h2=h(1);
      input('Press Enter'), figure(1); % skaiciavimas stabdomas iki bus paspaustas Enter klavisas
        
         delete(h1);delete(h2); 
     
       if (ats > 0 && ats2 < 0) || (ats < 0 && ats2 > 0) || ( ats ==  0 || ats2 == 0)
            riba1 = i;
            riba2 = i + zingsnis;
           break;
       end
        i = i + zingsnis;
    end
      
end

  disp(saknis);