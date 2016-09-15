

%% @(x,y)x^2+3*x+10*y

IterNF = @(x) (x^2 + 1)/(x+1) ;
%%IterNF = @(x) x - (exp(x)*(x-1)^2) / (exp(x)*(x^2 - 1))

%%IterNF = @(x) x - (x-1)/(x+1)

x0 = 2 ;
atol = eps ;

xnow = 0 ;
xnext = x0 ;

k=0 ;
while ( abs(xnext - xnow) > atol )
	xnow = xnext ;
	xnext = IterNF(xnow) ;
	k = k+1 ;
	fprintf('Xnext = %10.16f\n', xnext)
end
fprintf('Selected Tolerance for convergence = %10s\n', atol);
fprintf('%10s %10.16f\n', 'Solution to X = ', xnext);
disp(['MaxIteration Reached = ' num2str(k)]);



