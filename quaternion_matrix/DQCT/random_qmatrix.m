function qmatrix = random_qmatrix(row_num, col_num)
	assert(row_num > 0);
	assert(col_num > 0);

	qmatrix = quaternion( randn(row_num * col_num, 4));
	qmatrix = reshape(qmatrix, row_num, col_num);
end