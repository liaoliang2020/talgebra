function test
	clear; close all; clc;
	
	row_num = 7;
	col_num = 5;

	qmatrix = quaternion(randn(row_num * col_num, 4));
	qmatrix = reshape(qmatrix, [row_num, col_num]);

	[QU, QS, QV] = qmatrix_svd(qmatrix);

	whos qmatrix
	whos QU;
	whos QS;
	whos QV;


	liaoliang = qmatrix_multiplication_arg3(QU, QS, qmatrix_ctranspose(QV)) - qmatrix;

	norm(compact(liaoliang), 'fro')
	









end