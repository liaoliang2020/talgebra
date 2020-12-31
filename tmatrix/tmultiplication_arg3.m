function tmatrix_result = tmultiplication_arg3(tmatrix1, tmatrix2, tmatrix3, tsize)

	assert(isequal(tsize', tsize(:)));	 	
	assert(ndims(tmatrix1) - numel(tsize) == 2 |  ndims(tmatrix1) - numel(tsize) == 1 | ndims(tmatrix1) - numel(tsize) == 0);
	assert(ndims(tmatrix2) - numel(tsize) == 2 |  ndims(tmatrix2) - numel(tsize) == 1 | ndims(tmatrix2) - numel(tsize) == 0);
	assert(ndims(tmatrix3) - numel(tsize) == 2 |  ndims(tmatrix3) - numel(tsize) == 1 | ndims(tmatrix3) - numel(tsize) == 0);

	tmatrix_result = tmultiplication(tmatrix1, tmatrix2, tsize);
	tmatrix_result = tmultiplication(tmatrix_result, tmatrix3, tsize);

end