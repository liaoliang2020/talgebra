function TPCA
	clear; close all; clc;

	tsize = [3, 3];
	row_num = 7;
	col_num = 5;

	tmatrix = randn([tsize, row_num, col_num]);

	myrank = trank(tmatrix, tsize);
	tvector_mean = tmean(tmatrix, 2, tsize);
	
	
	tmatrix_without_mean = tmatrix - trepmat(tvector_mean, [1, col_num], tsize);
	myrank = trank(tmatrix_without_mean, tsize);

	[TU, TS, ~] = tsvd(tmatrix_without_mean, tsize);
	% TU = tmultiplication_arg3(TU, TS, tpinv(TS, tsize), tsize);

	G = tcov(tmatrix_without_mean, tsize);
	[TU2, TS, ~] = tsvd(G, tsize);
	TU2 = TU2(:, :, :, 4);
	TU = TU(:, :, :, 4);

	liaoliang2 = tmultiplication(TU2, tctranspose(TU2, tsize), tsize);
	liaoliang  = tmultiplication(TU,  tctranspose(TU, tsize),  tsize);

	isequal(round(liaoliang2, 4), round(liaoliang, 4))  


end