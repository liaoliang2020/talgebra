function TPCA
	clear; close all; clc;

	tsize = [3, 3];
	row_num = 7;
	col_num = 5;

	tmatrix = randn([tsize, row_num, col_num]);

	myrank = trank(tmatrix, tsize)


end