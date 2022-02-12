function result = qmatrix_multiplication(qmatrix1, qmatrix2)
	assert(isequal(class(qmatrix1), 'quaternion') ); 
	assert(numel(size(qmatrix1)) == 2 );

	assert(isequal(class(qmatrix2), 'quaternion') ); 
	assert(numel(size(qmatrix2)) == 2 );
		
	result = qmatrix2matrix(qmatrix1) * qmatrix2matrix(qmatrix2);
	result = matrix2qmatrix(result);

end