function matrix = qmatrix2matrix(qmatrix)
	% this function returns the complex matrix representation of a qmatrix
	% the returned complex matrix is of two size  of the input qmatrix
	
	assert(isequal(class(qmatrix), 'quaternion') );
	assert(numel(size(qmatrix)) == 2);

	row_num = size(qmatrix, 1);
	col_num = size(qmatrix, 2);

	matrix = zeros(2 * [row_num, col_num] );

	for row_index = 1: row_num
		for col_index = 1: col_num
			x = qmatrix(row_index, col_index);
			x = compact(x);
			x1 = sum(x(1:2) .* [1 i]);
			x2 = sum(x(3:4) .* [1 i]);

			row_begin = (row_index - 1) * 2 + 1;
			row_end   = row_begin + 1;

			col_begin = (col_index - 1) * 2 + 1;
			col_end   = col_begin + 1;

			matrix(row_begin: row_end, col_begin: col_end) = [x1 x2; -conj(x2) conj(x1)]; 

		end%for col_index = 1: col_num
	end%for row_index = 1: row_num


end