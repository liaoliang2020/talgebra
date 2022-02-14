function result = qmatrix_multiplication_arg3(qmatrix1, qmatrix2, qmatrix3)
	assert(isequal(class(qmatrix1), 'quaternion') ); 
	assert(numel(size(qmatrix1)) == 2 );

	assert(isequal(class(qmatrix2), 'quaternion') ); 
	assert(numel(size(qmatrix2)) == 2 );

	assert(isequal(class(qmatrix3), 'quaternion') ); 
	assert(numel(size(qmatrix3)) == 2 );
		
	result = qmatrix2matrix(qmatrix1) * qmatrix2matrix(qmatrix2) * qmatrix2matrix(qmatrix3);
	result = matrix2qmatrix(result);

end