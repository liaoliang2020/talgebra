function gtensor = gtensor_folding(tmatrix, gsize, mod_k, tsize)
	% this function is the inverse functio of FUNCTION gtensor_unfolding
	assert(isequal(tsize', tsize(:)));	 
	assert(isequal(gsize', gsize(:)));
	assert(ismember(mod_k, 1: ndims(gsize) ) ); 
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, ndims(tsize) + 1);
	col_num = size(tmatrix, ndims(tsize) + 2);
	
	for i = 1: ndims(tsize)
		tmatrix = fft(tmatrix, [], i);
	end
	
	tmatrix = reshape(tmatrix, prod(tsize), []);

	gtensor = [];
	for i = 1: prod(tsize)
		standard_matrix = reshape(tmatrix(i, :), row_num, col_num);
		tensor = tensorfactork_unflattening(standard_matrix, gsize, mod_k);

		if i == 1
			gtensor = zeros(prod(tsize), numel(tensor) );
		end	
		gtensor(i, :) = reshape(tensor, 1, []);
	end

	gtensor = reshape(gtensor, [tsize, gsize]);

	for i = 1: numel(tsize)
		gtensor = ifft(gtensor, [], i);
	end
end