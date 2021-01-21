function  idem_base = idempotent_base(tsize)
	assert(isequal(tsize', tsize(:)));	  

	idem_base = zeros(prod(tsize) );

	for i = 1: prod(tsize)
		idemp = idempotent(i, tsize);
		idem_base(:, i) = idemp(:);
	end

end