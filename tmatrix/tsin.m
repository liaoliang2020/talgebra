function result = tsin(tmatrix, tsize)
	% checked
	% this function computes the (generalized) sine of each t-scalars in t-matrix

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	assert(isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1), size(tmatrix, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix), tsize) ...
	); 
	

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	tmatrix = sin(tmatrix);
	
	% tmatrix = reshape(tmatrix, prod(tsize), []);

	% for i = 1: prod(tsize)
	% 	tmatrix(i, :) = sin(tmatrix(i, :));
	% end

	% tmatrix = reshape(tmatrix, [tsize, row_num, col_num]);

	for i = 1: numel(tsize)
		tmatrix = ifft(tmatrix, [], i);		
	end

	result = tmatrix;

end