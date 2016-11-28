
% Individual Dimensions
syms x1
syms x2
syms x3
syms x4

% Column Vector x
x  = [x1,x2,x3,x4]'

% Initial guess [-1,3,3,0]';
x0 = [-1,3,3,0]'
k  = 0
convergence = 1e-10;

% c : 1 x 4
c = [5.04, - 59.40, 146.40, -96.60]'

% H : 4 x 4
H = [ 0.16,  -1.20,   2.40,  -1.40 ;...
     -1.20,  12.00, -27.00,  16.80 ;...
      2.40, -27.00,  64.80, -42.00 ;...
     -1.40,  16.80, -42.00, 28.00 ]

% Function
f = c'*x + (1/2)*x'*H*x
 
% Differentiation

% syms x;
% f(x)  = sin(x^2);
% df    = diff(f,x);
% `--> df(x) = 2*x*cos(x^2)

% Differentiate per dimension
% gradient of f
f1 = diff(f,x1);
f2 = diff(f,x2);
f3 = diff(f,x3);
f4 = diff(f,x4);

% Vector of functions
fv = [f1,f2,f3,f4];

% Calculate hessian
h    = jacobian(fv,x')

% Init loop variables
k    = 0;
xk1 = x0
d    = 1

% Start Newtons Method
while d > convergence
    xk   = xk1;
    
    % fun    = x^2;
    % test_f = inline(fun)
    % feval(test_f,2)
    
    % evaluate the gradient of f at xk
    fk   = [feval(inline(f1),xk(1),xk(2),xk(3),xk(4)),...
            feval(inline(f2),xk(1),xk(2),xk(3),xk(4)),...
            feval(inline(f3),xk(1),xk(2),xk(3),xk(4)),...
            feval(inline(f4),xk(1),xk(2),xk(3),xk(4))]
    
    % solve for pk    
    pk   = -1 * (double(h)) \ fk'    
    
    % find x_{k + 1}
    xk1 = xk + pk 
    
    % calculate convergence criterion
    d    = norm(xk - xk1)
    
    % increment counter
    k = k + 1;
    
end % End Newtons Method

xk1
d
k

% Re-Init loop variables
k    = 0;
xk1 = x0;
d    = 1;

gk   = eye(4);

% Start BFGS
while d > convergence && k < 100
    
    xk = xk1;
    
    % evaluate the gradient of f at xk
    fk   = [feval(inline(f1),xk(1),xk(2),xk(3),xk(4)),...
            feval(inline(f2),xk(1),xk(2),xk(3),xk(4)),...
            feval(inline(f3),xk(1),xk(2),xk(3),xk(4)),...
            feval(inline(f4),xk(1),xk(2),xk(3),xk(4))];
    %     
    pk = -1 * gk * fk';    
    
    % find a suitable step size ak
    ak = 0.001;
    
    %
    xk1 = xk + (ak * pk);
    
    %
    wk = ak * pk;
    
    % evaluate the gradient of f at xk1
    fk1   = [feval(inline(f1),xk1(1),xk1(2),xk1(3),xk1(4)),...
            feval(inline(f2),xk1(1),xk1(2),xk1(3),xk1(4)),...
            feval(inline(f3),xk1(1),xk1(2),xk1(3),xk1(4)),...
            feval(inline(f4),xk1(1),xk1(2),xk1(3),xk1(4))];
    
    %
    yk = fk1' - fk';
    
    I   = eye(4);
    
    s  = yk' * wk;
    
    gk1 = (I - (wk * yk')/s)*...
           gk *...
          (I - (yk*wk')/s) + ...
          ( wk * wk' )/s ;
      
    % calculate convergence criterion
    d    = norm(xk - xk1);
    
     % increment counter
    k = k + 1
    
end % BFGS

xk1
k
d
