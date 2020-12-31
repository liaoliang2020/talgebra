function tresult = tcolmean(tmatrix, tsize)
	% checked
	% checked

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);
	
	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);


	tmatrix = reshape(tmatrix, [], col_num);
	tresult = mean(tmatrix, 2);

	tresult = reshape(tresult, [tsize, row_num]);


end