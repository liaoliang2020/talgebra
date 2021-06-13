function result_tensor = tensorouterproductor(tensor1, tensor2)
	% revised on 202010613
		
	assert(isnumeric(tensor1));
	assert(isnumeric(tensor2)); 


	%result_tensor = tensor1(:) * ctranspose(tensor2(:));
	result_tensor = tensor1(:) * transpose(tensor2(:));
	result_tensor = reshape(result_tensor, [size(tensor1), size(tensor2)]);

	result_tensor = squeeze(result_tensor);

end