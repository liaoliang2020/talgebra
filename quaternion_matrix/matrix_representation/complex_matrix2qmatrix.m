function qmatrix = complex_matrix2qmatrix(matrix)
	% this return the qmatrix represented by a complex matrix.  

	assert(numel(size(matrix)) <= 2);

	row_num = size(matrix, 1);
	col_num = size(matrix, 2);

	assert(mod(row_num, 2) == 0);
	assert(mod(col_num, 2) == 0);

	row_num = row_num / 2;
	col_num = col_num / 2;	 

	Q1 = matrix(1: row_num, 1: col_num);
	Q2 = matrix(1: row_num, (col_num + 1): (2* col_num));

	assert(norm(conj(Q2) * (-1) - matrix((row_num + 1): end, 1: col_num ), 'fro') < 1e-5);
	assert(norm(conj(Q1) - matrix((row_num + 1): end, (col_num + 1): end), 'fro') < 1e-5);

	qmatrix = quaternion(real(Q1), imag(Q1), real(Q2), imag(Q2));

end

