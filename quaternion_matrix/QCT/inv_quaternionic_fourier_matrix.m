function qmatrix = inv_quaternionic_fourier_matrix(n, unit_quaternionic_square_roots)
	assert(isscalar(n));
	assert(n > 0);

	assert(isequal(class(unit_quaternionic_square_roots), 'quaternion' ));
	assert(size(unit_quaternionic_square_roots, 1) == 1);

	assert(norm(compact(unit_quaternionic_square_roots .* unit_quaternionic_square_roots ...
		-  quaternionize((-1) * ones(size(unit_quaternionic_square_roots)))), 'fro') < 1e-8); 

	qmatrix = qmatrix_inv(quaternionic_fourier_matrix(n, unit_quaternionic_square_roots) );

	
end