function result = canonical_matrix_spectral_norm(matrix)
 	% checked

 	assert(ismatrix(matrix));
 	[~, S, ~] = svd(matrix, 'econ');
 	
 	% the following works, but is not the most efficient 
 	% result = max(diag(S));

 	% this line is efficient
	result = S(1);


end