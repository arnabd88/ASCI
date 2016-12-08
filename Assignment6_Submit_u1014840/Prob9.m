
format long

func = @(x) 4/(1 + x^2);
%interval
a = 0;
b = 1;

%initialize r
r = 1;

h = (b-a)/r ;

tolerance = 10^(-7);

%step-1
sumValue = 0.0 ;

for i=1:r-1
	sumValue = sumValue + func(a + i*h);
end

%basic poly
Rom(1,1) = 0.5*(func(a) + 2*sumValue + func(b));

curr_appr = 100;
desired = roundn(pi,-8);
j=1;

while ( abs(curr_appr - desired ) > tolerance )
   fn_value = 0;
   
   for k = 1 : 2^(j-1)
        fn_value = fn_value + func( a + (2*k - 1)*(h/(2^j)) );
   end 
   
   Rom(j+1,1) = 0.5*( Rom(j,1) +  (h/2^(j-1)) * fn_value );
   
   for k = 2:j+1
        Rom(j+1,k) = Rom(j+1,k-1) + (Rom(j+1,k-1) - Rom(j,k-1))/(4^(k-1) - 1);
   end
   
   curr_appr = Rom(j+1,j+1);
   j = j + 1;
end

Rom

