function result = qmatrix_inv(qmatrix)
	% this function computes the inverse of a square quaternion matrix 

	assert(isequal(class(qmatrix), 'quaternion') );
	assert(numel(size(qmatrix)) == 2);
	assert(size(qmatrix, 1) == size(qmatrix, 2));

	matrix = qmatrix2matrix(qmatrix);
	
	assert(min(size(matrix)) == rank(matrix));
	result = matrix2qmatrix(inv(matrix)); 

end