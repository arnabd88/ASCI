
%%Prob-4: Chapter-2: Exercise-10 (Advanced Scientific Computing)
%%UID - u1014840
%%Name - Arnab Das

x0 = 3;
i = -20:1:0 ;
d = 10.^i ;

f1 = cos(x0 + d) - cos(x0) ;
f2 = -2*sin(x0 + d/2) .* sin(d/2) ;

g1 = abs(f1./d + sin(x0)) ;
g2 = abs(f2./d + sin(x0)) ;

loglog(d, g1, 'b-*');
hold on
loglog(d, g2, 'r-');

xlabel('d', 'FontSize',30);
ylabel('Error ', 'FontSize' , 30);

legend('g1', 'g2', 'Location', 'southeast')

delta = 10^-11 ;
g1_x_3 = abs((cos(x0 + delta) - cos(x0))/delta + sin(x0)) 
g2_x_3 = abs((-2*sin(x0 + delta/2)*sin(delta/2))/delta + sin(x0))  


disp('================= For g1 ======================');
fprintf('%8s %20s\n', '(h)' , '(g1)');
for j=1:length(d)
	fprintf('%8s %20s\n', num2str(d(j)), num2str(g1(j)));
end

disp('================= For g2 ======================');
fprintf('%8s %20s\n', '(h)' , '(g2)');
for j=1:length(d)
	fprintf('%8s %20s\n', num2str(d(j)), num2str(g2(j)));
end
