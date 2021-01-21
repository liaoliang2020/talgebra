function approximation = tsvd_approximation(tmatrix, delta, tsize)
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	% If delta is NOT t-scalar but a canonical scalar
	% Then transform delta to a t-scalar
	if ~isequal(size(delta), size(tsize)) & numel(delta) == 1
		delta = delta * E_T(tsize);		
	end

	%assert(is_nonnegative(delta));
	assert(isequal(size(delta), tsize));

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	max_canonical_rank = min(row_num, col_num);

	delta = fftn(delta);
	delta = abs(delta);

	delta = delta(:);
	delta = floor(delta);
	delta(delta < 0) = 0;
	delta(delta > max_canonical_rank) = max_canonical_rank;

  	assert(numel(delta) == prod(tsize));


	S_delta = [];
	for i = 1: prod(tsize)
		liao = ones(delta(i), 1);
		liao = [liao; zeros(max_canonical_rank - delta(i), 1) ];
		liao = diag(liao);
		
		S_delta = [S_delta, liao(:)];
	end 

	S_delta = permute(S_delta, [2, 1]);
	S_delta = reshape(S_delta, [tsize, max_canonical_rank, max_canonical_rank]);

	for i = 1: numel(tsize)
		S_delta = ifft(S_delta, [], i);
	end

	[U, S, V] = tsvd(tmatrix, tsize);

	approximation1 = tmultiplication(U, S, tsize);
	approximation2 = tmultiplication(S_delta, tctranspose(V, tsize), tsize );
	approximation = tmultiplication(approximation1, approximation2, tsize);

end