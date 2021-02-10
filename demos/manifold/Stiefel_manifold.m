function Stiefel_manifold(X, Z)
	clear; close all; clc;
	disp('Stiefel_manifold');

	row_num = 11;
	col_num = 3;

	X = orth(randn(row_num, col_num) + i * randn(row_num, col_num) );
	
	T_collection = [];
	N_collection = [];
	for index = 1: 9999
		index
		Z = randn(row_num, col_num) + i * randn(row_num, col_num);
		[T, N] = Stiefel_manifold_sub(X, Z, row_num);

		assert(~isreal(T));
		assert(~isreal(N));

		% T_collection = [T_collection, T(:)];
		% N_collection = [N_collection, N(:)];
	
		T_collection = [T_collection, to_real(T) ];
		N_collection = [N_collection, to_real(N) ];
		
	end

	rank(T_collection)
	rank(N_collection)


end

function [T, N] = Stiefel_manifold_sub(X, Z, row_num)
	N = X * mysym(X' * Z);
	T = X * myskew(X' * Z) + (eye(row_num) - X * X') * Z;

	assert(norm(N + T - Z, 'fro') < 1e-8) ;
	liao = X' * T + ctranspose(X' * T);
	assert(norm(liao, 'fro') < 1e-8);
	assert(dot(to_real(T), to_real(N) ) < 1e-8);

end


function result = mysym(A)
	result = (A + ctranspose(A) ) / 2;	 
end

function result = myskew(A)
	result = (A - ctranspose(A)) / 2;	
end

function result = to_real(A) 
	A1 = real(A);
	A2 = imag(A);

	result = permute([A1(:), A2(:)], [2, 1]);
	result = result(:);
end

function result = to_complex(A) 
	A = A(:);
	A = reshape(A, 2, []); 
	result = A(1, :) + i * A(2, :);
	result = result(:); 
end 

