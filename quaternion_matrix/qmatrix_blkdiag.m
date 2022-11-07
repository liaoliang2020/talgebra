function qmatrix_result = qmatrix_blkdiag(qmatrix1, qmatrix2)
	
	assert(isequal(class(qmatrix1), 'quaternion'));
	assert(isequal(class(qmatrix2), 'quaternion'));
	assert(ndims(qmatrix1) == 2);
	assert(ndims(qmatrix2) == 2);

	if isempty(qmatrix1)
		qmatrix_result = qmatrix2;
		return;
	end

	if isempty(qmatrix2)
		qmatrix_result = qmatrix1;
		return;
	end


	row_num001 = size(qmatrix1, 1);
	col_num001 = size(qmatrix1, 2);
	
	row_num002 = size(qmatrix2, 1);
	col_num002 = size(qmatrix2, 2);

	my_row_num = row_num001 + row_num002;
	my_col_num = col_num001 + col_num002;

	qmatrix_result = zeros(my_row_num * my_col_num, 4);
	qmatrix_result = quaternion(qmatrix_result);
	qmatrix_result = reshape(qmatrix_result, [my_row_num, my_col_num]);

	qmatrix_result(1: row_num001, 1: col_num001) = qmatrix1;
	qmatrix_result((row_num001 + 1): end, (col_num001 + 1): end ) = qmatrix2;
end
