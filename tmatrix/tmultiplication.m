function tmatrix_result = tmultiplication(tmatrix1, tmatrix2, tsize)
	
	% checked
	% checked

	
	assert(isequal(tsize', tsize(:)));	 	
	
	assert(ndims(tmatrix1) - numel(tsize) == 2 |  ndims(tmatrix1) - numel(tsize) == 1 | ndims(tmatrix1) - numel(tsize) == 0);
	assert(ndims(tmatrix2) - numel(tsize) == 2 |  ndims(tmatrix2) - numel(tsize) == 1 | ndims(tmatrix2) - numel(tsize) == 0);

			
		
	row_num1 = size(tmatrix1, numel(tsize) + 1);
	col_num1 = size(tmatrix1, numel(tsize) + 2);


	row_num2 = size(tmatrix2, numel(tsize) + 1);
	col_num2 = size(tmatrix2, numel(tsize) + 2);

	assert(col_num1 == row_num2);
	
	
	for i = 1: numel(tsize)
		tmatrix1 = fft(tmatrix1, [], i);
		tmatrix2 = fft(tmatrix2, [], i);	
	end



	tmatrix1 = reshape(tmatrix1, prod(tsize), row_num1,  col_num1);
	tmatrix2 = reshape(tmatrix2, prod(tsize), row_num2,  col_num2);



	for i = 1: prod(tsize)
		slice_tmatrix1 = tmatrix1(i, :, :);
		slice_tmatrix2 = tmatrix2(i, :, :);

		slice_tmatrix1 = reshape(slice_tmatrix1, row_num1, col_num1);
		slice_tmatrix2 = reshape(slice_tmatrix2, row_num2, col_num2);

		result = slice_tmatrix1 * slice_tmatrix2;
				

		if i == 1
			tmatrix_result = zeros([prod(tsize), size(result) ] );
		end

		tmatrix_result(i, :, :) = result;
	
	end


	
	tmatrix_result = reshape(tmatrix_result, [tsize, size(tmatrix_result, 2), size(tmatrix_result, 3)]);


	for i = 1: numel(tsize)
		tmatrix_result = ifft(tmatrix_result, [], i);		
	end
	

end
