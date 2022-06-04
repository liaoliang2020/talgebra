function result = get_block_column(array)
	assert(ndims(array) == 3);
	[row_num, col_num, fra_num] = size(array); 

	result = zeros(fra_num * row_num, col_num);

	for i = 1: fra_num
		index1 = (i - 1) * row_num + 1;
		index2 = i * row_num;

		result(index1: index2, :) = array(:, :, i);

	end

end