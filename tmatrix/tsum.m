function result = tsum_sub(tmatrix, tsize)
	% checked
	%this function computes the sum of the t-scalar entities of each column of a t-matrix.  
	
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);
	
	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);
	
	tmatrix = reshape(tmatrix, prod(tsize), row_num, col_num);
	tmatrix = permute(tmatrix, [2, 1, 3]);
	tmatrix = reshape(tmatrix, row_num, []);
	
	tmatrix = sum(tmatrix);
	
	tmatrix = reshape(tmatrix, [tsize, col_num]);
	result = tmatrix;
	
	

end