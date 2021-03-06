function flat_tmatrix = gtensor_unfolding(gtensor, mod_k, tsize)
	% checked
	% this function flaten a generalized g-tensor to a t-matrix


	assert(isequal(tsize', tsize(:)));	 
	order_num = ndims(gtensor) - numel(tsize);
	assert(order_num >= 3);
	assert(ismember(mod_k, 1: order_num));


	dim_sequence = 1: order_num;
	dim_sequence(mod_k) = [];
	dim_sequence = [mod_k, dim_sequence];


	dim_sequence = dim_sequence + numel(tsize);
	dim_sequence = [1: numel(tsize), dim_sequence];

	%--------------------------------------
	gtensor = permute(gtensor, dim_sequence);
	reshape_size = size(gtensor);
	reshape_size = [reshape_size(1: (numel(tsize) + 1)),  prod(reshape_size((numel(tsize) + 2): end) ) ];
	
	flat_tmatrix = reshape(gtensor, reshape_size);

end