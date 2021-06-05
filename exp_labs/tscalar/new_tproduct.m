function result = new_tproduct(tscalar01, tscalar02)
	% checked
	% this function compute the new product of two t-scalars
	assert(isequal(size(tscalar01), size(tscalar02)));

	tsize = size(tscalar01);
	ftsize = 2 * tsize; 

	[trans_matrix, pinv_trans_matrix] = get_transforms(tsize, ftsize);
	assert(ndims(tscalar01) == numel(trans_matrix) );

	order_N = ndims(tscalar01);
	for i = 1: order_N
		tscalar01 = tensormultiplication(trans_matrix{i}, tscalar01, i);
		tscalar02 = tensormultiplication(trans_matrix{i}, tscalar02, i);
	end

	result = tscalar01 .* tscalar02;

	for i = 1: order_N
		result = tensormultiplication(pinv_trans_matrix{i}, result, i);
	end


	if norm(imag(result(:))) < 1e-8
		result = real(result);
	end   


	
end