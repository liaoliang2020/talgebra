function canonical_norm_value = canonical_norm(matrix, norm_type, p_value)
	% this function computes different types of norm
	if nargin == 1
		norm_type = 'fro';
	end

	%if nargin == 3
	%	p_value = uint16(p_value);
	%end

	
	
	assert(isnumeric(matrix) & ischar(norm_type));

	switch norm_type
		case 'p'
			%assert(isinteger(p_value)); 
			assert(p_value > 0);			
			%p_value = double(p_value);
			canonical_norm_value = power(sum(power(abs(matrix(:)), p_value)), (1 / p_value));			
		case 'max'
			canonical_norm_value = max(abs(matrix(:)));
		case 'fro'
			canonical_norm_value = norm(matrix, 'fro');
		case 'ell_one'
			canonical_norm_value = sum(abs(matrix(:)));
		case 'spectral'
			canonical_norm_value = canonical_matrix_spectral_norm(matrix);
		case 'nuclear'
			canonical_norm_value = canonical_matrix_nuclear_norm(matrix);
		otherwise
			assert(false);
	end
end