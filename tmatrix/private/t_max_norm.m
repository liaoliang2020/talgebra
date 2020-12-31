function genneralized_max_norm = t_max_norm(tmatrix, tsize)
	% created by liaoliang 2018-12-03
	% improved by liaoliang 2019-02-10
	% this function computes the generalized max norm of a t-matrix
	% fast version 


	assert(isequal(tsize', tsize(:)));
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);
	
	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
	end

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	tmatrix = reshape(tmatrix, prod(tsize), []);

	genneralized_max_norm = zeros(prod(tsize), 1);
	for i = 1: prod(tsize)
		

		% the following line is more efficient 
		genneralized_max_norm(i) = sum(abs(tmatrix(i, :)));


	end

	genneralized_max_norm = ifftn(reshape(genneralized_max_norm, tsize)); 

end

