function tmatrix_result = cell2tmatrix(cell_array, tmatrix_size, tsize)
	assert(isequal(tsize', tsize(:)));	  
	assert(numel(cell_array) == prod(tsize));
	assert(isequal(tmatrix_size(1: numel(tsize)), tsize));
	
	tmatrix_result = zeros(tmatrix_size);
	tmatrix_result = reshape(tmatrix_result, [prod(tsize), tmatrix_size(numel(tsize) + 1: end)] );


	for i = 1: prod(tsize)
		tmatrix_result(i, :, :) = cell_array{i};
	end

	tmatrix_result = reshape(tmatrix_result, tmatrix_size);

end