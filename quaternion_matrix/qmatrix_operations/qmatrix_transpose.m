function result = qmatrix_transpose_sub(qmatrix)
	% this function resturns the simple tranpsoe of a qmatrix

	assert(isequal(class(qmatrix), 'quaternion') ); 
	assert(numel(size(qmatrix)) == 2 );
	
	result = permute(qmatrix, [2 1]);

	% note the above statement is NOT equivalent to the following statement.   
	% result2 = matrix2qmatrix(transpose(qmatrix2matrix(qmatrix) ));

end