function smatrix_result = smatrix_multiplication_arg3(smatrix1, smatrix2, smatrix3, tsize, unit_quaternionic_square_roots)	

	assert(isequal(class(smatrix1), 'quaternion'));
	assert(isequal(class(smatrix2), 'quaternion'));
	assert(isequal(class(smatrix3), 'quaternion'));
	

	assert(isequal(tsize', tsize(:)));	 	
	assert(ndims(smatrix1) - numel(tsize) == 2 |  ndims(smatrix1) - numel(tsize) == 1 | ndims(smatrix1) - numel(tsize) == 0);
	assert(ndims(smatrix2) - numel(tsize) == 2 |  ndims(smatrix2) - numel(tsize) == 1 | ndims(smatrix2) - numel(tsize) == 0);
	assert(ndims(smatrix3) - numel(tsize) == 2 |  ndims(smatrix3) - numel(tsize) == 1 | ndims(smatrix3) - numel(tsize) == 0);

	if nargin == 4
		unit_quaternionic_square_roots = quaternionize(i);		
	end

	assert(isequal(class(unit_quaternionic_square_roots), 'quaternion' ));
	assert(size(unit_quaternionic_square_roots, 1) == 1);

	assert(norm(compact(unit_quaternionic_square_roots .* unit_quaternionic_square_roots ...
		-  quaternionize((-1) * ones(size(unit_quaternionic_square_roots)))), 'fro') < 1e-8); 



	%-----------
	row_num1 = size(smatrix1, numel(tsize) + 1);
	col_num1 = size(smatrix1, numel(tsize) + 2);

	row_num2 = size(smatrix2, numel(tsize) + 1);
	col_num2 = size(smatrix2, numel(tsize) + 2);

	row_num3 = size(smatrix3, numel(tsize) + 1);
	col_num3 = size(smatrix3, numel(tsize) + 2);

	assert(col_num1 == row_num2);
	assert(col_num2 == row_num3);
	
	smatrix_result = smatrix_multiplication(smatrix1, smatrix2, tsize, unit_quaternionic_square_roots);
	smatrix_result = smatrix_multiplication(smatrix_result, smatrix3, tsize, unit_quaternionic_square_roots);

end