function STM
	clear; close all; clc;

	row_num = 5;
	col_num = 2;

	X = randn_complex(row_num, col_num);
	X = orth(X);
	assert(iscomplex(X));

	Z = randn_complex(row_num, col_num);
	assert(iscomplex(Z));


	realified_X = realification(X);
	real_Z = realification(Z);	


	% realified_X' * realified_X
	% N_vector = realified_X * mysym(randn(1))

	NSpace = orth(realified_X) * ctranspose(orth(realified_X));

	TSpace = eye(2 * row_num * col_num) - NSpace;

	Nvector_real = NSpace * real_Z;
	Tvector_real = TSpace * real_Z;
	Tvector_copy = real_Z - Nvector_real;


	assert(norm(Nvector_real + Tvector_real - real_Z) < 1e-6);
	assert(norm(Nvector_real + Tvector_copy - real_Z) < 1e-6);


	Nvector_complex = complexification(Nvector_real);
	Nvector_complex = reshape(Nvector_complex, row_num, col_num);

	Tvector_complex = complexification(Tvector_real);
	Tvector_complex = reshape(Tvector_complex, row_num, col_num);

	trace(Nvector_complex' * Tvector_complex)








	
	


end

function result = mysym(A)
	result = A + A';
	result = result / 2;
end


function result = randn_complex(row_num, col_num)
	result = randn(row_num, col_num) + i * randn(row_num, col_num);
end

function result = iscomplex(A)
	result = ~isreal(A);
end


function complex_vector = complexification(real_vector)
	assert(mod(numel(real_vector), 2) == 0)
	assert(size(real_vector, 2) == 1);
	assert(ndims(real_vector) == 2);

	real_vector = reshape(real_vector, 2, []);

	complex_vector = [real_vector(1, :); i * real_vector(2, :) ];
	complex_vector = sum(complex_vector);
	complex_vector = complex_vector(:);
end


function real_vector = realification(complex_vector)
	assert(~isreal(complex_vector));
	% array_size = size(complex_vector);

	complex_vector = complex_vector(:); 
	complex_vector = [real(complex_vector), imag(complex_vector) ];
	complex_vector = permute(complex_vector, [2, 1]);
	real_vector = complex_vector(:);
end