function liao
	clear; close all; clc;
	row_num = 7;
	col_num = 3;

	A = randn([row_num, col_num]) + i * randn([row_num, col_num]);
	B = randn([row_num, col_num]) + i * randn([row_num, col_num]);

	liaoliang000 = dot(A(:), B(:));
	liaoliang001 = trace(A' * B);

	liaoliang002 = trace(A * B');
	liaoliang002 = liaoliang002';

	[liaoliang000; liaoliang001; liaoliang002]



end