function qfourier_matrix_result = qfourier_matrix(n)
	% this function computes the nxn Fourier matrix 
	assert(isscalar(n));
	assert(n > 0);
	
	qfourier_matrix_result = quaternionize(zeros(n, n));
    
	const = (-2 * pi / n) *  quaternion([0, 1, 1, 1]);
	for i = 1: n
		for j = 1: n
			liaoliang = const * (i - 1) * (j - 1);			
			qfourier_matrix_result(i, j) = exp(liaoliang);			
		end
	end
	
end