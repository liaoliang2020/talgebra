function test003
	clear; close all; clc;
	tsize = [3, 3];
	row_num = 7;
	col_num = 5;

	tmatrix = randn([tsize, row_num, col_num]) + i * randn([tsize, row_num, col_num]);
	
	% matrix = tmatrix2matrix(tmatrix, tsize);
	% whos tmatrix
	% whos matrix;

	% liao0 = norm(matrix, 'F')
	% liao2 = norm(svd(matrix, 'econ'))

	generalized_norm2 = tnorm(tmatrix, tsize, 'fro')

	% liao3 = tscalar2matrix(generalized_norm2);
	% liao3 = trace(liao3 * liao3);
	% liao3 = sqrt(liao3)

	generalized_norm3 = 0;
	tmatrix_reshaped = reshape(tmatrix, [prod(tsize), row_num * col_num]);
	for k = 1: (row_num * col_num)
		tscalar = tmatrix_reshaped(:, k);
		tscalar = reshape(tscalar, tsize); 

		tscalar = tabs_tscalar(tscalar);
		tscalar = tproduct(tscalar, tscalar);

		generalized_norm3 = generalized_norm3 + tscalar;
	end

	generalized_norm3 = tsqrt(generalized_norm3, tsize)



	[~, TS, ~] = tsvd(tmatrix, tsize);
	TS_squared = tmultiplication(TS, TS, tsize);
	mytnorm_sss = ttrace(TS_squared, tsize);
	mytnorm_sss = tsqrt(mytnorm_sss, tsize)

	mytnorm_sss1 = 0;
	for k = 1: min(row_num, col_num)
		tscalar = TS(:, :, k, k);
		mytnorm_sss1 = mytnorm_sss1 + tproduct(tscalar, tscalar);
	end

	mytnorm_sss1 = tsqrt(mytnorm_sss1, tsize)





	%----------------------------------
	tmatrix_fftn = tmatrix; 
	for k = 1: numel(tsize)
		tmatrix_fftn = fft(tmatrix_fftn, [], k);
	end

	tmatrix_fftn = reshape(tmatrix_fftn, [prod(tsize), row_num, col_num]);
	
	for k = 1: prod(tsize)
		slice = tmatrix_fftn(k, :, :);
		slice = reshape(slice, row_num, col_num);
		liao = svd(slice, 'econ');
		mytnorm(k) = norm(liao);
	end

	mytnorm = reshape(mytnorm, tsize);
	mytnorm = ifftn(mytnorm)
	%----------------------------------

	
	return;
end