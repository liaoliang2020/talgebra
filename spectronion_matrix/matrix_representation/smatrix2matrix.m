function [qmatrix, complex_matrix, real_matrix, quaternion_slice_container, complex_slice_container, real_slice_container] = smatrix2matrix(smatrix, tsize)
	% this function get matrix representations of a spectronion matrix

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

	%--------------------------
	quaternion_slice_container = quaternion();
	complex_slice_container = [];
	real_slice_container = [];
	%--------------------------

	real_matrix = [];
	complex_matrix = [];
	qmatrix = quaternion();
	for slice_index = 1: prod(tsize)
		quaternion_slice = smatrix(slice_index, :, :);
		quaternion_slice = reshape(quaternion_slice, [row_num, col_num]);
		complex_slice = qmatrix2matrix(quaternion_slice);
		real_slice  = qmatrix2realmatrix(quaternion_slice);

		%-------------------
		quaternion_slice_container = [quaternion_slice_container, quaternion_slice(:)];
		complex_slice_container = [complex_slice_container, complex_slice(:)];
		real_slice_container = [real_slice_container, real_slice(:)];

		%-------
		qmatrix = my_blkdiag(qmatrix, quaternion_slice);
		%-------
		complex_matrix = blkdiag(complex_matrix, complex_slice);
		%-------
		real_matrix =  blkdiag(real_matrix, real_slice);

	end%for slice_index = 1: prod(tsize)

	quaternion_slice_container = reshape(quaternion_slice_container, [row_num, col_num, prod(tsize)]);
	complex_slice_container = reshape(complex_slice_container, [2 * row_num, 2 * col_num, prod(tsize) ]);
	real_slice_container = reshape(real_slice_container, [4 * row_num, 4 * col_num, prod(tsize) ]);

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