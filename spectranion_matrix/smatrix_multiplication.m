function smatrix_result = smatrix_multiplication(smatrix1, smatrix2, tsize, unit_quaternionic_square_roots)

	assert(isequal(class(smatrix1), 'quaternion'));
	assert(isequal(class(smatrix2), 'quaternion'));


	assert(isequal(tsize', tsize(:)));	 	
	
	assert(ndims(smatrix1) - numel(tsize) == 2 |  ndims(smatrix1) - numel(tsize) == 1 | ndims(smatrix1) - numel(tsize) == 0);
	assert(ndims(smatrix2) - numel(tsize) == 2 |  ndims(smatrix2) - numel(tsize) == 1 | ndims(smatrix2) - numel(tsize) == 0);

	if nargin == 3
		unit_quaternionic_square_roots = quaternionize(i);		
	end

	assert(isequal(class(unit_quaternionic_square_roots), 'quaternion' ));
	assert(size(unit_quaternionic_square_roots, 1) == 1);

	assert(norm(compact(unit_quaternionic_square_roots .* unit_quaternionic_square_roots ...
		-  quaternionize((-1) * ones(size(unit_quaternionic_square_roots)))), 'fro') < 1e-8); 

	
			
		
	row_num1 = size(smatrix1, numel(tsize) + 1);
	col_num1 = size(smatrix1, numel(tsize) + 2);


	row_num2 = size(smatrix2, numel(tsize) + 1);
	col_num2 = size(smatrix2, numel(tsize) + 2);

	assert(col_num1 == row_num2);

	% comput the multi-way quaternionic fourier transform 
	for mode_index = 1: numel(tsize)
		smatrix1 = ffts(smatrix1, [], mode_index, negative_one_square_root_type);
		smatrix2 = ffts(smatrix2, [], mode_index, negative_one_square_root_type);	
	end

	smatrix1 = reshape(smatrix1, prod(tsize), row_num1,  col_num1);
	smatrix2 = reshape(smatrix2, prod(tsize), row_num2,  col_num2);


	for slice_index = 1: prod(tsize)
		slice_smatrix1 = smatrix1(slice_index, :, :);
		slice_smatrix2 = smatrix2(slice_index, :, :);

		slice_smatrix1 = reshape(slice_smatrix1, row_num1, col_num1);
		slice_smatrix2 = reshape(slice_smatrix2, row_num2, col_num2);

		% the following line is to compute the product of two q-matrices
		result = qmatrix_multiplication(slice_smatrix1, slice_smatrix2);

		
		if slice_index == 1
			smatrix_result = zeros([prod(tsize), size(result) ] );
			smatrix_result = quaternionize(smatrix_result);
		end

		smatrix_result(slice_index, :, :) = result;
	
	end%for slice_index = 1: prod(tsize)


	smatrix_result = reshape(smatrix_result, [tsize, size(smatrix_result, 2), size(smatrix_result, 3)]);


	% compute the inverse quaternionic fourier transform
	for mode_index = 1: numel(tsize)
		smatrix_result = iffts(smatrix_result, [], mode_index, negative_one_square_root_type, unit_quaternionic_square_roots);		
	end
	
	
end