function tmatrix_transformed = multiway_fft(tmatrix, tsize)
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
	end

	tmatrix_transformed = tmatrix;
end