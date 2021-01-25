function result = tfloor(tscalar)
	assert(is_self_conjugate(tscalar));
	result = floor(real(fftn(tscalar))); 
	result = ifftn(result);
end