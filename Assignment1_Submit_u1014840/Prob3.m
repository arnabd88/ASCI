
%%Prob-3: Chapter-2: Exercise - 2 (Advanced Scientific Computing)
%%UID - u1014840
%%Name - Arnab Das

x0 = 1.2 ;
f0 = sin(x0);
fp = cos(x0);
i = -20:1:0 ;
h = 10.^i ; 
f1 = sin(x0 + h) - f0 ;
f2 = 2*cos(x0 + h/2) .* sin(h/2) ;

errf1 = abs(fp - f1./h) ;
errf2 = abs(fp - f2./h) ;
derr = abs(f0/2 * h) ;

loglog(h, errf1, 'b-*');
hold on
loglog(h, errf2, 'black-+');
hold on
loglog(h, derr, 'r-');
xlabel('h', 'FontSize',30);
ylabel('Absolute Error', 'FontSize', 30);
legend('errf1', 'errf2', 'derr', 'Location', 'southeast')

for j=1:length(h)
	fprintf('%8s   %20s\n', num2str(h(j)), num2str(errf2(j))) ;
end
