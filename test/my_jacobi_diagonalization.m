function my_jacobi_diagonalization
	while true
		my_jacobi_diagonalization_sub;
	end

end


function my_jacobi_diagonalization_sub
	%clear; close all; clc;
	
	disp('my_jacobi_diagonalization');

	row_col_num = 5;
	A = randn(row_col_num);
	B = A * A';
	assert(isreal(B));
	assert(norm(B' - B, 'fro') < 1e-6);
	 	
	
	C = B;

	linear_transmation = eye(row_col_num);
	
	is_terminated = false;
	while true
		if is_terminated
			break;
		end

		for i = 1: (row_col_num - 1)
			if is_terminated
				break;
			end

			for j = (i + 1): row_col_num
				
				
				% if abs(C(i, j)) < 1e-6
				% 	continue;
				% end

				tau = (C(j, j) - C(i, i)) / (2 * C(i, j));
				tau = real(tau);

				t = sign(tau) / (abs(tau) + sqrt(tau * tau + 1) );
				c = 1 / (t * t + 1);
				s = c * t;

				omega = [c s; -s c];

				liaoliang = c * c + s * s
				% ss = omega' * omega 
				pause;


				%C([i, j], [i, j]) = omega' * C([i, j], [i, j]) * omega;
				
				linear_transform_this_iteration = eye(row_col_num);
				linear_transform_this_iteration([i, j], [i, j]) = omega;
				
				C = linear_transform_this_iteration' * C * linear_transform_this_iteration;

				linear_transmation = linear_transmation * linear_transform_this_iteration; 
 
				
				if norm(diag(diag(C)) - C, 'fro') < 1e-6
					is_terminated = true; 
					break;
					
				end%if norm(diag(diag(C)) - C, 'fro') < 1e-6 
				
			end%for j = (i + 1): row_col_num
		
		end%for i = 1: row_col_num

	end%while true

	S = linear_transmation' * B * linear_transmation

	assert(isequal(size(C), size(S) ));
	assert(norm(C(:) - S(:) ) < 1e-6);

	U = inv(linear_transmation');
	U' * U
	pause;	 



end


%--------------------------
% function [linear_transform_matrix, diagonalized_matrix] = my_jacobi_diagonalization_sub(hermitian_matrix)
% 	assert(norm(hermitian_matrix' - hermitian_matrix, 'fro') < 1e-6);

% 	row_col_num = size(hermitian_matrix, 1);

% 	linear_transform_matrix = eye(row_col_num);

	

% 	for i = 1: row_col_num
% 		for j = (i + 1): row_col_num
% 			if abs(hermitian_matrix(i, j)) < 1e-6
% 				continue;
% 			end

% 			tau = (hermitian_matrix(j, j) - hermitian_matrix(i, i)) / abs(2 * hermitian_matrix(i, j));
% 			tau = real(tau);

% 			t = sign(tau) / (abs(tau) + sqrt(1 + tau * tau));
% 			c = 1 / sqrt(1 + t * t);

% 			s = t * c * hermitian_matrix(i, j) / abs(hermitian_matrix(i, j));

% 			omega = [c, s; -conj(s), c];
			
% 			temp = hermitian_matrix;
% 			hermitian_matrix([i, j], [i, j]) = omega' * hermitian_matrix([i, j], [i, j]) * omega

% 			%--------------------
% 			linear_transform_matrix_this_iteration = eye(row_col_num);
% 			linear_transform_matrix_this_iteration([i, j], [i, j]) = omega;
% 			%linear_transform_matrix = linear_transform_matrix_this_iteration * linear_transform_matrix;

% 			temp = ctranspose(linear_transform_matrix_this_iteration) * temp * linear_transform_matrix_this_iteration

% 			%liaoliang = linear_transform_matrix_this_iteration' * liaoliang000 * linear_transform_matrix_this_iteration;

% 			assert(isequal(size(temp), size(hermitian_matrix)) );
% 			assert(norm(temp(:) - hermitian_matrix(:)) < 1e-6 ); 

% 			pause;


% 		end
% 	end


% 	%hermitian_matrix = linear_transform_matrix' * hermitian_matrix * linear_transform_matrix;

% 	if norm(real(hermitian_matrix) - hermitian_matrix, 'fro') < 1e-6
%  		hermitian_matrix = real(hermitian_matrix);
%  	end

%  	diagonalized_matrix = hermitian_matrix;

% end