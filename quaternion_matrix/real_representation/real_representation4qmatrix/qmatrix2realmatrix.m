function real_matrix = qmatrix2realmatrix(qmatrix)
	% this function returns the real matrix representation of a quaternion matrix

	assert(isequal(class(qmatrix), 'quaternion' ));
	assert(numel(size(qmatrix) ) == 2 );

	row_num = size(qmatrix, 1);
	col_num = size(qmatrix, 2); 

	real_matrix = zeros(4 * size(qmatrix) );
	
	qmatrix = compact(qmatrix);

	index = 0;
	for j = 1: col_num
		for i = 1: row_num
			index = index + 1;

			row_index1 = (i - 1) * 4 + 1;
			row_index2 =  row_index1 + 4 - 1;

			col_index1 = (j - 1) * 4 + 1;
			col_index2 = col_index1 + 4 - 1;

			x1 = qmatrix(index, 1);			
			x2 = qmatrix(index, 2);
			x3 = qmatrix(index, 3);
			x4 = qmatrix(index, 4);
			
			real_matrix(row_index1: row_index2, col_index1: col_index2) = [x1 -x2 x3 -x4; x2 x1 x4 x3; -x3 -x4 x1 x2; x4 -x3 -x2 x1];
			% real_matrix(row_index1: row_index2, col_index1: col_index2) = qscalar2realmatrix(qmatrix(i, j) );

		end%for i = 1: row_num
	end%for j = 1: col_num

end%function real_matrix = qmatrix2realmatrix(qmatrix)