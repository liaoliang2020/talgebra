function test
	clear; close all; clc;
	row_num = 11;
	col_num = 3;

	X = orth(randn(row_num, col_num) + i * randn(row_num, col_num) );
	Z = randn(row_num, col_num) + i * randn(row_num, col_num);
	
	N = X * mysym(ctranspose(X) * Z);
	T = X * myskew(ctranspose(X)  * Z) + (eye(row_num) - X * ctranspose(X)) * Z;
	
	inner_product = trace(N' * T)




	% assert(isequal(round(N + T, 4), round(Z, 4)));
	% assert(norm(transpose(X) * T + transpose(T) * X, 'fro') < 1e-8)	
	% assert(abs(inner_product) < 1e-6);
end

function result = mysym(A)
	result = (A + transpose(A) ) / 2;	 
end

function result = myskew(A)
	result = (A - transpose(A)) / 2;	
end