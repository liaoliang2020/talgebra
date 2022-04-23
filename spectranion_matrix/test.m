function test
	clear; close all; clc;
	row_num = 7;
	col_num = 5;
	tsize = [3, 3];

	smatrix = quaternion(randn(prod(tsize) * row_num * col_num, 4) );
	whos  smatrix;

	smatrix = reshape(smatrix, [tsize, row_num, col_num]);
	whos smatrix;


	[SU, SS, SV] = smatrix_svd(smatrix, tsize);
	whos SU;
	whos SS; 
	whos SV;

	approximation = smatrix_multiplication_arg3(SU, SS, smatrix_ctranspose(SV, tsize), tsize);
	
	assert(norm(compact(approximation - smatrix), 'fro') < 1e-6);
	




end