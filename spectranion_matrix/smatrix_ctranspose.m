function smatrix_result = smatrix_ctranspose(smatrix, tsize, unit_quaternionic_square_roots)

	% this function returns the conjugate of a matrix of spectronion. 
	% note that a spectranion is quaternion array of the size specificized 
	% by the argument tsize

	assert(isequal(class(smatrix), 'quaternion'));
		
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(smatrix) - numel(tsize) == 2 |  ndims(smatrix) - numel(tsize) == 1 | ndims(smatrix) - numel(tsize) == 0);

	if nargin == 2
		unit_quaternionic_square_roots = quaternionize(i);		
	end

	assert(isequal(class(unit_quaternionic_square_roots), 'quaternion' ));
	assert(size(unit_quaternionic_square_roots, 1) == 1);

	assert(norm(compact(unit_quaternionic_square_roots .* unit_quaternionic_square_roots ...
		-  quaternionize((-1) * ones(size(unit_quaternionic_square_roots)))), 'fro') < 1e-8); 

	

	%-------------------------------------
	row_num = size(smatrix, numel(tsize) + 1);
	col_num = size(smatrix, numel(tsize) + 2);

	
	smatrix = reshape(smatrix, [tsize, row_num, col_num]);
	order = [1: numel(tsize), numel(tsize) + 2, numel(tsize) + 1];

	smatrix_result = zeros(size(smatrix));
	smatrix_result = permute(smatrix_result, order);
	smatrix_result = reshape(smatrix_result, prod(tsize), size(smatrix_result, numel(tsize) + 1), size(smatrix_result, numel(tsize) + 2) );
	smatrix_result = quaternionize(smatrix_result);


	% compute the multi-way quaternionic fourier transform 
	for mode_index = 1: numel(tsize)
		smatrix = ffts(smatrix, [], mode_index, unit_quaternionic_square_roots);		
	end
	
	smatrix = reshape(smatrix, prod(tsize), row_num, col_num);

	for slice_index = 1: prod(tsize)
		slice_smatrix = smatrix(slice_index, :, :);
		slice_smatrix = reshape(slice_smatrix, row_num, col_num);

		slice_smatrix = conj(permute(slice_smatrix, [2, 1]));
		smatrix_result(slice_index, :, :) = slice_smatrix;
	end

	smatrix_result = reshape(smatrix_result, [tsize, size(smatrix_result, 2), size(smatrix_result, 3)]);

	% compute the inverse multi-way quaternionic fourier transform 
	for mode_index = 1: numel(tsize)
		smatrix_result = iffts(smatrix_result, [], mode_index, unit_quaternionic_square_roots);		
	end


end