
function [] = Prob10


% Data Set
PX = [0.10, 0.15, 0.20, 0.30, 0.35, 0.50, 0.75];
PY = [3.00, 2.00, 1.20, 2.10, 2.00, 2.50, 2.50];

% Construct Interpolatants
van = vander(PX);
[t1] = van\PY' ;
[t2] = spline(PX,PY);
[t3] = interpolant(0.1,PX,PY);
[t4] = interpolant(0.01,PX,PY);
[t5] = interpolant(0.001,PX,PY);
[t6] = interpolant(0,PX,PY);

% Plot 
x = [0.05: 0.01: 0.8];
y1 = polyval(t1,x);
y2 = ppval(t2,x); 
y3 = t3(x);
y4 = t4(x);
y5 = t5(x);
y6 = t6(x);
%axis([0,10,-50,50])
%xlim([0 1.1])
%% plot(x,y1,x,y2,x,y3,x,y4,x,y5);
%% 
%% 
%% xlabel('x');
%% ylabel('y');
%% hold on;
%% legend('polyfit','spline','interpolant 0.1','interpolant 0.01','interpolant 0.001', 'Location', 'southeast');


subplot(3,2,1);
plot(x,y1);
title(['Poly Interpolant']), xlabel('x'), ylabel('y');

subplot(3,2,2);
plot(x,y2);
title(['Cubic Spline']), xlabel('x'), ylabel('y');
subplot(3,2,3);
plot(x,y3);
title(['Custom: epsilon = 0.1']), xlabel('x'), ylabel('y');
subplot(3,2,4);
plot(x,y4);
title(['Custom: epsilon = 0.01']), xlabel('x'), ylabel('y');
subplot(3,2,5);
plot(x,y5);
title(['Custom: epsilon = 0.001']), xlabel('x'), ylabel('y');
subplot(3,2,6);
plot(x,y6);
title(['Custom: epsilon = 0']), xlabel('x'), ylabel('y');

%line([0.05,0.05],[-5,15]); hold on;
%line([0.01,0.01],[-5,15]); hold on;
%line([0.8,0.8],[-5,15]);

end

function [p] = interpolant(epsilon,X,Y)

  A = ones(8,8);
  
  phi0 = @(x) 1 ;
  phi1 = @(x) sqrt((x - X(1)).^2 + epsilon^2) - epsilon ;
  phi2 = @(x) sqrt((x - X(2)).^2 + epsilon^2) - epsilon ;
  phi3 = @(x) sqrt((x - X(3)).^2 + epsilon^2) - epsilon ;
  phi4 = @(x) sqrt((x - X(4)).^2 + epsilon^2) - epsilon ;
  phi5 = @(x) sqrt((x - X(5)).^2 + epsilon^2) - epsilon ;
  phi6 = @(x) sqrt((x - X(6)).^2 + epsilon^2) - epsilon ;
  phi7 = @(x) sqrt((x - X(7)).^2 + epsilon^2) - epsilon ;
  
  for i = 2:8
    A(i,2) = phi1(X(i-1));
    A(i,3) = phi2(X(i-1));
    A(i,4) = phi3(X(i-1));
    A(i,5) = phi4(X(i-1));
    A(i,6) = phi5(X(i-1));
    A(i,7) = phi6(X(i-1));
    A(i,8) = phi7(X(i-1));
  end
  
%  y = [0,Y]'; 
%  C = A\y;
  Coeff = A\[0,Y]';
  p = @(x) Coeff(1)*phi0(x) + Coeff(2)*phi1(x) + Coeff(3)*phi2(x) + Coeff(4)*phi3(x) + Coeff(5)*phi4(x) + Coeff(6)*phi5(x) + Coeff(7)*phi6(x) + Coeff(8)*phi7(x); 

end
