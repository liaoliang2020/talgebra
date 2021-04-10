function tensor_product = tensormultiplication(standard_matrix, tensor, mod_k)
	assert(ismatrix(standard_matrix));
	%assert(isnumeric(tensor) & ~ismatrix(tensor));
	assert(ismember(mod_k, 1: ndims(tensor) ));
	assert(size(standard_matrix, 2) == size(tensor, mod_k));
	
	order_num = ndims(tensor);
	tensor_size = size(tensor);
	tensor_size(mod_k) = size(standard_matrix, 1);
	
	tensor_product = standard_matrix * tensorfactorkflattening(tensor, mod_k);		

	pos = 1: order_num;
	pos(mod_k) = [];
	pos = [mod_k, pos];


	tensor_product = reshape(tensor_product, tensor_size(pos));

	p = get_pos(pos, 1: order_num);
	
	tensor_product = permute(tensor_product, p);



end

function p = get_pos(pos1, pos2)
	% assert(isequal(pos1', pos1(:)));
	% assert(isequal(pos2', pos2(:)));
	
	assert(isrow(pos1) & isrow(pos2));
	assert(isequal(sort(pos1), sort(pos2)));
	assert(isequal(sort(reshape(unique(pos1), 1, [])), sort(pos1)) );	
	
	p = zeros(1, numel(pos1));
	for i = 1: numel(pos2)
		p(i) = find(pos2(i) == pos1);				
	end
	assert(isequal(pos1(p), pos2));		
end