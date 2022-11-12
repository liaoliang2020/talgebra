function qmatrix = matrix2qmatrix(matrix)
	% this return the qmatrix represented by a complex matrix.  

	assert(isequal(class(matrix), 'double'));
	assert(ndims(matrix) == 2);

	row_num = size(matrix, 1);
	col_num = size(matrix, 2);

	assert(mod(row_num, 2) == 0);
	assert(mod(col_num, 2) == 0);

	row_num = row_num / 2;
	col_num = col_num / 2;	 

	qmatrix = zeros(row_num, col_num);
	qmatrix = quaternionize(qmatrix);

	for row_index = 1: row_num
		for col_index = 1: col_num
			row_begin = (row_index - 1) * 2 + 1;
			row_end   = row_begin + 1;

			col_begin = (col_index - 1) * 2 + 1;
			col_end =  col_begin + 1;

			complex_matrix_block = matrix(row_begin: row_end, col_begin: col_end); 
			r1 = complex_matrix_block(1, :); 
			r2 = complex_matrix_block(2, :); 
			r2 = r2 .* [-1 1]; 
			r2 = conj(r2([2 1])); 
			
			assert(norm(r1 - r2) < 1e-6); 
			x1 = r1(1); 
			x2 = r1(2); 

			qmatrix(row_index, col_index) = quaternion([real(x1), imag(x1), real(x2), imag(x2)]);

		end%for col_index = 1: col_num
	end%for row_index = 1: row_num


	
end

