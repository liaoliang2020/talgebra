function result = trepmat(tmatrix, rep_row_num, rep_col_num, tsize)
	% checked
	% checked
	% checked
	% this function generalizes the canonical MATLAB function repmat


	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);

	result = repmat(reshape(tmatrix, [], col_num), rep_row_num, rep_col_num);
	result = reshape(result, [tsize, row_num * rep_row_num, col_num * rep_col_num]);	


end