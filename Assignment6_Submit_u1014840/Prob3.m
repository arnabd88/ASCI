
format long

func = @(x) exp(x);

hList = [1.0e-1,1.0e-2,1.0e-3,1.0e-4,1.0e-5,1.0e-6,1.0e-7]
x0 = 0;

for i=1:length(hList)
	h = hList(i);
	h0 = h/2;
	h1 = h ;
	xneg1 = x0 - h0;
	x1 = x0 + h1;

    firstMethod(i) = (  ( func(x1) - func(x0 ) ) /h1 ...
                      - ( func(x0) - func(xneg1) ) /h0  ) ...
                      / (  (h0  + h1) /2) ;


	%firstMethod(i) = ((func(x1) - func(x0))/h1 -(func(x1) - func(x0)) /h0)/((h0+h1)/2)

	secondMethod(i) = 2*((func(x1) - func(x0))/(x1-x0) -(func(x0) - func(xneg1)) /(x0 - xneg1))/(x1 - xneg1) 
	diff(i) = abs(firstMethod(i) - secondMethod(i)) ;
	err(i) = 1 - abs(firstMethod(i)) ;
end


disp('====== HLIST =======')
hList
disp('====== Using First Method =======')
firstMethod
disp('====== Using Second Method =======')
secondMethod
disp('====== Difference between first and second method =======')
diff
disp('====== Deviation from correct value =======')
err
