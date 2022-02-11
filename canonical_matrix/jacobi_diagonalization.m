function jacobi_diagonalization
	clear; close all; clc;

	A = randn(7) + sqrt(-1) * randn(7);
	B  = A + A'

	liaoliang = jacobi_diagonalization_sub(B)


end

function diagonalized_matrix = jacobi_diagonalization_sub(hermitian_matrix)
	assert(norm(hermitian_matrix' - hermitian_matrix, 'fro') < 1e-6);

	row_col_num = size(hermitian_matrix, 1);

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
			hermitian_matrix([i, j], [i, j]) = omega' * hermitian_matrix([i, j], [i, j]) * omega;

		end
	end

	if norm(real(hermitian_matrix) - hermitian_matrix, 'fro') < 1e-6
 		hermitian_matrix = real(hermitian_matrix);
 	end

 	diagonalized_matrix = hermitian_matrix;



end