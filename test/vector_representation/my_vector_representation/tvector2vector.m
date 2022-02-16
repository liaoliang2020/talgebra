function vector = tvector2vector(tvector, tsize) 
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tvector) - numel(tsize) == 2 | ndims(tvector) - numel(tsize) == 1| ndims(tvector) - numel(tsize) == 0); 

	gsize = size(tvector);
	assert(isequal(gsize(1: numel(tsize)), tsize) );
	
	K = prod(tsize);

	row_num = size(tvector, numel(tsize) + 1);
	col_num = size(tvector, numel(tsize) + 2);
	assert(col_num == 1);
	
	%using the old version transform
	matrix = tmatrix2matrix(tvector, tsize);
	assert(isequal(size(matrix), [row_num * K,  K] ));
	
	vector = zeros(row_num * K, 1);
	
	for i = 1: row_num
		row_index1 = (i - 1) * K + 1;
		row_index2 = row_index1 + K - 1;

		temp = matrix(row_index1: row_index2, :);
		assert(size(temp, 1) == size(temp, 2) );

		vector(row_index1: row_index2) = diag(temp);
	end%for i = 1: row_num
	
	
end