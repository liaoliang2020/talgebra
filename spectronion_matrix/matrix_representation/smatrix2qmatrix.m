function main
	clear; close all; clc;

	tsize = [3 3];
	row_num = 7;
	col_num = 5;

	smatrix = randn([prod(tsize) * row_num * col_num, 4] );
	smatrix = quaternion(smatrix);
	smatrix = reshape(smatrix, [tsize, row_num, col_num]);

	[qmatrix, ~, ~] = smatrix2matrix_sub(smatrix, tsize);
	whos qmatrix;


end



function [qmatrix, complex_matrix, real_matrix] = smatrix2matrix_sub(smatrix, tsize)
	complex_matrix = 0;
	real_matrix = 0;

	assert(isequal(class(smatrix), 'quaternion'));
	assert(isequal(tsize', tsize(:)));	

	assert(ndims(smatrix) - numel(tsize) == 2 |  ndims(smatrix) - numel(tsize) == 1 | ndims(smatrix) - numel(tsize) == 0);  

	%-------------------------------------
	row_num = size(smatrix, numel(tsize) + 1);
	col_num = size(smatrix, numel(tsize) + 2);


	% compute the multi-way quaternionic Fourier transform
	for index = 1: numel(tsize)
		N = tsize(index);
		smatrix = tensormultiplication(qfourier_matrix(N), smatrix, index);
	end%for index = 1: numel(tsize)

	smatrix = reshape(smatrix, [prod(tsize), row_num, col_num] );

	qmatrix = quaternion();
	for slice_index = 1: prod(tsize)
		quaternion_slice = smatrix(slice_index, :, :);
		quaternion_slice = reshape(quaternion_slice, [row_num, col_num]);

		%-------
		qmatrix = my_blkdiag(qmatrix, quaternion_slice);


	end%for slice_index = 1: prod(tsize)

end


%-----
function result = my_blkdiag(qmatrix1, qmatrix2)
	assert(isequal(class(qmatrix1), 'quaternion'));
	assert(isequal(class(qmatrix2), 'quaternion'));

	if isempty(qmatrix1)
		result = qmatrix2;
		return;
	end

	assert(ndims(qmatrix1) == 2);
	assert(ndims(qmatrix2) == 2);
		
	liaoliang = size(qmatrix1) + size(qmatrix2);

	my_row_num = liaoliang(1);
	my_col_num = liaoliang(2);

	result = zeros(my_row_num * my_col_num, 4);
	result = quaternion(result);
	result = reshape(result, [my_row_num, my_col_num]);

	assert(isequal(class(result), 'quaternion'));

	[row_num001, col_num001] = size(qmatrix1);
	result(1: row_num001, 1: col_num001) = qmatrix1;

	result((row_num001 + 1): end, (col_num001 + 1): end) = qmatrix2;

end