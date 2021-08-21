function transform_matrix = dct_matrix4(N)
	assert(N > 1);
	assert(uint64(N) ==  N);
	
	matrix = transpose(1:2:(2*N - 1)) * (1:2:(2*N - 1)); 
	matrix = cos(pi / (4*N) * matrix);
	transform_matrix = matrix * sqrt(2 / N);
end