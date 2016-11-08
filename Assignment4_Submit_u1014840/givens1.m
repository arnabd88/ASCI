%% make a A=n+1 x n matrix

function [Q,A_temp] = givens1(A, sz)

k=sz;
Q = eye(k+1);
A_temp = A;
for i=2:k+1
	j = i-1;
	a = A_temp(i-1,j);
	b = A_temp(i,j);
	r = sqrt(a^2 + b^2);
	c = a/r ;
	s = -b/r;
	Gi = eye(k+1);
	Gi(i,i) = c;
	Gi(j,j) = c;
	Gi(i,j) = s;
	Gi(j,i) = -s;
	A_temp = Gi*A_temp;
	Q = Q*Gi'
end

