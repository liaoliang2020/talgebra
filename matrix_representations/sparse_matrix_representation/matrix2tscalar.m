function tscalar = matrix2tscalar(matrix, tsize)
	assert(size(matrix, 1) == size(matrix, 2));
	assert(norm(diag(diag(matrix)) - matrix, 'fro') < 1e-8 );

	tscalar = reshape(diag(matrix), tsize); 
	tscalar = ifftn(tscalar); 

end