function tmatrix_result = ftctranspose(tmatrix, tsize)
	% compute the conjugate transpose of a t-matrix 

	% checked
	% checked

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);


	tmatrix = reshape(tmatrix, [tsize, row_num, col_num]);


	
	order = [1: numel(tsize), numel(tsize) + 2, numel(tsize) + 1];

	tmatrix_result = zeros(size(tmatrix));
	tmatrix_result = permute(tmatrix_result, order);
	tmatrix_result = reshape(tmatrix_result, prod(tsize), size(tmatrix_result, numel(tsize) + 1), size(tmatrix_result, numel(tsize) + 2) );


	%for i = 1: numel(tsize)
	%	tmatrix = fft(tmatrix, [], i);		
	%end
	
	tmatrix = reshape(tmatrix, prod(tsize), row_num, col_num);



	for i = 1: prod(tsize)
	
		slice_tmatrix = tmatrix(i, :, :);
		slice_tmatrix = reshape(slice_tmatrix, row_num, col_num);


		slice_tmatrix = slice_tmatrix';

		tmatrix_result(i, :, :) = slice_tmatrix;
		
			
	end

	tmatrix_result = reshape(tmatrix_result, [tsize, size(tmatrix_result, 2), size(tmatrix_result, 3)]);


	%for i = 1: numel(tsize)
	%	tmatrix_result = ifft(tmatrix_result, [], i);		
	%end


end