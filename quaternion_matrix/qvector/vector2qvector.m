function qvector = vector2qvector(vector)
	assert(numel(size(vector)) == 2 );
	assert(size(vector, 2) == 1);	
	assert(mod(size(vector, 1), 2) == 0);
	 
	row_num = size(vector, 1) / 2;

	vector1 = vector(1: row_num, :);
	vector2 = vector((row_num + 1): end, :);
	vector2 = conj(-1 * vector2); 

	qvector = quaternion([real(vector1), imag(vector1), real(vector2), imag(vector2)] );

end