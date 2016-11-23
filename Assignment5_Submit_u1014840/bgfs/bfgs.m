
%% Creating the phi function with the given data

G0 = eye(4) ;
x0 = [-1 ; 3; 3; 0] ;
c  = [5.04 ; -59.4 ; 146.4 ; -96.6] ;
H  = [0.16, -1.2, 2.4, -1.4; -1.2, 12.0, -27.0, 16.8; 2.4, -27.0, 64.8, -42.0; -1.4, 16.8, -42.0, 28.0];

%x = x0;

%phix = c'*x + 0.5*x'*H*x ;
x = sym('x', [1 4]);
f(x) = c'*x' + 0.5*x*H*x' 
g(x) = gradient(f,x) ;

Gk = G0 ;
xk = x0 ;

iter = 10 ;

alphamax = 1;
alphamin = 2^-16;
sigma = 1e-4;
for i=1:20
	pk = -Gk*double(g(xk(1),xk(2),xk(3),xk(4))) 
	%%---- Determine \alpha -------------
	%% rk = -c - H*xk 
	%% alphaK = (rk'*rk)/(pk'*(H*pk))
	alphaK = alphamax;
	xnew = xk + alphaK*pk ;
	phixn = f(xnew(1),xnew(2),xnew(3),xnew(4));
	phix = f(xk(1),xk(2),xk(3),xk(4));

	pgphi = pk'*double(g(xk(1),xk(2),xk(3),xk(4)))
	while(phixn > phix + sigma * alphaK * pgphi)*(alphaK > alphamin)
		mu = -0.5 * pgphi * alphaK / (phixn - phix -alphaK*pgphi)
		if(mu < .1)
			mu = 0.5
		end
		alphaK = mu*alphaK;
		xnew = xk + alphaK*pk;
		phixn = f(xnew(1),xnew(2),xnew(3),xnew(4));
	end
	%%-----------------------------------
	xnew = xk + alphaK*pk ;
	wk = alphaK*pk ;
	yk = double(g(xnew(1),xnew(2),xnew(3),xnew(4))) - double(g(xk(1), xk(2), xk(3), xk(4)));
	Gnew = (1 - (wk*yk')/(yk'*wk))*Gk*( 1 - (yk*wk')/(yk'*wk)) + (wk*wk')/(yk'*wk);
	Gk = Gnew;
	xk = xnew;
	alphamax = alphaK ;

end

