function transformed_result = transform_matrix001(tarray, empty_vale, mod_index)
	assert(isempty(empty_vale));
	W = [0 1 0; 1 1 1; 0 1 0];

	% row_num = 6;
	% col_num = 3;
	% W = ones(row_num, col_num);

	% theta_angle = 2 * pi / row_num;

	% theta_angle_vector = (0: 5) * theta_angle;
	% theta_angle_vector = transpose(theta_angle_vector);

	% W(:, 2: end) = exp(i * [theta_angle_vector, -1 * theta_angle_vector]);


	% 	W =
	%   	1.0000 + 0.0000i   1.0000 + 0.0000i   1.0000 + 0.0000i
	%   	1.0000 + 0.0000i   0.5000 + 0.8660i   0.5000 - 0.8660i
	%   	1.0000 + 0.0000i  -0.5000 + 0.8660i  -0.5000 - 0.8660i
	%   	1.0000 + 0.0000i  -1.0000 + 0.0000i  -1.0000 - 0.0000i
	%   	1.0000 + 0.0000i  -0.5000 - 0.8660i  -0.5000 + 0.8660i
	%   	1.0000 + 0.0000i   0.5000 - 0.8660i   0.5000 + 0.8660i

	%W = W(1: 3, :);
	%W = fourier_matrix(3);

	transformed_result = tensormultiplication(W, tarray, mod_index);

end