function Stiefel_manifold2
	clear; close all; clc;
	disp('Stiefel_manifold2');

	row_num = 11;
	col_num = 3;

	X_prime = orth(randn(row_num, col_num) + i * randn(row_num, col_num) );
	X = [X_prime, 0 * randn(row_num, 1) + 0 * randn(row_num, 1)];


	T_collection = [];
	N_collection = [];
	for index = 1: 9999
		index
		Z = randn(row_num, col_num + 1) + i * randn(row_num, col_num + 1);
		Z_prime = Z(:, 1: col_num);
		


		[T_prime, N_prime] = Stiefel_manifold_sub(X_prime, Z_prime, row_num);



		N = [N_prime, zeros(row_num, 1) ];
		T = [T_prime, Z(:, col_num + 1) ];


		% liao_ext = ctranspose(X) * T + ctranspose(ctranspose(X) * T)
		% pause;


		assert(~isreal(N));
		assert(~isreal(T));
		assert(norm(N + T - Z, 'fro') < 1e-8 );
		assert(dot(to_real(N), to_real(T) ) < 1e-8 );
		

		N_collection = [N_collection, to_real(N) ];
		T_collection = [T_collection, to_real(T) ];
		
	end

	rank(N_collection)
	rank(T_collection)
	
	Nspace = orth(N_collection) * ctranspose(orth(N_collection)); 
	Tspace = orth(T_collection) * ctranspose(orth(T_collection));

	norm(Nspace + Tspace - eye(2 * row_num * (col_num + 1)), 'fro')


end

function [T, N] = Stiefel_manifold_sub(X, Z, row_num)
	N = X * mysym(X' * Z);
	T = X * myskew(X' * Z) + (eye(row_num) - X * X') * Z;
	
	liao = ctranspose(X) * T + ctranspose(ctranspose(X) * T);
	
	assert(norm(liao, 'fro') < 1e-8);
	assert(norm(N + T - Z, 'fro') < 1e-8) ;
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

