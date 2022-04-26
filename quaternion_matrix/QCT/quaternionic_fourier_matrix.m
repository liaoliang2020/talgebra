function qmatrix = quaternionic_fourier_matrix(n, unit_quaternionic_square_roots)
	assert(isscalar(n));
	assert(n > 0);

	assert(isequal(class(unit_quaternionic_square_roots), 'quaternion' ));
	assert(size(unit_quaternionic_square_roots, 1) == 1);

	assert(norm(compact(unit_quaternionic_square_roots .* unit_quaternionic_square_roots ...
		-  quaternionize((-1) * ones(size(unit_quaternionic_square_roots)))), 'fro') < 1e-8); 

	index = 0;
	for square_root = unit_quaternionic_square_roots
		index = index + 1;

		if index == 1
			qmatrix = qfourier_matrix(n, square_root); 
		else
			qmatrix = qmatrix_multiplication(qfourier_matrix(n, square_root), qmatrix); 			 
		end 

	end%for square_root = unit_quaternionic_square_roots

end