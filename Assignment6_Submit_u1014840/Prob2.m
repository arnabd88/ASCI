
format long

%% Function
func = @(x) exp(x) ;

%% target point
x0 = 0;

%% approximate formula derived in first part of question
f3d = @(h) ( func(x0+2*h) - func(x0-2*h) -2*func(x0+h) +2*func(x0-h) )/(2*(h^3)) ;

%%stepList
hList = [1.0e-1,10^(-1.2), 10^(-1.3),10^(-1.4),10^(-1.5), 10^(-1.6),10^(-1.8),1.0e-2,10^(-2.5), 10^(-2.6),10^(-2.8),1.0e-3,10^(-3.2),10^(-3.4),1.0e-4,1.0e-5]%,1.0e-6,1.0e-7,1.0e-8,1.0e-9];
i=1
%%collect the 3rd order derivatives
%for h = hList
for j=1:length(hList)
   f3dCollect(j) = f3d(hList(j)) ;
end

f3dCollect

loglog(hList, f3dCollect, '-s')
grid on

xlabel('h')
ylabel('3rd derivative Approximation')

