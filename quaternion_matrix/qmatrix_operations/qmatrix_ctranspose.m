function result = qmatrix_ctranspose(qmatrix)
	assert(isequal(class(qmatrix), 'quaternion') );
	assert(numel(size(qmatrix)) == 2);
	 
	result = conj(permute(qmatrix, [2 1]));

	% The above statement is equivalent to the following statement 
	% result = matrix2qmatrix(ctranspose(qmatrix2matrix(qmatrix)) )

end