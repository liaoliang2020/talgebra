function vetor = qvector2vector(qvector)
	% this function returns the vector representation of a quaternion vector

	assert(isequal(class(qvector), 'quaternion') );
	assert(numel(size(qvector)) == 2 );   
	assert(size(qvector, 2) == 1 );

	vetor = qmatrix2matrix(qvector);
	vetor = vetor(:, 1); 

end