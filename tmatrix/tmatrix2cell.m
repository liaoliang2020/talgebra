function cell_array = tmatrix2cell(tmatrix, tsize)
	%this function generates each slice of tmatrix in the original domain
	%and store these slices in a cell linearly
	%checked
	
	
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);

	tmatrix = reshape(tmatrix, [prod(tsize), row_num, col_num]);

	cell_array = cell(1, prod(tsize) );

	for i = 1: prod(tsize)
		cell_array{i} = reshape(tmatrix(i, :, :), row_num, col_num);		
	end

end