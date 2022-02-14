function [linear_transform_matrix, diagonalized_matrix] = jacobi_diagonalization(hermitian_matrix)
	assert(norm(hermitian_matrix' - hermitian_matrix, 'fro') < 1e-6);

	row_col_num = size(hermitian_matrix, 1);

	linear_transform_matrix = eye(row_col_num);

	% The following line is for debugging
	% hermitian_matrix

	for i = 1: row_col_num
		for j = (i + 1): row_col_num
			if abs(hermitian_matrix(i, j)) < 1e-6
				continue;
			end

			tau = (hermitian_matrix(j, j) - hermitian_matrix(i, i)) / abs(2 * hermitian_matrix(i, j));
			tau = real(tau);

			t = sign(tau) / (abs(tau) + sqrt(1 + tau * tau));
			c = 1 / sqrt(1 + t * t);

			s = t * c * hermitian_matrix(i, j) / abs(hermitian_matrix(i, j));

			omega = [c, s; -conj(s), c];
			
			temp = hermitian_matrix;
			hermitian_matrix([i, j], [i, j]) = omega' * hermitian_matrix([i, j], [i, j]) * omega

			%--------------------
			linear_transform_matrix_this_iteration = eye(row_col_num);
			linear_transform_matrix_this_iteration([i, j], [i, j]) = omega;
			%linear_transform_matrix = linear_transform_matrix_this_iteration * linear_transform_matrix;

			temp = ctranspose(linear_transform_matrix_this_iteration) * temp * linear_transform_matrix_this_iteration

			%liaoliang = linear_transform_matrix_this_iteration' * liaoliang000 * linear_transform_matrix_this_iteration;

			assert(isequal(size(temp), size(hermitian_matrix)) );
			assert(norm(temp(:) - hermitian_matrix(:)) < 1e-6 ); 

			pause;


		end
	end


	%hermitian_matrix = linear_transform_matrix' * hermitian_matrix * linear_transform_matrix;

	if norm(real(hermitian_matrix) - hermitian_matrix, 'fro') < 1e-6
 		hermitian_matrix = real(hermitian_matrix);
 	end

 	diagonalized_matrix = hermitian_matrix;

end