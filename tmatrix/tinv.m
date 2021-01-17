function tresult = tinv(tmatrix, tsize)
	% checked
	% checked
	% checked on 11-22-2018 by liaoliang

	% this function computes the inverse of a t-matrix
	
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	assert(row_num == col_num);
	

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	tmatrix = reshape(tmatrix, prod(tsize), row_num, col_num);
	tresult = zeros(size(tmatrix));

	for i = 1: prod(tsize)
		% slice = tmatrix(i, :, :);
		slice = reshape(tmatrix(i, :, :), row_num, col_num);

		
		if rank(slice) ~= row_num
			tresult = NaN;
			return;
		else 
			tresult(i, :, :) = inv(slice);
		end
	end

	tresult = reshape(tresult, [tsize, row_num, col_num]);

	for i = 1: numel(tsize)
		tresult = ifft(tresult, [], i);				
	end

end