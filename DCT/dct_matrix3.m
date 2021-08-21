function transform_matrix = dct_matrix3(N)
	assert(N > 1);
	assert(uint64(N) ==  N);
	
	transform_matrix = dct_matrix2(N);
	transform_matrix = transform_matrix';
	 
end