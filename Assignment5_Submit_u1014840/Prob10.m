function [] = q10

% Data Set
X = [0.10, 0.15, 0.20, 0.30, 0.35, 0.50, 0.75];
Y = [3.00, 2.00, 1.20, 2.10, 2.00, 2.50, 2.50];

% Construct Interpolatants
[p1] = polyfit(X,Y,6);
[p2] = spline(X,Y);
[p3] = custom(0.1);
[p4] = custom(0.01);
[p5] = custom(0.001);

% Plot 
x = [0: 0.01: 0.9];
y1 = polyval(p1,x);
y2 = ppval(p2,x); 
y3 = p3(x);
y4 = p4(x);
y5 = p5(x);
plot(x,y1,x,y2,x,y3,x,y4,x,y5);

end

function [p] = custom(e)

  A = ones(8,8);
  X = [0.10, 0.15, 0.20, 0.30, 0.35, 0.50, 0.75];
  Y = [3.00, 2.00, 1.20, 2.10, 2.00, 2.50, 2.50];
  
  phi0 = @(x) 1 ;
  phi1 = @(x) sqrt((x - X(1)).^2 + e^2) - e ;
  phi2 = @(x) sqrt((x - X(2)).^2 + e^2) - e ;
  phi3 = @(x) sqrt((x - X(3)).^2 + e^2) - e ;
  phi4 = @(x) sqrt((x - X(4)).^2 + e^2) - e ;
  phi5 = @(x) sqrt((x - X(5)).^2 + e^2) - e ;
  phi6 = @(x) sqrt((x - X(6)).^2 + e^2) - e ;
  phi7 = @(x) sqrt((x - X(7)).^2 + e^2) - e ;
  
  for i = 2:8
    A(i,2) = phi1(X(i-1));
    A(i,3) = phi2(X(i-1));
    A(i,4) = phi3(X(i-1));
    A(i,5) = phi4(X(i-1));
    A(i,6) = phi5(X(i-1));
    A(i,7) = phi6(X(i-1));
    A(i,8) = phi7(X(i-1));
  end
  
  y = [0,Y]'; 
  C = A\y;
  p = @(x) C(1)*phi0(x) + C(2)*phi1(x) + C(3)*phi2(x) + C(4)*phi3(x) + C(5)*phi4(x) + C(6)*phi5(x) + C(7)*phi6(x) + C(8)*phi7(x); 

end
