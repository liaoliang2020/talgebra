function tresult = tprod(tmatrix, tsize)
	% This function calculates the production of the t-scalars in tmatrix 
	% 20190121

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	tmatrix = reshape(tmatrix, prod(tsize), row_num, col_num);


	slice_result_size = 0;
	for i = 1: prod(tsize)
		slice = reshape(tmatrix(i, :, :), row_num, col_num);

		slice_result = prod(slice);
	
		if i == 1			
			slice_result_size = size(slice_result);
			tresult = zeros([prod(tsize), prod(slice_result_size) ]);
		end

		tresult(i, :) = slice_result(:);

	end

	tresult = reshape(tresult, [tsize, slice_result_size]);

	for i = 1: numel(tsize)
		tresult = ifft(tresult, [], i);				
	end

end