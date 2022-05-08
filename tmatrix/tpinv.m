function tresult = tpinv(tmatrix, tsize)
	% checked
	% checked
	% checked on 11-22-2018 by liaoliang
	% this function is updated by liaoliang in 20180117

	% this function computes the generalized Moore-Penrose inverse of a t-matrix
	
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	assert(isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1), size(tmatrix, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix), tsize) ...
	); 
	

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	% this line is commented by liaoliang in 20180120 since the pinv does not need that 
	% the row number is equal to the column number
	% assert(row_num == col_num);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	
	tmatrix = reshape(tmatrix, prod(tsize), row_num, col_num);
	tresult = zeros([prod(tsize), col_num, row_num]);

	for i = 1: prod(tsize)
		slice = reshape(tmatrix(i, :, :), row_num, col_num);
		
		
		if norm(slice(:)) < 1e-8
			slice = zeros(size(slice));
		end

		tresult(i, :, :) = pinv(slice);

	end

	tresult = reshape(tresult, [tsize, col_num, row_num]);

	for i = 1: numel(tsize)
		tresult = ifft(tresult, [], i);				
	end

end