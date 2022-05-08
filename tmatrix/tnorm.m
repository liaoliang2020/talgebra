function generalized_norm = tnorm(tmatrix, tsize, norm_type, p_value)
	% created by liaoliang 20190121
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	assert(isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1), size(tmatrix, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix), tsize) ...
	); 
	

	if nargin == 2
		norm_type = 'fro';
	end

	% assert(isequal(norm_type, 'fro') | isequal(norm_type, 'ell_one'));

	switch norm_type
	 	case 'p'
			generalized_norm = t_p_norm(tmatrix, tsize, p_value);
		case 'max'
			generalized_norm = t_max_norm(tmatrix, tsize);
		case 'fro'
	 		generalized_norm = t_fro_norm(tmatrix, tsize);
	 	case 'ell_one'
	 		generalized_norm = t_ell_one_norm(tmatrix, tsize);
	 	case 'spectral'
	 		generalized_norm = t_spectral_norm(tmatrix, tsize);
	 	case 'nuclear'
	 		generalized_norm = t_nuclear_norm(tmatrix, tsize);
	 	otherwise
	 		assert(false);
	 end 



end