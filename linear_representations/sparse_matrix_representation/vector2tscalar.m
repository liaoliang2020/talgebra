function result = vector2tscalar(vector, tsize)
	assert(size(vector, 2) == 1);
	result = matrix2tscalar(diag(vector), tsize);

	%----------------
	% the above statement IS equivalent to the following statement
	% result2 = ifftn(reshape(vector, tsize));  
	% assert(isequal(size(result), size(result2) ));
	% assert(norm(result(:) - result2(:)) < 1e-6); 
end