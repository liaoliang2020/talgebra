function transform_matrix = dst_matrix(N)
	assert(N > 1);
	assert(uint64(N) ==  N);

	matrix = transpose(1: N) * (1: N);
	transform_matrix = sin(matrix * pi  / (N + 1));
 
end