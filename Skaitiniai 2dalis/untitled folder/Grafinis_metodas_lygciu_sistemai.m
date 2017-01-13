
%Grafinis metodas lygciu sistemai

function pagrindine
clc,close all

% x=[-20:0.5:20];y=[-20:0.5:20];
x=[-20:0.5:20];y=[-20:0.5:20];
Z=pavirsius(@f,x,y);
figure(1),hold on,grid on,axis([min(x) max(x) min(y) max(y) 0 150]);view([2 1 4]);
xlabel('x'),ylabel('y');
mesh(x,y,Z(:,:,1)','FaceAlpha',0.2);contour(x,y,Z(:,:,1)',[0,0 ],'LineWidth',1.5);
xx=axis;
fill([xx(1),xx(1),xx(2),xx(2)],[xx(3),xx(4),xx(4),xx(3)],'c','FaceAlpha',0.2);



figure(2),hold on,grid on,axis([min(x) max(x) min(y) max(y) 0 100000]);view([-2 5 5]);
xlabel('x'),ylabel('y')
mesh(x,y,Z(:,:,2)','FaceAlpha',0.2);contour(x,y,Z(:,:,2)',[0 0],'LineWidth',1.5)
xx=axis;
fill([xx(1),xx(1),xx(2),xx(2)],[xx(3),xx(4),xx(4),xx(3)],'b','FaceAlpha',0.2);




figure(3),hold on,grid on,axis equal
contour(x,y,Z(:,:,1)',[0 0],'LineWidth',1.5,'LineColor','b')
contour(x,y,Z(:,:,2)',[0 0],'LineWidth',1.5,'LineColor','r')
xlabel('x'),ylabel('y')
legend('(x(1)^2+x(2)^2)/5-2*cos(x(1)/2)-6*cos(x(2))-8','(x(1)/2)^5+(x(2)/2)^4-4')

figure(4),hold on,grid on,axis([min(x) max(x) min(y) max(y) 0 200]);view([-2 3 7]);
xlabel('x'),ylabel('y');
mesh(x,y,Z(:,:,1)','FaceAlpha',0.2);contour(x,y,Z(:,:,1)',[0,0 ],'LineWidth',2.5);
xx=axis;
fill([xx(1),xx(1),xx(2),xx(2)],[xx(3),xx(4),xx(4),xx(3)],'c','FaceAlpha',0.2);
surf(x,y,Z(:,:,2)','FaceAlpha',0.2);contour(x,y,Z(:,:,1)',[0,0 ],'LineWidth',5.5);


return
end

%   Lygciu sistemos funkcija 
    function fff=f(x)
    fff=[(x(1)^2+x(2)^2)/5-2*cos(x(1)/2)-6*cos(x(2))-8;
         (x(1)/2)^5+(x(2)/2)^4-4];
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