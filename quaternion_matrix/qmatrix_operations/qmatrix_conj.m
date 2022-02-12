function result = qmatrix_conj_sub(qmatrix)
	% this function returns conjugate of each quaternion entry of this array	

	assert(isequal(class(qmatrix), 'quaternion') );
	assert(numel(size(qmatrix)) == 2 );
	
	result = conj(qmatrix);	

	% The above statement is NOT equivalent to the following statement
	% result2 = matrix2qmatrix(conj(qmatrix2matrix(qmatrix) ));


end