function result = gsize(A, tsize)
	% This function generates MATLAB function size
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(A) - numel(tsize) >= 0);
	result = size(A);

	result(1: numel(tsize)) = [];

	if isempty(result)
		result = [1, 1]; 
	end

	if numel(result) == 1
		result = [result, 1]; 
	end

end