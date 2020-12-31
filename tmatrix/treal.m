function result = treal(tmatrix, tsize)
	% checked
	
	% this function computes the (generalized) real part of each t-scalar entity of a t-matrix.  
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	% row_num = size(tmatrix, numel(tsize) + 1);
	% col_num = size(tmatrix, numel(tsize) + 2);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	tmatrix = real(tmatrix); 

	for i = 1: numel(tsize)
		tmatrix = ifft(tmatrix, [], i);		
	end

	result = tmatrix;

end