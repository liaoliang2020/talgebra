function smatrix_result = smatrix_ctranspose(smatrix, tsize)

	% this function returns the conjugate of a matrix of spectronion. 
	% note that a spectranion is quaternion array of the size specificized 
	% by the argument tsize


	assert(isequal(class(smatrix), 'quaternion'));
		
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(smatrix) - numel(tsize) == 2 |  ndims(smatrix) - numel(tsize) == 1 | ndims(smatrix) - numel(tsize) == 0);

	row_num = size(smatrix, numel(tsize) + 1);
	col_num = size(smatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);

	smatrix = reshape(smatrix, [tsize, row_num, col_num]);
	order = [1: numel(tsize), numel(tsize) + 2, numel(tsize) + 1];

	smatrix_result = zeros(size(smatrix));
	smatrix_result = permute(smatrix_result, order);
	smatrix_result = reshape(smatrix_result, prod(tsize), size(tmatrix_result, numel(tsize) + 1), size(tmatrix_result, numel(tsize) + 2) );


	for i = 1: numel(tsize)
		smatrix = ffts(smatrix, [], i);		
	end
	
	smatrix = reshape(smatrix, prod(tsize), row_num, col_num);

	for i = 1: prod(tsize)
		slice_smatrix = smatrix(i, :, :);
		slice_smatrix = reshape(slice_smatrix, row_num, col_num);

		slice_smatrix = conj(permute(slice_smatrix, [2, 1]));
		smatrix_result(i, :, :) = slice_smatrix;
	end

	smatrix_result = reshape(smatrix_result, [tsize, size(smatrix_result, 2), size(smatrix_result, 3)]);


	for i = 1: numel(tsize)
		smatrix_result = iffts(smatrix_result, [], i);		
	end


end