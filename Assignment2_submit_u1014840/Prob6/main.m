
format long 

fx = @(x) x + log(x);

disp('===========================')
disp('Given Function: x + ln(x)')
%%-- Part-1 : Bisection Method
bi_a = 0.5 ;
bi_b = 0.6;
atol = 10^-10;

[biSolution, n] = bisection( fx, bi_a, bi_b, fx(0.4), fx(0.7), atol);
disp('Bisection Solution')
fprintf('Final X = %20.14f \n', biSolution);
disp(['Number of iterations = ' num2str(n)])
disp('===========================')

%%-- Part-2 : Linearly Convergent fixed point iteration
disp('===========================')
disp('Fixed point Solution');
disp('Selecting g(x) = -exp(x)');
%gx = @(x) -log(x);

gx = @(x) exp(-x);

x0 = 0.5;
[fpSoln, fpIter] = fixedPoint( gx, x0, atol ) ;
fprintf('Final X = %20.14f \n', fpSoln);
disp(['Number of Iterations =' num2str(fpIter)]);
disp('===========================')

%%-- Part-3 : Newton's Method ---
disp('===========================')
disp('Newtons Method Solution');
disp('For f(x) = x + ln(x)');

fx = @(x) x + log(x);
fxd = @(x) 1 + (1/x);

x0 = 0.5;
[ntSoln, ntIter] = newtonMethod( fx, fxd, x0, atol);
fprintf('Final X = %20.14f \n', ntSoln);
disp(['Number of Iterations =' num2str(ntIter)]);
disp('===========================')

%%-- Part-4 : Secant Method ---
disp('===========================')
disp('Secant Method Solution');
disp('For f(x) = x + ln(x)');

fx = @(x) x + log(x);

x0 = 0.5;
x1 = 0.6;

[sSoln, sIter] = secantMethod(fx, x0, x1, atol);
fprintf('Final X = %20.14f \n', sSoln);
disp(['Number of Iterations =' num2str(sIter)]);
disp('===========================')





