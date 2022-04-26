function result = iqfourier_matrix(n, quaternionic_square_root_of_negative_one)
	% this function returns the nxn inverse quaternionic Fourier matrix

	assert(isscalar(n));
	assert(n > 0);

	if argin == 1
		quaternionic_square_root_of_negative_one = sqrt(-1);
	end

	assert(numel(quaternionic_square_root_of_negative_one) == 1);
	
	%--------------------
	switch class(quaternionic_square_root_of_negative_one)
		case 'double'
			assert(quaternionic_square_root_of_negative_one == sqrt(-1) );
			quaternionic_square_root_of_negative_one = quaternionize(quaternionic_square_root_of_negative_one);
		case 'quaternion'			
			% do nothing
		otherwise
			assert(false);
	end

	assert(norm(quaternionic_square_root_of_negative_one * quaternionic_square_root_of_negative_one - quaternionize(-1)) < 1e-8);

	result = qmatrix_inv(qfourier_matrix(n, quaternionic_square_root_of_negative_one));

end

