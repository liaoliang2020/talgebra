function result = tflipud(tmatrix, tsize)
	% This function generates the matlab function flipud
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	tmatrix = reshape(tmatrix, [prod(tsize), row_num, col_num]);
	result = tmatrix(:, row_num:-1:1, :);
	result = reshape(result, [tsize, row_num, col_num]); 	
end