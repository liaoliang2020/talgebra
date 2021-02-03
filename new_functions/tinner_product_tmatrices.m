function result = tinner_product_square_tmatrices(A, B, tsize)
	% this function returns the inner product of two t-matrices A and B 
	% the size of A must be equal to the size of B 
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(A) - numel(tsize) >= 0);
	assert(ndims(A) - numel(tsize) <= 2);
	assert(isequal(size(A), size(B) ) );

	row_col_num = size(A,  numel(tsize) + 1);
	col_col_num = size(A,  numel(tsize) + 2);

	for i = 1: numel(tsize)
		A = fft(A, [], i);
		B = fft(B, [], i);
	end

	A = treshape(A, [prod(tsize), row_col_num, col_col_num] );
	B = treshape(B, [prod(tsize), row_col_num, col_col_num] );

	result = zeros(1, prod(tsize));
	for i = 1: prod(tsize)
		slice1 = reshape(A(i, :, :), row_col_num, col_col_num);
		slice2 = reshape(B(i, :, :), row_col_num, col_col_num); 
		% result(i) = trace(slice1 * slice2');
		result(i) = trace(slice1' * slice2');
	end

	result = reshape(result, tsize);

	% result = conj(reshape(result, tsize));

	for i = 1: prod(tsize)
		result = ifft(result, [], i);
	end

end