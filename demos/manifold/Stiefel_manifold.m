function Stiefel_manifold
	row_num = 11;
	col_num = 3;

	X = orth(randn(row_num, col_num) + i * randn(row_num, col_num) );
	Z = randn(row_num, col_num) + i * randn(row_num, col_num);


	N = X * mysym(ctranspose(X) * Z);
	T = X * myskew(ctranspose(X)  * Z) + (eye(row_num) - X * ctranspose(X)) * Z;
	inner_product = trace(T' * N);
	
	assert(isequal(round(N + T, 4), round(Z, 4)));
	assert(norm(X' * T + T' * X, 'fro') < 1e-8)	
	assert(abs(inner_product) < 1e-6);
	
	return;
end

function result = mysym(A)
	result = (A + ctranspose(A) ) / 2;	 
end

function result = myskew(A)
	result = (A - ctranspose(A)) / 2;	
end