function result = thadamard(tmatrix1, tmatrix2, tsize)
	% this function computes the generalized Hamadard product of two t-matrices.  
	
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	assert(isequal(size(tmatrix1), size(tmatrix2)) );
	
	
	row_num = size(tmatrix1, numel(tsize) + 1);
	col_num = size(tmatrix1, numel(tsize) + 2);

	for i = 1: numel(tsize)
		tmatrix1 = fft(tmatrix, [], i);
		tmatrix2 = fft(tmatrix, [], i);		
	end

	result = tmatrix1 .* tmatrix2;

	% result = reshape(result, [tsize, row_num, col_num]);

	for i = 1: numel(tsize)
		result = fft(tmatrix, [], i);				
	end


	

end