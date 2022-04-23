function smatrix_result = smatrix_multiplication(smatrix1, smatrix2, tsize)

	assert(isequal(class(smatrix1), 'quaternion'));
	assert(isequal(class(smatrix2), 'quaternion'));


	assert(isequal(tsize', tsize(:)));	 	
	
	assert(ndims(smatrix1) - numel(tsize) == 2 |  ndims(smatrix1) - numel(tsize) == 1 | ndims(smatrix1) - numel(tsize) == 0);
	assert(ndims(smatrix2) - numel(tsize) == 2 |  ndims(smatrix2) - numel(tsize) == 1 | ndims(smatrix2) - numel(tsize) == 0);

			
		
	row_num1 = size(smatrix1, numel(tsize) + 1);
	col_num1 = size(smatrix1, numel(tsize) + 2);


	row_num2 = size(smatrix2, numel(tsize) + 1);
	col_num2 = size(smatrix2, numel(tsize) + 2);

	assert(col_num1 == row_num2);

	for i = 1: numel(tsize)
		smatrix1 = ffts(smatrix1, [], i);
		smatrix2 = ffts(smatrix2, [], i);	
	end

	smatrix1 = reshape(smatrix1, prod(tsize), row_num1,  col_num1);
	smatrix2 = reshape(smatrix2, prod(tsize), row_num2,  col_num2);


	for i = 1: prod(tsize)
		slice_smatrix1 = smatrix1(i, :, :);
		slice_smatrix2 = smatrix2(i, :, :);

		slice_smatrix1 = reshape(slice_smatrix1, row_num1, col_num1);
		slice_smatrix2 = reshape(slice_smatrix2, row_num2, col_num2);

		% the following is to compute the product of two q-matrices
		result = qmatrix_multiplication(slice_smatrix1, slice_smatrix2);

		
		if i == 1
			smatrix_result = zeros([prod(tsize), size(result) ] );
			smatrix_result = quaternionize(smatrix_result);
		end

		smatrix_result(i, :, :) = result;
	
	end%for i = 1: prod(tsize)


	smatrix_result = reshape(smatrix_result, [tsize, size(smatrix_result, 2), size(smatrix_result, 3)]);


	for i = 1: numel(tsize)
		smatrix_results = iffts(smatrix_result, [], i);		
	end
	
	
end