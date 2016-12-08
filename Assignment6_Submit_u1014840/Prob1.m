
%% Given function
expFunc = @(t) exp(-3*t)
timeStep = 0:0.1:3;

%% Define the basis functions 
basis1 = @(t) (2*t - 3)/3 ;
basis2 = @(t) 0.5*(3*((2*t - 3)/3).^2 - 1) ;
basis3 = @(t) 0.5*(5*((2*t-3)/3).^3 - 2*t + 3) ;
sqbasis1 = @(t) ((2*t - 3)/3).^2 ;
sqbasis2 = @(t) (0.5*(3*((2*t - 3)/3).^2 - 1)).^2 ;
sqbasis3 = @(t) (0.5*(5*((2*t-3)/3).^3 - 2*t + 3)).^2 ;

%%Evaluate the diagonal elements
B_11 = integral(sqbasis1, 0, 3);
B_22 = integral(sqbasis2, 0, 3);
B_33 = integral(sqbasis3, 0 ,3);

%%for the rhs, that is function times the basis
%fbasis1 = @(t) exp(-3*t) .* (2*t - 3)/3 ;
%fbasis2 = @(t) exp(-3*t) .* (0.5*(3*((2*t - 3)/3).^2 - 1)) ;
%fbasis3 = @(t) exp(-3*t) .* (0.5*(5*((2*t-3)/3).^3 - 2*t + 3)) ;
fbasis1 = @(t) expFunc(t) .* basis1(t);
fbasis2 = @(t) expFunc(t) .* basis2(t);
fbasis3 = @(t) expFunc(t) .* basis3(t);

b_0 = integral(expFunc, 0,3);
b_1 = integral(fbasis1, 0,3);
b_2 = integral(fbasis2, 0,3);
b_3 = integral(fbasis3, 0,3);

%%Evaluate the coefficients
c_0 = b_0/3 ;
c_1 = b_1/B_11 ;
c_2 = b_2/B_22 ;
c_3 = b_3/B_33 ;

polyQuad = @(t) c_0 + c_1*basis1(t) + c_2*basis2(t) ;
polyCubic = @(t) c_0 + c_1*basis1(t) + c_2*basis2(t) + c_3*basis3(t);

for i=1:length(timeStep)
	errorQuadTrack(i) = abs(expFunc(timeStep(i)) - polyQuad(timeStep(i)));
	errorCubicTrack(i) = abs(expFunc(timeStep(i)) - polyCubic(timeStep(i))) ;
end

disp('======= L2-norm of Error for Quadratic ===========')
norm(errorQuadTrack)
disp('======= L2-norm of Error for Cubic ===========')
norm(errorCubicTrack)

subplot(2,1,1);
plot(timeStep, expFunc(timeStep), timeStep, polyQuad(timeStep), timeStep, polyCubic(timeStep));
xlabel('time')
ylabel('Values')
legend('f','Quad','Cubic')
subplot(2,1,2);
plot(timeStep, errorQuadTrack, timeStep, errorCubicTrack);
xlabel('time')
ylabel('Values')
legend('ErrorQuad','ErrorCubic')
	
