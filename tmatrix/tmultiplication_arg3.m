function tmatrix_result = tmultiplication_arg3(tmatrix1, tmatrix2, tmatrix3, tsize)

	assert(isequal(tsize', tsize(:)));	 	
	assert(ndims(tmatrix1) - numel(tsize) == 2 |  ndims(tmatrix1) - numel(tsize) == 1 | ndims(tmatrix1) - numel(tsize) == 0);
	assert(ndims(tmatrix2) - numel(tsize) == 2 |  ndims(tmatrix2) - numel(tsize) == 1 | ndims(tmatrix2) - numel(tsize) == 0);
	assert(ndims(tmatrix3) - numel(tsize) == 2 |  ndims(tmatrix3) - numel(tsize) == 1 | ndims(tmatrix3) - numel(tsize) == 0);

	assert(isequal(size(tmatrix1), [tsize, size(tmatrix1, numel(tsize) + 1), size(tmatrix1, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix1), [tsize, size(tmatrix1, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix1), tsize) ...
	); 
	
	assert(isequal(size(tmatrix2), [tsize, size(tmatrix2, numel(tsize) + 1), size(tmatrix2, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix2), [tsize, size(tmatrix2, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix2), tsize) ...
	);

	assert(isequal(size(tmatrix3), [tsize, size(tmatrix3, numel(tsize) + 1), size(tmatrix3, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix3), [tsize, size(tmatrix3, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix3), tsize) ...
	); 
	 
	


	tmatrix_result = tmultiplication(tmatrix1, tmatrix2, tsize);
	tmatrix_result = tmultiplication(tmatrix_result, tmatrix3, tsize);

end