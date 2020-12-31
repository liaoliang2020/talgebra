function result = tproduct(tscalar01, tscalar02)
	% checked
	% this function compute the product of two t-scalars
	assert(isequal(size(tscalar01), size(tscalar02)));
	result = ifftn(fftn(tscalar01) .* fftn(tscalar02));	
end