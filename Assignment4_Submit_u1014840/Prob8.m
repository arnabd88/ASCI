
%%--- Given A and b ------------
A = [1,0,1;2,3,5;5,3,-2;3,5,4;-1,6,3];
b = [4;-2;5;-2;1];
%%--- Adding the linearly dependent column -----
A = [A,sum(A,2)];

%%--- List of gamma values ---------
GList = [10^0,10e-3,10e-6,10e-12,0];

index = 1;

ResArray = zeros(4,5);
%EvalResiduals = zeros(5,1);
%xgamma_array_norms = zeros(5,1);


for gamma = GList
    B = A' * A + gamma * eye(4);
    c = A' * b;
    xgam = B\c;
    ResArray(:,index) = xgam;
    EvalResiduals(index)=norm(A*xgam - b);
    xgamma_array_norms(index) = norm(xgam);
    index = index + 1;
end

ResArray
EvalResiduals
xgamma_array_norms
