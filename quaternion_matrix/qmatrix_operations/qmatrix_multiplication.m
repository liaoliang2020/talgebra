function result = qmatrix_multiplication(qmatrix1, qmatrix2)
	assert(isequal(class(qmatrix1), 'quaternion') ); 
	assert(numel(size(qmatrix1)) == 2 );

	assert(isequal(class(qmatrix2), 'quaternion') ); 
	assert(numel(size(qmatrix2)) == 2 );

	% the column number of the left qmatrix needs to be equal to 
	% the row number of the right qmatrix 
	assert(size(qmatrix1, 2) == size(qmatrix2, 1) );
		
	result = qmatrix2matrix(qmatrix1) * qmatrix2matrix(qmatrix2);
	result = matrix2qmatrix(result);

end