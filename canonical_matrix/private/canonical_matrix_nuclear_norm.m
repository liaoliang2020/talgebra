 function result = canonical_matrix_nuclear_norm(matrix)
 	assert(ismatrix(matrix));

 	[~, S, ~] = svd(matrix, 'econ');
 	result = trace(S);

 end