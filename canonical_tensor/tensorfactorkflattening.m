function flat_matrix = tensorfactorkflattening(tensor, mod_k)
	% checked
	% checked

	order_num = ndims(tensor);

	assert(order_num >= 2);
	assert(ismember(mod_k, 1: order_num));

	dim_sequence = 1: order_num;
	dim_sequence(mod_k) = [];
	dim_sequence = [mod_k, dim_sequence];

	
	

	tensor = permute(tensor, dim_sequence);
	flat_matrix = reshape(tensor, size(tensor, 1), []);




end