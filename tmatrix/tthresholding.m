function result = tthresholding(tmatrix, tscalar, mode, tsize)
	% checked
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);
	assert(ismember(mode, {'top', 'bottom'} ));
	assert(isequal(size(tscalar), tsize)); 
	
	assert(norm(reshape(treal(tmatrix, tsize), [], 1) - tmatrix(:)) < 1e-6); 
	assert(norm(reshape(treal(tscalar, tsize), [], 1) - tscalar(:)) < 1e-6);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end
	tscalar = fftn(tscalar);

	tmatrix = real(tmatrix);
	tmatrix = reshape(tmatrix, prod(tsize), [] );

	tscalar = real(tscalar);
	
	for i = 1: prod(tsize)
		slice = tmatrix(i, :);
		switch mode
			case 'top'
				pos = find(slice >= tscalar(i));
			case 'bottom'
				pos = find(slice <= tscalar(i));				
			otherwise
				assert(false);
		end

		slice(pos) = tscalar(i);
		tmatrix(i, :) = slice;
	end

	tmatrix = reshape(tmatrix, [tsize, row_num, col_num]);

	for i = 1: numel(tsize)
		tmatrix = ifft(tmatrix, [], i);		
	end

	result = tmatrix;

end