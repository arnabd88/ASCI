

func = @(x) sin(x)
klist = 0:0.5:8
x0 = 1.2;

for i=1:length(klist)
	hlist(i) = 10^(-klist(i)) ;
end

func2deriv = @(x) -sin(x);

for i=1:length(hlist)
	h = hlist(i);
	xneg1 = x0-h;
	x1 = x0+h;
	firstMethod(i)  = (func(x1) - 2*func(x0) +func(xneg1))/h^2;
	secondMethod(i) = ((func(x1) - func(x0))/h - (func(x0) - func(xneg1))/h)/h;

	firstDiff(i) = abs(func2deriv(x0) - firstMethod(i));
	secondDiff(i) = abs(func2deriv(x0) - secondMethod(i));
	methDiff(i) = abs(firstMethod(i) - secondMethod(i));
end

firstDiff
secondDiff
methDiff

subplot(2,2,1)
loglog(hlist,firstDiff, '-s')
xlabel('h')
ylabel('Error with first method')
subplot(2,2,2)
loglog( hlist,secondDiff,'-s')
xlabel('h')
ylabel('Error with second method')
subplot(2,2,3)
loglog(hlist,methDiff,'-s')
xlabel('h')
ylabel('Error between first and second method')
