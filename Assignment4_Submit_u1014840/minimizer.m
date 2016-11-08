

function [z, Q, H] = minimizer(rho, H, sz)
	[Q,R] = givens1(H, sz);
	e1 = [1 zeros(1,sz-1)]
	z = inv(R(1:sz, 1:sz))*Q(1:sz, 1:sz)*e1'*rho
	x = R(1:sz,1:sz) \ Q(1:sz, 1:sz)*e1'*rho
end

