function idempotent_tscalar = idempotent(k, tsize)
	% this function is create on 19, Jan, 20201 by Liang Liao
	% this function returns the k-th idempotent t-scalar 

	assert(isequal(tsize', tsize(:)) );	 
	assert(ismember(k, 1: prod(tsize)) );
	
	idempotent_tscalar = zeros(tsize);
	idempotent_tscalar(k) = 1; 

	idempotent_tscalar = ifftn(idempotent_tscalar);
end