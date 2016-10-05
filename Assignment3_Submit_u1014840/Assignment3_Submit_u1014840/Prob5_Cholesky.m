
function [] = PRob5_Cholesky(n)

    A = getMatrixForCholesky(n);
    disp('Randomly generated SPD Matrix-A(nxn)');
    disp(A);

    G = RunCholesky(A,n);
    disp('My Cholesky Result of G:');
    disp(G);

    g= chol(A);
    disp('Matlab Cholesky Result:');
    disp(g');

end


function A = RunCholesky(A,n)
	for k=1:n-1
		A(k,k)		=	sqrt(A(k,k));
		A(k+1:n, k)	=	A(k+1:n,k)/A(k,k);
		A(k+1:n,k+1:n) = A(k+1:n,k+1:n) - (A(k+1:n,k) * A(k+1:n,k)');
		A(k,k+1:n) = 0
	end
	A(n,n)	=	sqrt(A(n,n));
end




function Mat = getMatrixForCholesky(n)
	Mat = rand(n,n) ;
	Mat = Mat*Mat'	;
	Mat = Mat + n*eye(n) ;
end
