function algebra_rank
	clear; close all; clc;

	row_num = 7;
	col_num = 3;

	X = randn(row_num, col_num);
	X = orth(X);
	Xspace = X * X';

	liaoliang = [];
	for i = 1: 99999
		d = Xspace * randn(row_num, 1);
		liaoliang = [liaoliang, d(:)];
	end
	
	rank(liaoliang)

	A = randn(row_num) + i * randn(row_num);
	A = orth(A);

	A = round(A, 3);

	% whos liaoliang
	% whos A

	A = round(A * liaoliang, 6);
	rank(A) 


end