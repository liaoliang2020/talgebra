function result = tconj(tmatrix, tsize)
	% checked
	% checked
	% This function computes the conjugate t-matrix (without transposition) of a t-matrix  
	
	assert(isequal(tsize', tsize(:)));
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);
	
	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);	
	end
	tmatrix = conj(tmatrix);
	for i = 1: numel(tsize)
		tmatrix = ifft(tmatrix, [], i);	
	end

	result = tmatrix;
end