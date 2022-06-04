function circulant_matrix =  mybcirc(tmatrix, tsize)
	
	assert(isequal(class(tmatrix), 'double'));
	
	
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	assert(isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1), size(tmatrix, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix), tsize) ...
	); 

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	tmatrix = reshape(tmatrix, [prod(tsize), row_num, col_num]  );
	tmatrix = permute(tmatrix, [2, 3, 1]);

	circulant_matrix = zeros(row_num * prod(tsize), col_num * prod(tsize));

	index_set = 1: prod(tsize);
	for k = 0: (prod(tsize) - 1)
		index_se_shift = circshift(index_set, k);

		index1 = k * col_num + 1;
		index2 = (k + 1) * col_num;

		circulant_matrix(:, index1: index2) = get_two_dimension_array(tmatrix(:, :, index_se_shift));
	end


end


function result = get_two_dimension_array(array)
	assert(ndims(array) == 3);
	[row_num, col_num, fra_num] = size(array); 

	result = zeros(fra_num * row_num, col_num);

	for i = 1: fra_num
		index1 = (i - 1) * row_num + 1;
		index2 = i * row_num;

		result(index1: index2, :) = array(:, :, i);

	end

end