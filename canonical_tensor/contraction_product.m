function result = contraction_product(tensor1, tensor2)
	% this function returns the contraction product of two tensors of doubles or quaternions

	assert(isequal(class(tensor1), class(tensor2)));
	assert(isequal(class(tensor1), 'double') | isequal(class(tensor1), 'quaternion'));

	size1 = size(tensor1);
	size2 = size(tensor2);

	assert(size1(end) == size2(1));

	switch class(tensor1)
		case 'double'
			result = reshape(tensor1, [], size1(end)) * reshape(tensor2, size2(1), []);			
		otherwise
			assert(isequal(class(tensor1), 'quaternion') );			
			result = qmatrix_multiplication(reshape(tensor1, [], size1(end)), reshape(tensor2, size2(1), []));			
	end

	size1(end) = [];
	size2(1)   = [];

	result = reshape(result, [size1, size2]);
	

end