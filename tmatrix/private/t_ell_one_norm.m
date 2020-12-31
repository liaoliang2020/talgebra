function genneralized_ell_one_norm = t_ell_one_norm(tmatrix, tsize)
	% checked
	% created by liaoliang 2019-02-10
	% this is function computes the generalized ell_1 norn of a t-matrix, 
	% namely, the sum of the generalized absolute values of the t-scalar entries of 
	% a t-matrix 
	% fast version

	assert(isequal(tsize', tsize(:)));
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);
	
	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
	end

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	tmatrix = reshape(tmatrix, prod(tsize), []);

	genneralized_ell_one_norm = zeros(prod(tsize), 1);

	for i = 1: prod(tsize)
		% the following two line are okay but not efficient
		% slice_matrix = reshape(tmatrix(i, :), [row_num, col_num]);
		% genneralized_ell_one_norm(i) = sum(abs(slice_matrix(:)));

		% the following line is efficient 
		genneralized_ell_one_norm(i) = sum(abs(tmatrix(i, :)));		

	end

	genneralized_ell_one_norm = ifftn(reshape(genneralized_ell_one_norm, tsize));

end


% the following function is equivalent to the above function, but is not efficient
% this is a slow version of the implementation
% slow version
% function  genneralized_ell_one_norm = t_ell_one_norm(tmatrix, tsize)
% 	assert(isequal(tsize', tsize(:)));
% 	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);
	
% 	row_num = size(tmatrix, numel(tsize) + 1);
% 	col_num = size(tmatrix, numel(tsize) + 2);

% 	tmatrix = reshape(tmatrix, prod(tsize), prod([row_num, col_num]));
% 	genneralized_ell_one_norm = 0;
% 	for i = 1: prod([row_num, col_num])
% 		genneralized_ell_one_norm = genneralized_ell_one_norm + tabs(reshape(tmatrix(:, i), tsize)); 
% 	end

% end