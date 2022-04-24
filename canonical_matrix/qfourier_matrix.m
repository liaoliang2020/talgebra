function qfourier_matrix_result = qfourier_matrix(n)
	% this function computes the nxn quaternionic Fourier matrix 
	assert(isscalar(n));
	assert(n > 0);
	
	qfourier_matrix_result = quaternionize(zeros(n, n));
    qfourier_matrix_result2 = quaternionize(zeros(n, n));	

	const = (-2 * pi / n) * (1 / sqrt(3)) * quaternion([0, 1, 1, 1]);
	const = repmat(const, n, n);
	
	row_vector = 0: (n - 1);
	qfourier_matrix_result = repmat(row_vector(:), 1, n) * diag(row_vector);
	qfourier_matrix_result = exp(const .* qfourier_matrix_result);

end