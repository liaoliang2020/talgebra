function matrix2tmatrix_directsum(matrix, tsize)
	% This function returns the tmatrix represented by a direct sum matrix
	assert(isequal(tsize', tsize(:)));
	assert(mod(size(matrix, 1), K) == 0);
	assert(mod(size(matrix, 2), K) == 0);

	K = prod(tsize);
	row_num = size(matrix, 1) / K;
	col_num = size(matrix, 2) / K;

	tmatrix = zeros([prod(tsize), row_num, col_num]);

	for k = 1: K
		row_index1 = (k - 1) * row_num + 1;
		row_index2 = row_index1 + row_num - 1;

		col_index1 = (k - 1) * col_num + 1;
		col_index2 = col_index1 + col_num - 1;

		tmatrix(k, :, :) = matrix(row_index1: row_index2, col_index1: col_index2);

		matrix(row_index1: row_index2, col_index1: col_index2) = 0;
	end

	assert(norm(matrix, 'fro') < 1e-6);

	tmatrix = reshape(tmatrix, [tsize, row_num, col_num]);

	for k = 1: numel(tsize)
		tmatrix = ifft(tmatrix, [], k);		
	end



end