function result = treshape(A, sz, tsize)
	% This function generates the MATLAB function "reshape"
	assert(isequal(sz', sz(:)));
	assert(isequal(tsize', tsize(:)));
	result = reshape(A, [tsize, sz]);
end