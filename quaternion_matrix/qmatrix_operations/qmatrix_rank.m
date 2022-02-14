function result = qmatrix_rank(qmatrix)
	% this function computes the rank of a quaternion matrix

	assert(isequal(class(qmatrix), 'quaternion') );
	assert(numel(size(qmatrix)) == 2);

	matrix = qmatrix2matrix(qmatrix);
	result = rank(matrix);
	assert(mod(result, 2) == 0);

	result = result / 2;

end