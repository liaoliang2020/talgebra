function real_matrix = qmatrix2realmatrix(qmatrix)
	% this function returns the real matrix representation of a quaternion matrix

	assert(isequal(class(qmatrix), 'quaternion' ));
	assert(numel(size(qmatrix) ) == 2 );

	row_num = size(qmatrix, 1);
	col_num = size(qmatrix, 2); 

	real_matrix = zeros(4 * size(qmatrix) );
	
	for i = 1: row_num
		for j = 1: col_num
			row_index1 = (i - 1) * 4 + 1;
			row_index2 =  row_index1 + 4 - 1;

			col_index1 = (j - 1) * 4 + 1;
			col_index2 = col_index1 + 4 - 1;

			real_matrix(row_index1: row_index2, col_index1: col_index2) = qscalar2realmatrix(qmatrix(i, j) );

		end%for j = 1: col_num
	end%for i = 1: row_num

end%function real_matrix = qmatrix2realmatrix(qmatrix)