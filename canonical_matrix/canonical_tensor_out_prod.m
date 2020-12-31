function tensor_result = canonical_tensor_out_prod(tensor1, tensor2)

	assert(isnumeric(tensor1) & isnumeric(tensor2));
	
	
	%the following lines are efficient
	tensor_result = tensor1(:) * ctranspose(tensor2(:));
	tensor_result = reshape(tensor_result, [size(tensor1), size(tensor2)]);
	tensor_result = squeeze(tensor_result);
	
	
	

end