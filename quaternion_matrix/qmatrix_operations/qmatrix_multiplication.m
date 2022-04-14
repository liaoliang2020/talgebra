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

	%---------------------------------
	% the qmatrix "result" is identical to the qmatrix "result_another_version"
	% the following two lines might be removed in the future  
	%---------------------------------
	% result_another_version = matrix2qmatrix_another_version(qmatrix2matrix_another_version(qmatrix1) * qmatrix2matrix_another_version(qmatrix2) );
	% assert(norm(compact(result - result_another_version), 'fro') < 1e-6 );

end