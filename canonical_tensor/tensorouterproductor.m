function result_tensor = tensorouterproductor_sub(tensor1, tensor2)
	
	assert(isnumeric(tensor1));
	assert(isnumeric(tensor2)); 


	result_tensor = tensor1(:) * ctranspose(tensor2(:));
	result_tensor = reshape(result_tensor, [size(tensor1), size(tensor2)]);

end