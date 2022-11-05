function smatrix_result = smatrix_multiplication(smatrix1, smatrix2, tsize)
	% this function computes the multiplication of two spectronion matrices

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

	% comput the multi-way quaternionic fourier transform 
	for index = 1: numel(tsize)
		N = tsize(index);
		my_qfourier_matrix = qfourier_matrix(N);

		smatrix1 = tensormultiplication(my_qfourier_matrix, smatrix1, index);
		smatrix2 = tensormultiplication(my_qfourier_matrix, smatrix2, index);
	end%for index = 1: numel(tsize)

	smatrix1 = reshape(smatrix1, [prod(tsize), row_num1, col_num1]);
	smatrix2 = reshape(smatrix2, [prod(tsize), row_num2, col_num2]);

	smatrix_result = quaternion();
	for index = 1: prod(tsize)
		slice1 = smatrix1(index, :, :);
		slice2 = smatrix2(index, :, :);

		slice1 = reshape(slice1, [row_num1, col_num1]);
		slice2 = reshape(slice2, [row_num2, col_num2]);

		result = qmatrix_multiplication(slice1, slice2);

		smatrix_result = [smatrix_result, result(:)];

	end%for index = 1: prod(tsize)

	smatrix_result = permute(smatrix_result, [2 1]);
	smatrix_result = reshape(smatrix_result, [tsize, row_num1, col_num2]);

	for index = 1: numel(tsize)
		N = tsize(index);
		my_qifourier_matrix = qifourier_matrix(N);
		smatrix_result = tensormultiplication(my_qifourier_matrix, smatrix_result, index);
		
	end%for index = 1: numel(tsize)





end
