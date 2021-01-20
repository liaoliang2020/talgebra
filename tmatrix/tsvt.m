function approximation_tmatrix = tsvt(tmatrix, tau, tsize)
	% this function computes the generalized Singular Value Thresholding of a t-matrix
	% tau is a nonnegative t-sclalar 
	% created by liaoliang 20190121

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	% If tau is NOT t-scalar but a canonical scalar
	% Then transform tau to a t-scalar
	if ~isequal(size(tau), size(tsize)) & numel(tau) == 1
		tau = [tau, zeros(1, numel(tsize) - 1) ];
		tau = reshape(tau, size(tsize));
	end

	assert(is_nonnegative(tau));
	assert(isequal(size(tau), tsize));

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);


	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
	end

	tmatrix = reshape(tmatrix, prod(tsize), []);
	tau = reshape(fftn(tau), [], 1);

	approximation_tmatrix = tmatrix; 
	for i = 1: prod(tsize)
		slice = reshape(tmatrix(i, :), row_num, col_num);
		tau_scalar = abs(tau(i));
		assert(tau_scalar >= 0);
		approximation = svt(slice, tau_scalar);

		approximation_tmatrix(i, :) = approximation(:);  
	end

	approximation_tmatrix = reshape(approximation_tmatrix, [tsize, row_num, col_num]);

	for i = 1: numel(tsize)
		approximation_tmatrix = ifft(approximation_tmatrix, [], i);
	end

end