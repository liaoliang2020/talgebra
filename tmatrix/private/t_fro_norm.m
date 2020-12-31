function genneralized_Frobenius_norm = t_fro_norm(tmatrix, tsize)
	% created by liaoliang 2018-12-03
	% improved by liaoliang 2019-02-10
	% this function computes the generalized Frobenius norm of a t-matrix
	% fast version 


	assert(isequal(tsize', tsize(:)));
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);
	
	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
	end

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	tmatrix = reshape(tmatrix, prod(tsize), []);

	genneralized_Frobenius_norm = zeros(prod(tsize), 1);
	for i = 1: prod(tsize)
		% the following two lines are okay, but are not efficient.
		% slice_matrix = reshape(tmatrix(i, :), [row_num, col_num]);
		% genneralized_Frobenius_norm(i) = norm(slice_matrix(:));

		% the following line is more efficient 
		genneralized_Frobenius_norm(i) = norm(tmatrix(i, :));


	end

	genneralized_Frobenius_norm = ifftn(reshape(genneralized_Frobenius_norm, tsize)); 

end

% the following function is equivalent to the above function  
% function genneralized_Frobenius_norm = tFroNorm_proc(tmatrix, tsize)
% 	% another imlmentation for computing generalized Frobenius norm of a t-matrix
% 	% slow version
% 	assert(isequal(tsize', tsize(:)));
% 	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);
% 	genneralized_Frobenius_norm = tsqrt(ttrace(tmultiplication(tctranspose(tmatrix, tsize), tmatrix, tsize), tsize));
% end