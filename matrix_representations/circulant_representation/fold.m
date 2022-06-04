function tmatrix = fold(block_column, tsize)
	% assert(isequal(tsize', tsize(:)));	  

	assert(numel(tsize) == 1);
	
	assert(isequal(class(block_column), 'double'));
	assert(ndims(block_column) == 2);
	assert(mod(size(block_column, 1), prod(tsize)) == 0);

	row_num = size(block_column, 1) / prod(tsize);
	col_num = size(block_column, 2);

	tmatrix = zeros(row_num, col_num, prod(tsize));

	for slice_index = 1: prod(tsize)
		row_index1 = (slice_index - 1) * row_num + 1;
		row_index2 = row_index1 + row_num - 1;

		tmatrix(:, :, slice_index) = block_column(row_index1: row_index2, :);

	end

	tmatrix = permute(tmatrix, [3 1 2]);
	tmatrix = reshape(tmatrix, [tsize, row_num, col_num]);

end