function Stiefel_manifold
	clear; close all; clc;
	row_num = 11;
	col_num = 3;

	X = orth(randn(row_num, col_num) + i * randn(row_num, col_num) );
	Z = randn(row_num, col_num) + i * randn(row_num, col_num);
	
	N = X * mycsym(transpose(X) * Z);
	T = X * mycskew(transpose(X)  * Z) + (eye(row_num) - X * ctranspose(X)) * Z;
	
	% using the euclidean metric on the tangent space at the point X
	inner_product = trace(T' * N);

	assert(isequal(round(N + T, 4), round(Z, 4)));
	assert(abs(inner_product) < 1e-6);
	%assert(norm(X' * T + T' * X, 'fro') < 1e-8)	

	assert(norm(X' * T + transpose(X' * T), 'fro') < 1e-8);	

	assert(iscskew(X' * T))

	X' * T
end

function result = mysym(A)
	result = (A + transpose(A) ) / 2;	 
end

function result = myskew(A)
	result = (A - transpose(A)) / 2;	
end


function result = mycsym(A)
	result = (A + ctranspose(A) ) / 2;	 
end

function result = mycskew(A)
	result = (A - ctranspose(A)) / 2;	
end


function result = isskew(A)
	if  norm(A + transpose(A), 'fro') < 1e-6
		result = true;
	else 
		result = false;

	end
end

function result = iscskew(A)
	if  norm(A + ctranspose(A), 'fro') < 1e-6
		result = true;
	else 
		result = false;

	end
end