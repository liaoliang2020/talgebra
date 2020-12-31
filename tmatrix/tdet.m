function tresult_scalar = tdet(tmatrix, tsize)
	% 20190121
	% checked

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	assert(row_num == col_num);

	

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	tmatrix = reshape(tmatrix, prod(tsize), row_num, col_num);
	tresult_scalar = zeros(tsize);

	for i = 1: prod(tsize)
		slice = reshape(tmatrix(i, :, :), row_num, col_num);
		tresult_scalar(i) = det(slice);
	end

	tresult_scalar = reshape(tresult_scalar, tsize);

	tresult_scalar = ifftn(tresult_scalar);

end