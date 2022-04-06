function qtensor_product = qtensormultiplication(qmatrix, qtensor, mod_k)

	assert(isequal(class(qmatrix), 'quaternion') );
	assert(isequal(class(qtensor), 'quaternion') );
	
	assert(ndims(qmatrix) == 2);
	assert(ismember(mod_k, 1: ndims(qtensor) ));
	assert(size(qmatrix, 2) == size(qtensor, mod_k));


	order_num = ndims(qtensor);
	tensor_size = size(qtensor);
	tensor_size(mod_k) = size(qmatrix, 1);

	qtensor_product = qmatrix_multiplication(qmatrix, tensorfactorkflattening(qtensor, mod_k));

	pos = 1: order_num;
	pos(mod_k) = [];
	pos = [mod_k, pos];

	qtensor_product = reshape(qtensor_product, tensor_size(pos));

	p = get_pos(pos, 1: order_num);

	qtensor_product = permute(qtensor_product, p);

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