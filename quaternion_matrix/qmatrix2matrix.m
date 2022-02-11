function matrix = qmatrix2matrix
	assert(numel(size(qmatrix)) == 2);

	row_num = size(qmatrix, 1);
	col_num = size(qmatrix, 2);

	qmatrix = compact(qmatrix);
	assert(size(qmatrix, 2) == 4);

	Q1 = qmatrix(:, 1) + i * qmatrix(:, 2);
	Q1 = reshape(Q1, row_num, col_num);

	Q2 = qmatrix(:, 3) + i * qmatrix(:, 4);
	Q2 = reshape(Q2, row_num, col_num);	

	matrix = zeros(2 * [row_num, col_num] );

	index = 0;
	for k = 1: 2
		for j = 1: 2
			index = index + 1;

			row_index1 = (k - 1) * row_num + 1;
			row_index2 = row_index1 + row_num - 1;
			
			col_index1 = (j - 1) * col_num + 1;
			col_index2 = col_index1 + col_num - 1;


			switch index
				case 1   
				 	matrix(row_index1: row_index2, col_index1: col_index2) = Q1;
				case 2
					matrix(row_index1: row_index2, col_index1: col_index2) = Q2;
				case 3
					matrix(row_index1: row_index2, col_index1: col_index2) = -conj(Q2);
				case 4
					matrix(row_index1: row_index2, col_index1: col_index2) = conj(Q1);
				otherwise
					assert(false);
			end%switch index		 
		

		end%for j = 1: 2
	end%for k = 1: 2



end