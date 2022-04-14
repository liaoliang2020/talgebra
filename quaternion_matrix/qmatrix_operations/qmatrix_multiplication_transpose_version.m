 function result = qmatrix_multiplication_transpose_version(qmatrix1, qmatrix2)

 	assert(isequal(class(qmatrix1), 'quaternion') ); 
	assert(numel(size(qmatrix1)) == 2 );

	assert(isequal(class(qmatrix2), 'quaternion') ); 
	assert(numel(size(qmatrix2)) == 2 );

	% the column number of the left qmatrix needs to be equal to 
	% the row number of the right qmatrix 
	assert(size(qmatrix1, 2) == size(qmatrix2, 1) );

	result = qmatrix2matrix(transpose(qmatrix2) ) * qmatrix2matrix(transpose(qmatrix1) );	
	result = matrix2qmatrix(result);
	result = transpose(result);


	% result = transpose(qmatrix2matrix(qmatrix2))  * transpose(qmatrix2matrix(qmatrix1)) ;
	% result = matrix2qmatrix(transpose(result));
	

 end