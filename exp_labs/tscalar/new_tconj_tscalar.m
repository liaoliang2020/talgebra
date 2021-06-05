function conj_tscalar = new_tconj_tscalar(tscalar)
	% checked
	% this function compute the conjugate of a tscalar

	tsize = size(tscalar);
	ftsize = 88 * tsize; 

	[trans_matrix, pinv_trans_matrix] = get_transforms(tsize, ftsize);
	assert(ndims(tscalar) == numel(trans_matrix) );

	order_N = ndims(tscalar);
	for i = 1: order_N
		tscalar = tensormultiplication(trans_matrix{i}, tscalar, i);		
	end

	conj_tscalar = conj(tscalar);

	for i = 1: order_N
		conj_tscalar = tensormultiplication(pinv_trans_matrix{i}, conj_tscalar, i);
	end

	if norm(imag(conj_tscalar(:))) < 1e-8
		conj_tscalar = real(conj_tscalar);
	end   

	
end