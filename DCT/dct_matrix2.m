function transform_matrix = dct_matrix2(N)
	assert(N > 1);
	assert(uint64(N) ==  N);

	matrix =  transpose(0: (N - 1)) * (1: 2: (2 * N - 1));
	matrix =  cos(pi / (2 * N) * matrix  );

	matrix2 = ones(N);
	matrix2(1, :) = 1 / sqrt(2);
	
	transform_matrix = (matrix .* matrix2) * sqrt(2 / N); 
end