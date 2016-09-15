
function [xnext,iter] = newtonMethod( func, funcD, x0, atol )
	xnext = x0 ;
	xnow = 0;
	iter = 0;
	while( abs(xnext - xnow) > atol )
		xnow = xnext ;
		xnext = xnow - (func(xnow)/funcD(xnow));
		iter = iter+1;
		fprintf('Xnext = %20.14f \n', xnext);
	end
end
