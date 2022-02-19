function qmatrix = realmatrix2qmatrix(realmatrix)
	assert(isreal(realmatrix)); 
	assert(numel(size(realmatrix)) == 2 );

	assert(mod(size(realmatrix, 1) , 4) == 0);
	assert(mod(size(realmatrix, 2) , 4) == 0);

	row_num = size(realmatrix, 1) / 4;
	col_num = size(realmatrix, 2) / 4;

	qmatrix = quaternion(zeros(row_num * col_num, 4 ) );
	qmatrix = reshape(qmatrix, row_num, col_num);

	for i = 1: row_num
		for j = 1: col_num
			row_index1 = (i - 1) * 4 + 1;
			row_index2 = row_index1 + 4 - 1;

			col_index1 = (j - 1) * 4 + 1;
			col_index2 = col_index1 + 4 - 1;

			qmatrix(i, j) =  realmatrix2qscalar(realmatrix(row_index1: row_index2, col_index1: col_index2) );   
		end
	end

end%function qmatrix = realmatrix2qmatrix(realmatrix)
