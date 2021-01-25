function result = pooling(tmatrix, tsize, mode)
	% This function returns the average pooling of a t-matrix in the spartial domain or the Fourier domain
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	if nargin == 2
		mode = 'spatial';
	end
	
	assert(isequal(mode, 'spatial') | isequal(mode, 'fourier'));

	if isequal(mode, 'fourier')
		for i = 1: numel(tsize)
			tmatrix = fft(tmatrix, [], i);
		end
	end	

	tmatrix_size = size(tmatrix);	
	assert(numel(tsize) <= numel(tmatrix_size));

	msize = tmatrix_size((numel(tsize) + 1): end);

	tmatrix = reshape(tmatrix, prod(tsize), []); 
	tmatrix = mean(tmatrix, 1);
	result = reshape(tmatrix, msize);

	
end