function new_tensor = tensor_add_lid(tensor)
	assert(isnumeric(tensor));
	assert(ndims(tensor) >= 2);

	new_tensor = tensor;

	for mod_k = 1: ndims(tensor)
		standard_matrix = tensorfactorkflattening(new_tensor, mod_k);
		standard_matrix = [standard_matrix; zeros(2, size(standard_matrix, 2))];
		standard_matrix = circshift(standard_matrix, [1, 0]);


		new_tensor_size = size(new_tensor);
		new_tensor_size(mod_k) = new_tensor_size(mod_k) + 2;


		new_tensor = tensorfactork_unflattening(standard_matrix, new_tensor_size, mod_k);
	end
end