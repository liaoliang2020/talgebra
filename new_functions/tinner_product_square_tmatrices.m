function result = tinner_product_square_tmatrices(A, B, tsize)
	% this function returns the inner product of two t-matrices A and B 
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(A) - numel(tsize) >= 0);
	assert(ndims(A) - numel(tsize) <= 2);
	assert(isequal(size(A), size(B) ) );

	assert(size(A,  numel(tsize) + 1) == size(A,  numel(tsize) + 2) );

	row_col_num = size(A,  numel(tsize) + 1);

	for i = 1: numel(tsize)
		A = fft(A, [], i);
		B = fft(B, [], i);
	end

	A = treshape(A, [prod(tsize), row_col_num, row_col_num] );
	B = treshape(B, [prod(tsize), row_col_num, row_col_num] );

	result = zeros(1, prod(tsize));
	for i = 1: prod(tsize)
		slice1 = reshape(A(i, :, :), row_col_num, row_col_num);
		slice2 = reshape(B(i, :, :), row_col_num, row_col_num); 
		result(i) = trace(slice1 * slice2');
	end

	result = conj(reshape(A, tsize));

	for i = 1: prod(tsize)
		result = ifft(result, [], i);
	end

end