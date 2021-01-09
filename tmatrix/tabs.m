function result = tabs(tmatrix, tsize)
	% checked
	% this function computes the (generalized) absolute value of each t-scalar entity of a t-matrix.  
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	% row_num = size(tmatrix, numel(tsize) + 1);
	% col_num = size(tmatrix, numel(tsize) + 2);

	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);		
	end

	tmatrix = abs(tmatrix); 

	for i = 1: numel(tsize)
		tmatrix = ifft(tmatrix, [], i);		
	end

	result = tmatrix;

end

%this function is correct but not efficient
%function result = tabs2(tmatrix, tsize)
%
%	row_num = size(tmatrix, numel(tsize) + 1);
%	col_num = size(tmatrix, numel(tsize) + 2);
%
%	for i = 1: numel(tsize)
%		tmatrix = fft(tmatrix, [], i);		
%	end
%
%		
%	tmatrix = reshape(tmatrix, prod(tsize), row_num, col_num);
%	
%	
%	for i = 1: prod(tsize)
%		slice = tmatrix(i, :, :);
%		tmatrix(i, :, :) = abs(slice);
%	
%	end
%	tmatrix = reshape(tmatrix, [tsize, row_num, col_num]);
%	
%	
%
%	for i = 1: numel(tsize)
%		tmatrix = ifft(tmatrix, [], i);		
%	end
%
%	result = tmatrix;
%
%end