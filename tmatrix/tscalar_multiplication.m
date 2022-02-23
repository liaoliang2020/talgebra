function tmatrix_result = tscalar_multiplication(tscalar, tmatrix, tsize)
	%This function computes the result of a tscalar multiplified with a tmatrix 

	assert(isequal(tsize', tsize(:)));	  
	assert(isequal(size(tscalar), tsize));
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);
	
	tscalar = fftn(tscalar);
	tscalar = tscalar(:);
	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
	end

	tmatrix = reshape(tmatrix, prod(tsize), []);
	tmatrix_result = zeros(size(tmatrix) );

	for i = 1: prod(tsize)
		tmatrix_result(i, :) = tscalar(i) * tmatrix(i, :);  
	end

	tmatrix_result = reshape(tmatrix_result, [tsize, row_num, col_num]);	

	for i = 1: numel(tsize)
		tmatrix_result = ifft(tmatrix_result, [], i);
	end

end