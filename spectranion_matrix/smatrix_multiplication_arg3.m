function smatrix_result = smatrix_multiplication_arg3(smatrix1, smatrix2, smatrix3, tsize)

	assert(isequal(tsize', tsize(:)));	 	
	assert(ndims(smatrix1) - numel(tsize) == 2 |  ndims(smatrix1) - numel(tsize) == 1 | ndims(smatrix1) - numel(tsize) == 0);
	assert(ndims(smatrix2) - numel(tsize) == 2 |  ndims(smatrix2) - numel(tsize) == 1 | ndims(smatrix2) - numel(tsize) == 0);
	assert(ndims(smatrix3) - numel(tsize) == 2 |  ndims(smatrix3) - numel(tsize) == 1 | ndims(smatrix3) - numel(tsize) == 0);

	smatrix_result = smatrix_multiplication(smatrix1, smatrix2, tsize);
	smatrix_result = smatrix_multiplication(smatrix_result, smatrix3, tsize);


	


end