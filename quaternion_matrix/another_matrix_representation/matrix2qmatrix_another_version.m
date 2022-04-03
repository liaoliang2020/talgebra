function qmatrix = matrix2qmatrix_another_version(matrix)
	assert(numel(size(matrix)) <= 2);

	row_num = size(matrix, 1);
	col_num = size(matrix, 2);

	assert(mod(row_num, 2) == 0);
	assert(mod(col_num, 2) == 0);

	row_num = row_num / 2;
	col_num = col_num / 2;


	for j = 1: col_num
		for i = 1: row_num
			row_index1 = (i - 1) * 2 + 1;
			row_index2 = row_index1 + 1;

			col_index1 = (j - 1) * 2 + 1;
			col_index2 = col_index1 + 1;

			complex_matrix = matrix(row_index1: row_index2, col_index1: col_index2); 
			assert(isequal(size(complex_matrix), [2 2] ) );
			
			quaternion = matrix2qmatrix(complex_matrix);
			assert(numel(quaternion) == 1);

			qmatrix(i, j) = quaternion;	

		end%for i = 1: row_num
	end%for j = 1: col_num


	% liaoliang = quaternion(randn(1, 4) );
	% whos liaoliang	
	% qmatrix = reshape(qmatrix, row_num, col_num);
	% qmatrix = [];




end