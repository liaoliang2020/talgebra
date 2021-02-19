function complex_Stiefel_manifold
	clear; close all; clc;

	row_num = 16;
	col_num = 4;


	X = orth(randn(row_num, col_num) + i * randn(row_num, col_num) );
	Z = randn(row_num, col_num) + i * randn(row_num, col_num);

	N = X * mysym(X' * Z);
	T = X * myskew(X' * Z) + (eye(row_num) - X * X') * Z;

	assert(norm(N + T - Z, 'fro') < 1e-8);	

	inner_product = trace(N' * T)
	inner_product2 = dot(to_real(N), to_real(T)  )



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