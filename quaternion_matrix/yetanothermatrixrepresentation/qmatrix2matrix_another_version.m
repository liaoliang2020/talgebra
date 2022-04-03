function matrix = qmatrix2matrix_another_version(qmatrix)
	assert(isequal(class(qmatrix), 'quaternion') );
	assert(numel(size(qmatrix)) == 2);

	row_num = size(qmatrix, 1);
	col_num = size(qmatrix, 2);

	matrix = zeros(2*row_num, 2*col_num);
	

	for j = 1: col_num
		for i = 1: row_num
			quaternion = qmatrix(i, j);
			assert(isequal(class(quaternion), 'quaternion') );
			assert(isequal(size(quaternion), [1 1]) );
			
			

			complex_matrix = qmatrix2matrix(quaternion);
			assert(isequal(size(complex_matrix), [2 2]) );
			
			row_index1 = (i - 1) * 2 + 1;
			row_index2 = row_index1 + 1;

			col_index1 = (j - 1) * 2 + 1;
			col_index2 = col_index1 + 1; 

			matrix(row_index1: row_index2, col_index1: col_index2) = complex_matrix;

		end%for i = 1: row_num
	end%for j = 1: col_num


end