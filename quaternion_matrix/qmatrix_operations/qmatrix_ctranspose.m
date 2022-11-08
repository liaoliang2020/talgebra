function result = qmatrix_ctranspose(qmatrix)
	% this function is just equivalent the following matlab statement
	% result = qmatrix'; or 
	% result = ctranspose(qmatrix) 

	assert(isequal(class(qmatrix), 'quaternion') );
	assert(numel(size(qmatrix)) == 2);
	 
	result = conj(permute(qmatrix, [2 1]));

	% The above statement IS Equivalent to the following statement 
	% result = matrix2qmatrix(ctranspose(qmatrix2matrix(qmatrix)) );

end