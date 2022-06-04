function tmatrix = inv_block_circulant(circulant_matrix, tsize)
	assert(isequal(class(circulant_matrix), 'double'));	
	assert(ndims(circulant_matrix) == 2);
	[circulant_row_num, circulant_col_num] = size(circulant_matrix);

	row_num = circulant_row_num / prod(tsize);
	col_num = circulant_col_num / prod(tsize);


	tmatrix = zeros(row_num, col_num, prod(tsize));
	block_colum = circulant_matrix(:, 1: col_num);

	for slice_index = 1: prod(tsize)
		row_index1 = (slice_index - 1) * row_num + 1;
		row_index2 = row_index1 + row_num - 1;
		tmatrix(:, :, slice_index) = block_colum(row_index1: row_index2, :);
	
	end%for slice_index = 1: prod(tsize)

	tmatrix = permute(tmatrix, [3 1 2]);
	tmatrix = reshape(tmatrix, [tsize, row_num, col_num]);

	assert(norm(block_circulant(tmatrix, tsize) - circulant_matrix, 'fro') < 1e-6);

end