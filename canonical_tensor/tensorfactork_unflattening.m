function tensor = tensorfactork_unflattening(standard_matrix, tensor_size, mod_k)
	assert(ismatrix(standard_matrix));
	assert(isequal(tensor_size', tensor_size(:)));	
	assert(ismember(mod_k, 1: numel(tensor_size) ));
	assert(numel(standard_matrix) == prod(tensor_size));
	assert(size(standard_matrix, 1) == tensor_size(mod_k));

	tensor = zeros(tensor_size);
	
	order_num = numel(tensor_size);

	pos = 1: order_num;
	pos(mod_k) = [];
	pos = [mod_k, pos];

	tensor = permute(tensor, pos);

	tensor(:) = standard_matrix(:);
	pos = 1: order_num;
	pos(1) = [];

	pos = [pos(1: (mod_k - 1)), 1, pos(mod_k: end)];
	tensor = permute(tensor, pos);
	
end