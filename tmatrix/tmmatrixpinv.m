function pinv_tmatrix = tmmatrixpinv(tmatrix, tsize)

	% The generalized Moore-Penrose inverse for a t-matrix	

	assert(isequal(tsize', tsize(:)));	 	
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);

	[TU, TS, TV] = tsvd(tmatrix, tsize);

	row_num = size(TS, numel(tsize) + 1);
	col_num = size(TS, numel(tsize) + 2);

	TS = reshape(TS, [prod(tsize), row_num, col_num ]);
	for i = 1: min(row_num, col_num)
		diag_entry_t_scalar =  tscalarpinv(reshape(TS(:, i, i), tsize)); 
		TS(:, i, i) = diag_entry_t_scalar(:);
	end

	TS = reshape(TS, [tsize, row_num, col_num]);


	pinv_tmatrix = tmultiplication(TV, tctranspose(TS, tsize), tsize);
	pinv_tmatrix = tmultiplication(pinv_tmatrix, tctranspose(TU, tsize), tsize);

end

