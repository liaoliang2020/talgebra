function [U_collection, max_mlrank] = hosvd_get_U(tensor)

	%checked
	
	assert(ndims(tensor) >= 3);
	max_mlrank = zeros(1, ndims(tensor));

	for mod_k = 1: ndims(tensor)
		Ak = tensorfactorkflattening(tensor, mod_k);
		[U, ~, ~] = svd(Ak, 'econ');
		rank_of_U = rank(U); 

		assert(rank_of_U == rank(Ak));
		max_mlrank(mod_k) = rank_of_U;
		U_collection{mod_k} = U;
	end


end