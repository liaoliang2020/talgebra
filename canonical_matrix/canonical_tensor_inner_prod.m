function scalar_result = canonical_tensor_inner_prod(tensor1, tensor2)

	
	%this function computes the canonical inner produt of two tensors. 
	
	
	
	assert(isnumeric(tensor1) & isnumeric(tensor2));
	assert(isequal(size(tensor1), size(tensor2)));

	% this following line works, but is not the most efficient.
	% scalar_result = sum(dot(reshape(tensor1, size(tensor1, 1), []), reshape(tensor2, size(tensor2, 1), [])));  
	
	% This line is very efficient
	scalar_result = ctranspose(tensor1(:)) * tensor2(:); 
	
	
end