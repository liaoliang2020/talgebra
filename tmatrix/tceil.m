function result = tceil(tscalar)
	assert(is_self_conjugate(tscalar));
	result = ceil(real(fftn(tscalar))); 
	result = ifftn(result);
end