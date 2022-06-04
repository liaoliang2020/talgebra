function tmatrix = matrix2tmatrix(matrix, tsize)
	% This funcition convert a complex matrix to its t-matrix version  


	assert(isequal(tsize', tsize(:)));
	K = prod(tsize);

	assert(mod(size(matrix, 1), K) == 0);
	assert(mod(size(matrix, 2), K) == 0);

	row_num = size(matrix, 1) / K;
	col_num = size(matrix, 2) / K;

	tmatrix = zeros([prod(tsize), row_num, col_num]);

	for i = 1: row_num
		for k = 1: col_num
			row_index1 = (i - 1) * K + 1;
			row_index2 = row_index1 + (K -1);

			col_index1 = (k - 1) * K + 1;
			col_index2 =  col_index1 + (K - 1);

			submatrix = matrix(row_index1: row_index2, col_index1: col_index2);
			assert(norm(diag(diag(submatrix)) - submatrix, 'fro') < 1e-8);

			tmatrix(:, i, k) = diag(submatrix);
		end
	end

	tmatrix = reshape(tmatrix, [tsize, row_num, col_num]);

	for i = 1: numel(tsize)
		tmatrix = ifft(tmatrix, [], i);
	end

end