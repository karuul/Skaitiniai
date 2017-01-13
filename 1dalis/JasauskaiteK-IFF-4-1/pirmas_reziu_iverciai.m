
function Daugianario_saknu_reziu_iverciai
clc, close all
syms f x
f=x.^4+7/2*x.^3-23/2*x.^2-43/2*x-15/2
fneig=subs(f,x,-x)   % daugianario skleistine pakeitus x-> -x

[CF1,orders]=coeffs(f,x) % daugianario f koeficientai ir juos atitinkantys x laipsniai

auksciausias_x_laipsnis=char(orders(1));
nnn=strfind(auksciausias_x_laipsnis,'^');
n=str2num(auksciausias_x_laipsnis(nnn+1:end))  % auksciausias x laipsnio rodiklis daugianaryje (daugianario eile)

[CF1_neig,orders_neig]=coeffs(fneig,x) % daugianario fneig koeficientai ir juos atitinkantys x laipsniai

% suformuojama visu x laipsniu eile:
for i=1:n+1, orders_full(i)=x^(n-i+1); end

% koeficientu eile papildoma nuliniais nariais:
for i=1:n+1
    j=find(orders == orders_full(i));
    if j>0, CF(i)=CF1(j);
        CF_neig(i)=CF1_neig(j);
    else,   CF(i)=0;
        CF_neig(i)=0;
    end
end

% koeficientas prie auksciausio x laipsnio turi buti teigiamas:
CF=CF/CF(1);  % f(x) koeficientai
CF_neig=CF_neig/CF_neig(1);  % f(-x) koeficientai

% Saknu intervalo iverciai:

% ------------- Grubus ivertis:
CF_value=eval(CF)  % f(x) koeficientu simboliai paverciami skaiciais
R=max(abs(CF_value(2:end)))/CF_value(1)+1  % taikoma grubaus ivercio formule


% grafinis funkcijos, saknu ir grubaus ivercio intervalo pavaizdavimas:
t=-R:R/500:R;
figure(1);grid on;hold on
plot(t,fnk(CF_value,t),'g-')
plot([-R,R],[0 0],'r*')

% ------------ Tikslesnis ivertis:
% teigiamoms saknims:

neig_ind=find(CF_value(2:end) < 0)
if ~isempty(neig_ind)
    B=max(abs(CF_value(neig_ind+1)))
    k=neig_ind(1)
    Rteig=1+(B/CF_value(1))^(1/k)
else
    Rteig=0
end
plot(min(R,Rteig),0,'bp') % pavaizduojamas teigiamu saknu virsutines ribos ivertis

% neigiamoms saknims:
CF_value_neig=eval(CF_neig)  % f(-x) koeficientu simboliai paverciami skaiciais
neig_ind1=find(CF_value_neig(2:end) < 0)
if ~isempty(neig_ind1)
    B=max(abs(CF_value_neig(neig_ind1+1)))
    k=neig_ind1(1)
    Rneig=1+(B/CF_value_neig(1))^(1/k)
else
    Rneig=0
end

plot(-min(R,Rneig),0,'bp')

legend('kreive f(x)','grubus saknu intervalo ivertis','tikslesnis saknu intervalo ivertis');
title([char(f),'=0'])
% vaizduoja tikslesniam iveryje
figure(2)
aa=-Rneig-1:0.01:Rteig+1;
plot(aa, fnk(CF_value, aa), 'g-');
xlim([-Rneig-2,Rteig+2])
ylim([-0.1*10^5,0.3*10^5])
grid on;
hold on
legend('kreive f(x)','tikslesnis saknu intervalo ivertis');
title([char(f),'=0'])
% funkcija g
figure(3)
g = @(x)1.9*x.*sin(x)-(x/1.5-3).^2
x =  -10:0.1:10;
s(1)=fzero('1.9*x.*sin(x)-(x/1.5-3).^2',1)

plot(x, g(x), 'g-')
ylim([-120,30])
grid on;
legend('kreive g(x)');
title(['1.9*x.*sin(x)-(x/1.5-3).^2=0'])

end

function p=fnk(CF,x)
% Apskaiciuoja daugianario reiksmes, kai argumentas yra x
% Kai x yra reiksmiu vektorius, p taip pat yra atitinkamu funkcijos reiksmiu vektorius
p=0; n=length(CF)-1;
for i=1:length(CF),  p=p+CF(i)*x.^(n-i+1);  end  % veiksmas < .^ > reiskia, kad laipsniu keliami visi vektoriaus x elementai
return
end