function [xnext, iter] = fixedPoint( gunc, x0, atol)
	if (atol <= 0) 
		disp('Incorrect function condition for fixed point')
		xnext = NaN;
		return
	end

	xnext = x0 ;
	xnow = 0;
	iter = 0;
	while( abs(xnext - xnow) > atol )
		xnow = xnext;
		xnext = gunc(xnow);
		iter = iter+1;
		fprintf('Xnext = %20.14f \n', xnext);
	end
end
