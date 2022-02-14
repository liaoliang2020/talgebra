function result = qmatrix_pinv(qmatrix)
	% this function computes the inverse of a square quaternion matrix 
	assert(isequal(class(qmatrix), 'quaternion') );
	assert(numel(size(qmatrix)) == 2);

	matrix = qmatrix2matrix(qmatrix);
	result = matrix2qmatrix(pinv(matrix)); 

end