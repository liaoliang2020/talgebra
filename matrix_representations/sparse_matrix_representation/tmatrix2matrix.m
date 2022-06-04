function matrix = tmatrix2matrix(tmatrix, tsize)
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0); 

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
	end

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	K = prod(tsize);
	tmatrix = reshape(tmatrix, [K, row_num, col_num] ); 
	matrix = zeros(K * row_num,  K * col_num); 

	for i = 1: row_num
		for k  = 1: col_num
			
			row_index1 = (i - 1) * K + 1; 
			row_index2 = row_index1 + K - 1;

			col_index1 = (k - 1) * K  + 1;
			col_index2 = col_index1 + K - 1;

			matrix(row_index1: row_index2, col_index1: col_index2) = diag(reshape(tmatrix(:, i, k), [], 1));
			  
		end
	end



end