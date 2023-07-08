function transform_matrix = dct_matrix1(N)
	
 	assert(N > 1);
	assert(uint64(N) ==  N);

	matrix =  transpose(0: (N - 1)) * (0: (N - 1));
	matrix =  cos(pi / (N - 1) * matrix  );

	matrix2 = ones(N);
	matrix2(:, [1, N]) = 1 / sqrt(2);
	matrix2 = matrix2' .* matrix2;
	transform_matrix = (matrix .* matrix2) * sqrt(2 / (N - 1)); 
end
