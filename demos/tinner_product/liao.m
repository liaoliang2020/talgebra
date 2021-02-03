function liao
	clear; close all; clc;
	row_num = 7;
	col_num = 3;

	A = randn([row_num, col_num]) + i * randn([row_num, col_num]);
	B = randn([row_num, col_num]) + i * randn([row_num, col_num]);


	trace(A * B')
	trace(A' * B)

	dot(A(:), B(:))


end