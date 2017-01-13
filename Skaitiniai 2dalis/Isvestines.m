% syms x y
% diff((x^2+y^2)/5-2*cos(x/2)-6*cos(y)-8, x)
% diff((x^2+y^2)/5-2*cos(x/2)-6*cos(y)-8, y)
% 
% diff((x/2)^5+(y/2)^4-4, x)
% diff((x/2)^5+(y/2)^4-4, y)


function fsolveDemo

%  x0=[-5;6.3];
% x0=[-4.5;-5];
% x0=[-3.5;-3.2];


% x0=[-5;-6.3];
% x0=[-4.5;-5];
% x0=[-3.5;-3.2];                      % Make a starting guess at the solution
x0=[1;1;1;1]
options=optimset('Display','iter');   % Option to display output
[x,fval] = fsolve(@myfun,x0,options)         % Call solver
end

function F = myfun(x)
% Rewrite the equation in the form F(x) = 0
% F=[(x(1)^2+x(2)^2)/5-2*cos(x(1)/2)-6*cos(x(2))-8;
%          (x(1)/2)^5+(x(2)/2)^4-4];
 F=[3*x(1)+5*x(2)+3*x(3)+x(4)-8;
 x(1)^2+2*x(2)*x(4)-5;
 -3*x(2)^2-3*x(1)*x(2)+2*x(4)^3+16;
 5*x(1)-15*x(2)+3*x(4)+22];
end

