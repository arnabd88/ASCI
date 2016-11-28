
% Individual Dimensions
syms x1
syms x2
syms x3
syms x4

x  = [x1,x2,x3,x4]'

x0 = [-1,3,3,0]'
iter_k  = 0
epsilon = 1e-10;


% H : 4 x 4
H = [ 0.16,  -1.20,   2.40,  -1.40 ;  -1.20,  12.00, -27.00,  16.80 ; 2.40, -27.00,  64.80, -42.00 ; -1.40,  16.80, -42.00, 28.00 ]

% Given c : 
c = [5.04, - 59.40, 146.40, -96.60]'

% Function
phix = c'*x + (1/2)*x'*H*x
 
% Get the gradient
phi1 = diff(phix,x1);
phi2 = diff(phix,x2);
phi3 = diff(phix,x3);
phi4 = diff(phix,x4);

% Form the vector of functions, basically gradient of phix
phiv = [phi1,phi2,phi3,phi4];

% Get the Jacobian of the gradient
hess    = jacobian(phiv,x')

% Init loop variables
iter_k    = 0;
xk1 = x0
delta    = 1

% Start Newtons Method
while delta > epsilon
    xk   = xk1;
    
    % evaluate the gradient of phix at xk
    phik   = [feval(inline(phi1),xk(1),xk(2),xk(3),xk(4)),feval(inline(phi2),xk(1),xk(2),xk(3),xk(4)),feval(inline(phi3),xk(1),xk(2),xk(3),xk(4)),feval(inline(phi4),xk(1),xk(2),xk(3),xk(4))]
    
    % solve for pk    
    pk   = -1 * (double(hess)) \ phik'    
    
    % find x_{k + 1}
    xk1 = xk + pk 
    
    % calculate epsilon criterion
    delta    = norm(xk - xk1)
    
    % increment counter
    iter_k = iter_k + 1;
    
end % End Newtons Method

x_newton = xk1;
newton_iter_k = iter_k ;

% Re-Init loop variables
iter_k    = 0;
xk1 = x0;
delta    = 1;

gk   = eye(4);
alphamax = 1;
alphamin = 2^-10;
sigma = 1e-4;

% Start BFGS
while delta > epsilon && iter_k < 100
    
    xk = xk1;
    
    % evaluate the gradient of phix at xk
    phik   = [feval(inline(phi1),xk(1),xk(2),xk(3),xk(4)),feval(inline(phi2),xk(1),xk(2),xk(3),xk(4)),feval(inline(phi3),xk(1),xk(2),xk(3),xk(4)),feval(inline(phi4),xk(1),xk(2),xk(3),xk(4))];
    %     
    pk = -1 * gk * phik';    
    
    % find a suitable step size ak
    ak = 0.01;

	%%---- Determine \alpha -------------
	 rk = -c - H*xk 
	%% alphaK = (rk'*rk)/(pk'*(H*pk))
	ak = alphamax;
	xk1 = xk + ak*pk ;
	phixn = feval(inline(phix), xk1(1), xk1(2), xk1(3), xk1(4));
	phixk = feval(inline(phix), xk(1), xk(2), xk(3), xk(4));

%	pgphi = pk'*double(gk(xk(1),xk(2),xk(3),xk(4)))
	pgphi = pk'*phik'
	while(phixn > phixk + sigma * ak * pgphi) && (ak > alphamin)
		mu = -0.5 * pgphi * ak / (phixn - phixk -ak*pgphi) 
		if(mu < .1)
			mu = 0.5
		end
		ak = mu*ak;
		xk1 = xk + ak*pk;
		phixn = feval(inline(phix), xk1(1), xk1(2), xk1(3), xk1(4));
	end
	%%-----------------------------------
	
    
    %
    xk1 = xk + (ak * pk);
    
    %
    wk = ak * pk;
    
    % evaluate the gradient of phix at xk1
    phik1   = [feval(inline(phi1),xk1(1),xk1(2),xk1(3),xk1(4)), feval(inline(phi2),xk1(1),xk1(2),xk1(3),xk1(4)),feval(inline(phi3),xk1(1),xk1(2),xk1(3),xk1(4)),feval(inline(phi4),xk1(1),xk1(2),xk1(3),xk1(4))];
    
    %
    yk = phik1' - phik';
    
    I   = eye(4);
    
    s  = yk' * wk;
    
    gk1 = (I - (wk * yk')/s)* gk * (I - (yk*wk')/s) +  ( wk * wk' )/s ;
      
    % calculate epsilon criterion
    delta    = norm(xk - xk1)
    
     % increment counter
    iter_k = iter_k + 1

	gk = gk1;
    
end % BFGS


x_bfgs = xk1;
bfgs_iter_k = iter_k ;

%%--- final ---
x_newton
x_bfgs
newton_iter_k
bfgs_iter_k
