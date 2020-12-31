function genneralized_p_norm = t_p_norm(tmatrix, tsize, p_value)
	% created by liaoliang 2018-12-03
	% improved by liaoliang 2019-02-10
	% this function computes the generalized p norm of a t-matrix
	% fast version 


	assert(isequal(tsize', tsize(:)));
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);
	
	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
	end

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	tmatrix = reshape(tmatrix, prod(tsize), []);

	genneralized_p_norm = zeros(prod(tsize), 1);
	for i = 1: prod(tsize)
		
		% the following line is more efficient 
		genneralized_p_norm(i) =  canonical_norm(tmatrix(i, :), 'p', p_value);				

	end

	genneralized_p_norm = ifftn(reshape(genneralized_p_norm, tsize)); 

end

