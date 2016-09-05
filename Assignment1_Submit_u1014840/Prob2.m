
%%Prob-2: Chapter-1: Exercise - 4 (Advanced Scientific Computing)
%%UID - u1014840
%%Name - Arnab Das

c = [0:100:1000];      % c varied from 0 to 1000
%c = 1000 ;
x = [-0.01:0.002:0.01] % xsamples near 0 values from -0.01 to +0.01


for ci=1:length(c)
	for xi=1:length(x)
		func_array(ci,xi) = g_c_x(c(ci),x(xi));
	end
	%%Plots f(x) for various values of c
	plot(x,func_array(ci,:));
	hold on
end
ylabel('f(x) = tanh(cx)');
xlabel('x');
hold off

%for ci=1:length(c)
%	for xi=1:length(x)
%		func_diff_array(ci,xi) = g_c_x_d(c(ci), x(xi));
%	end
%	plot(x, func_diff_array(ci, :));
%	hold on
%end
%ylabel(' Plot of first derivative of f(x) = tanh(cx)');
%xlabel('x');

func_array;
