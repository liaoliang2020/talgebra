function tvector = vector2tvector(vector, tsize)
	assert(isequal(tsize', tsize(:)));	 
	assert(numel(size(vector)) == 2);
	assert(size(vector, 2) == 1);
		
	K = prod(tsize); 
	assert(mod(size(vector, 1), K) == 0); 

	row_num = size(vector, 1) / K;
	matrix = zeros(K * row_num, K);

	for i = 1: row_num
		row_index1 = (i - 1) *  K + 1;
		row_index2 = row_index1 + K -1;

		temp = vector(row_index1: row_index2);
		temp = diag(temp);

		matrix(row_index1: row_index2, :) = temp; 

	end

	tvector = matrix2tmatrix(matrix, tsize); 
	assert(size(tvector, numel(tsize) + 2) == 1 ); 

end