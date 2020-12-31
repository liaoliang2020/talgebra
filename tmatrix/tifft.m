function tmatrix_result = tifft(tmatrix, tsize)
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);

	for i = 1: numel(tsize)
		tmatrix = ifft(tmatrix, [], i);
	end

	tmatrix_result = tmatrix;


end