function result = is_direct_sum(matrix, K)
	
	assert(isequal(class(matrix), 'double') | isequal(class(matrix), 'quaternion'));
	assert(ndims(matrix) == 2);

	row_num = size(matrix, 1); 
	col_num = size(matrix, 2); 

	assert(mod(row_num, K) == 0);
	assert(mod(col_num, K) == 0);

	row_num_block = row_num / K;
	col_num_block = col_num / K;

	
	zero_block = zeros([row_num_block, col_num_block]);

	if isequal(class(matrix), 'quaternion')
		zero_block = quaternionize(zero_block);
	end

	for k = 1: K
		row_index1 = (k - 1) * row_num_block + 1;
		row_index2 = row_index1 + row_num_block - 1;

		col_index1 = (k - 1) * col_num_block + 1;
		col_index2 = col_index1 + col_num_block - 1;

		matrix(row_index1: row_index2, col_index1: col_index2) = zero_block;

	end%for k = 1: K

	if norm(matrix(:)) < 1e-6
		result = true;
	else 
		result = false;
	end
end