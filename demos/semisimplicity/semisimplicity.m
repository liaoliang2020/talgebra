function semisimplicity
	% This verifies the idempotent decomposition (also known direct product decomposition) 
	% is equal to the Fourier transform 

	clear; close all; clc;

	tsize = [3, 3];
	X = randn(tsize) + i * randn(tsize);

	idem_base = idempotent_base(tsize);

	Y = inv(idem_base) * X(:);
	Y = reshape(Y, tsize);	

	assert(norm(reshape(fftn(X) - Y, 1, [])) < 1e-6 );

	Y2 = prod(tsize) * idem_base' * X(:);
	Y2 = reshape(Y2, tsize);

	assert(norm(reshape(Y2 - Y, 1, [])) < 1e-6 );

	%-----------------------------
	row_num = 3; col_num = 7;

	A = randn([tsize, row_num, col_num]) + i * randn([tsize, row_num, col_num]);
	B = A;
	for k = 1: numel(tsize)
		B = fft(B, [], k);
	end

	C = prod(tsize) * idem_base' * reshape(A, prod(tsize), []);
	C = reshape(C, [tsize, row_num, col_num]);
	assert(norm(C(:) - B(:)) < 1e-6 );


	A_hat = idem_base * reshape(B, prod(tsize), []);
	A_hat = reshape(A_hat, [tsize, row_num, col_num]);
	assert(norm(A_hat(:) - A(:)) < 1e-6);

	fprintf('Sucessful\n');
	fprintf('All asserts in this script are passed\n');
	fprintf('The fourier transform is equivalent to the idempotentce decomposition\n');


end