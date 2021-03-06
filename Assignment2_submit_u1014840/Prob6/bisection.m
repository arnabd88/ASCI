
function [p,n] = bisection( func, a, b, fa, fb, atol )
	if ( a >= b) | (fa*fb >= 0) | (atol <= 0)
		disp('Incorrect function condition')
		p = NaN;
		n = NaN;
		return
	end

	%% -- get the max iteration count from atol --%%
	n = ceil(log2(b-a) - log2(2*atol)) ;
	fp = 0 ;
	for i=1:n
		p = (a+b)/2 ;
		fp = feval(func, p);
		if (fa*fp < 0)
			b = p;
			fp = fp;
		else if(fa*fp == 0)
			return
		else
			a = p;
			fa = fp;
		end
		fprintf('p = %20.14f \n', p);
	end
end
