function Stiefel_manifold
	clear; close all; clc;
	row_num = 11;
	col_num = 3;

	X = orth(randn(row_num, col_num) + 0 * randn(row_num, col_num) );
	Z = randn(row_num, col_num) + 0 * randn(row_num, col_num);
	
	N = X * mysym(ctranspose(X) * Z);
	T = X * myskew(ctranspose(X)  * Z) + (eye(row_num) - X * ctranspose(X)) * Z;
	% using the Euclidenan metric for the inner product 
	% inner_product = trace(T' * N)

	% using the canonical metric on the tangent space at the point X
	inner_product = trace(T' *  (eye(row_num) - 0.5 * X * X') * N);

	assert(isequal(round(N + T, 4), round(Z, 4)));
	assert(norm(X' * T + T' * X, 'fro') < 1e-8)	
	assert(abs(inner_product) < 1e-6);
end

function result = mysym(A)
	result = (A + ctranspose(A) ) / 2;	 
end

function result = myskew(A)
	result = (A - ctranspose(A)) / 2;	
end