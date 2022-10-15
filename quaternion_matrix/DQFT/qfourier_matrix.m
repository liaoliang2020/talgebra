function qfourier_matrix_result = qfourier_matrix(n, quaternionic_square_root_of_negative_one)
	% this function computes the nxn quaternionic Fourier matrix 
	assert(isscalar(n));
	assert(n > 0);

	%------------------------------
	if nargin == 1
		quaternionic_square_root_of_negative_one = quaternion([0 1 1 1] / norm([1 1 1]) );  

	end

	assert(numel(quaternionic_square_root_of_negative_one) == 1);
	
	%--------------------
	switch class(quaternionic_square_root_of_negative_one)
		case 'double'
			assert(quaternionic_square_root_of_negative_one == sqrt(-1) );
			quaternionic_square_root_of_negative_one = quaternionize(quaternionic_square_root_of_negative_one);
		case 'quaternion'			
			% do nothing
			;			
		otherwise
			assert(false);
	end

	assert(norm(quaternionic_square_root_of_negative_one * quaternionic_square_root_of_negative_one - quaternionize(-1)) < 1e-8);

	

	% const = (-2 * pi / n) * (1 / sqrt(3)) * quaternion([0, 1, 1, 1]);
	
	const = (-2 * pi / n) * quaternionic_square_root_of_negative_one; 
	const = repmat(const, n, n);
	
	row_vector = 0: (n - 1);
	qfourier_matrix_result = repmat(row_vector(:), 1, n) * diag(row_vector);
	qfourier_matrix_result = exp(const .* qfourier_matrix_result);


	% the following implementation is equivalent to the above code
	% however the above code is more efficient. 
	% the variable is a quaternionic square root of -1  
	% qfourier_matrix_result = quaternion([]);
	% mu = (1 / sqrt(3) * quaternion([0, 1, 1, 1]);
	% const  = -2 * pi * mu / n
	% for m1 = 1: n 
	% 	for m2 = 1: n 
	% 		liaoliang = const * (m1 - 1) * (m1 - 1);
	% 		qfourier_matrix_result(m1, m2) = exp(liaoliang);
	% 	end 
	% end


end