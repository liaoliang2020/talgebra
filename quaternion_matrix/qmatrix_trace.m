function result = qmatrix_trace(q_matrix)
	assert(isequal(class(q_matrix), 'quaternion'));
	assert(~isempty(q_matrix));
	assert(ndims(q_matrix) == 2);	
	assert(size(q_matrix, 1) == size(q_matrix, 2));

	result = quaternion(zeros(1, 4)); 
	for index = 1: size(q_matrix, 1)
		result = result + q_matrix(index, index); 		
	end%for index = 1: size(q_matrix, 1)

end