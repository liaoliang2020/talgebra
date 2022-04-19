function result = qmatrix_multiplication_arg3_version2(qmatrix1, qmatrix2, qmatrix3)
	assert(isequal(class(qmatrix1), 'quaternion') ); 
	assert(numel(size(qmatrix1)) == 2 );

	assert(isequal(class(qmatrix2), 'quaternion') ); 
	assert(numel(size(qmatrix2)) == 2 );

	assert(isequal(class(qmatrix3), 'quaternion') ); 
	assert(numel(size(qmatrix3)) == 2 );
		
	%result = qmatrix2matrix(qmatrix1) * qmatrix2matrix(qmatrix2) * qmatrix2matrix(qmatrix3);
	%result = matrix2qmatrix(result);

	result = qmatrix_multiplication_transpose_version(qmatrix1, qmatrix2);
	result = qmatrix_multiplication_transpose_version(result, qmatrix3);

	
	%the following three lines ensure that the qmatrix multiplication is associate. 
	%the following three lines may be removed in the future. 
	result2 = qmatrix_multiplication_transpose_version(qmatrix2, qmatrix3);
	result2 = qmatrix_multiplication_transpose_version(qmatrix1, result2);
	assert(norm(compact(result - result2), 'fro') < 1e-6 );
	
	
	
end