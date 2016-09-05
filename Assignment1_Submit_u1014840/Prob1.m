
%%Prob-1: Chapter-1: Exercise - 1 (Advanced Scientific Computing
%%UID - u1014840
%%Name - Arnab Das

x0 = 0.5 ;
f0 = exp(-2*x0);
fp = -2*exp(-2*x0);
i  = -20:0.5:0 ;
h  = 10.^i ;

err   = abs(fp - (exp(-2*(x0+h)) - f0)./h); %Actual Error
d_err = (4*f0)/2 * h ;                      % Approximated discretization error
loglog(h, err, '-*') ;
hold on
loglog(h, d_err, 'r-') ;
xlabel('h');
ylabel('Absolute Error');
legend('Actual Error(err)', 'Discretization Error(derr)','location', 'southeast');

fileID = fopen('Prob1Log.txt','w');

for j=1:length(h)
	fprintf(fileID,'%8s  %20s\n', num2str(h(j)), num2str(err(j)));
end
fclose(fileID);
