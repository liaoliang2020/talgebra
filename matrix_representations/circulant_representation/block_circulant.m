function circulant_matrix =  block_circulant(tmatrix, tsize)
	
	% assert(isequal(tsize', tsize(:)));	 

	assert(numel(tsize) == 1); 
	assert(isequal(class(tmatrix), 'double'));
		
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

		circulant_matrix(:, index1: index2) = get_block_column(tmatrix(:, :, index_se_shift));
	end


end

