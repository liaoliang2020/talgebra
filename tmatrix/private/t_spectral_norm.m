function genneralized_norm = t_spectral_norm(tmatrix, tsize)
	assert(isequal(tsize', tsize(:)));
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
	end

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	tmatrix = reshape(tmatrix, prod(tsize), []);
	genneralized_norm = zeros(prod(tsize), 1);

	for i = 1: prod(tsize)
		slice = reshape(tmatrix(i, :), row_num, col_num);
		[~, S, ~] = svd(slice, 'econ');
		genneralized_norm(i) = S(1);
	end

	genneralized_norm = reshape(genneralized_norm, tsize);
	genneralized_norm = ifftn(genneralized_norm);


end