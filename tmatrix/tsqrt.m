function result = tsqrt(tmatrix, tsize)
	% checked
	% this function computes the (generalized) sqrt of each t-scalars in t-matrix

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	tmatrix = sqrt(tmatrix);

	% tmatrix = reshape(tmatrix, prod(tsize), []);

	% for i = 1: prod(tsize)
	% 	tmatrix(i, :) = sqrt(tmatrix(i, :));
	% end

	% tmatrix = reshape(tmatrix, [tsize, row_num, col_num]);

	for i = 1: numel(tsize)
		tmatrix = ifft(tmatrix, [], i);		
	end

	result = tmatrix;

end