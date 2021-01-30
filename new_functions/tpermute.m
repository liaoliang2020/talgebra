function B = tpermute(A, order, tsize)
	assert(isequal(tsize', tsize(:)));
	assert(isequal(order', order(:)));	
	
	assert(ndims(A) ==  numel([tsize, order]) );

	B = permute(A, [1: numel(tsize), order + numel(tsize)]);

	
end