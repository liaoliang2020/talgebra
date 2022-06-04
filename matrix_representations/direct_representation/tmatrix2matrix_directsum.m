function matrix = tmatrix2matrix_directsum(tmatrix, tsize)
	% checked 20220604
	% This function returns the direct sum matrix representation of a tmatrix

	assert(isequal(class(tmatrix), 'double'));

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0); 

	assert(isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1), size(tmatrix, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix), tsize) ...
	); 
	


	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
	end

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	K = prod(tsize);
	tmatrix = reshape(tmatrix, [K, row_num, col_num] ); 
	matrix = zeros(K * row_num,  K * col_num);

	for k = 1: K
		row_index1 = (k - 1) * row_num + 1;
		row_index2 = row_index1 + row_num - 1;

		col_index1 = (k - 1) * col_num + 1;
		col_index2 = col_index1 + col_num - 1;

		matrix(row_index1: row_index2, col_index1: col_index2) = reshape(tmatrix(k, :, :), row_num, col_num);
	end 


end