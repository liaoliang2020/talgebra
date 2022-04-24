function smatrix_result = smatrix_multiplication_arg3(smatrix1, smatrix2, smatrix3, tsize)	

	assert(isequal(class(smatrix1), 'quaternion'))
	assert(isequal(class(smatrix2), 'quaternion'))
	assert(isequal(class(smatrix3), 'quaternion'))
	

	assert(isequal(tsize', tsize(:)));	 	
	assert(ndims(smatrix1) - numel(tsize) == 2 |  ndims(smatrix1) - numel(tsize) == 1 | ndims(smatrix1) - numel(tsize) == 0);
	assert(ndims(smatrix2) - numel(tsize) == 2 |  ndims(smatrix2) - numel(tsize) == 1 | ndims(smatrix2) - numel(tsize) == 0);
	assert(ndims(smatrix3) - numel(tsize) == 2 |  ndims(smatrix3) - numel(tsize) == 1 | ndims(smatrix3) - numel(tsize) == 0);

	

	%-----------
	row_num1 = size(smatrix1, numel(tsize) + 1);
	col_num1 = size(smatrix1, numel(tsize) + 2);

	row_num2 = size(smatrix2, numel(tsize) + 1);
	col_num2 = size(smatrix2, numel(tsize) + 2);

	row_num3 = size(smatrix3, numel(tsize) + 1);
	col_num3 = size(smatrix3, numel(tsize) + 2);

	assert(col_num1 == row_num2);
	assert(col_num2 == row_num3);

	
	smatrix_result = smatrix_multiplication(smatrix1, smatrix2, tsize);
	smatrix_result = smatrix_multiplication(smatrix_result, smatrix3, tsize);

	

	% smatrix_result is equal to the result "myresult" given by the following lines 

	%-----------------------
	% for i = 1: numel(tsize)
	% 	smatrix1 = ffts(smatrix1, [], i);
	% 	smatrix2 = ffts(smatrix2, [], i);
	% 	smatrix3 = ffts(smatrix3, [], i);		
	% end

	% smatrix1 = reshape(smatrix1, [prod(tsize), row_num1, col_num1]);
	% smatrix2 = reshape(smatrix2, [prod(tsize), row_num2, col_num2]);
	% smatrix3 = reshape(smatrix3, [prod(tsize), row_num3, col_num3]);

	
	% myresult = quaternionize([]);

	% for i = 1: prod(tsize)
	% 	slice1 = smatrix1(i, :, :);
	% 	slice1 = reshape(slice1, row_num1, col_num1); 

	% 	slice2 = smatrix2(i, :, :);
	% 	slice2 = reshape(slice2, row_num2, col_num2);

	% 	slice3 = smatrix3(i, :, :);
	% 	slice3 = reshape(slice3, row_num3, col_num3);

	% 	assert(isequal(class(slice1), 'quaternion'));
	% 	assert(isequal(class(slice2), 'quaternion'));
	% 	assert(isequal(class(slice3), 'quaternion'));

	% 	result_slice = qmatrix_multiplication_arg3(slice1, slice2, slice3);

	% 	assert(isequal(class(result_slice), 'quaternion'));

	% 	myresult = [myresult, result_slice(:)];
	
	% end%for i = 1: prod(tsize)

	% myresult = permute(myresult, [2 1]);
	% myresult = reshape(myresult, [tsize, row_num1, col_num3]);

	
	% for i = 1: numel(tsize)
	% 	myresult = iffts(myresult, [], i);
	% end

	

	

	
	
end