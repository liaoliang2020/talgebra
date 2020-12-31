function tmatrix_result = tsimtranspose(tmatrix, tsize)
	% this function compute the simple non-conjugate transpose of a t-matrix
	% checked

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);


	tmatrix_result = permute(tmatrix, [1: numel(tsize),  numel(tsize) + 2, numel(tsize) + 1]); 


	

end