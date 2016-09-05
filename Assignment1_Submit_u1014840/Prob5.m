%% Prob-5: Chapter-2: Exercise - 14 (Advanced Scientific Computing)
%%UID - u1014840
%%Name - Arnab Das


x0 = 1.2 ;
f = sin(x0) ;
fd = cos(x0) ;
fddd = -cos(x0) ;

i = -29:0.5:0 ;
h = 10.^i ;

% absolute error
h2 = h.*h ;
err = abs((fd - (sin(x0 + h) - sin(x0 - h))./(2*h)));

% discretization error
derr = abs(((-fd)/6) * h2) ;

loglog(h, err, '-*');
hold on
loglog(h, derr, 'r-');
xlabel('h','FontSize', 30);
ylabel('Absolute Error', 'FontSize', 30);
legend('Actual Error(err)', 'Discretization Error(derr)', 'Location', 'southeast');


