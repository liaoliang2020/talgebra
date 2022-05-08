function tresult = tdiag(tmatrix, tsize)
	% checked
	% checked
	
	%this function extracts the diagnal elements of a tmatrix into a tvector
	
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);

	assert(isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1), size(tmatrix, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix), tsize) ...
	); 
	
	
	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	assert(row_num >= 1);
	assert(col_num >= 1);

	tresult = zeros([tsize, min(row_num, col_num)]);
	tresult = reshape(tresult, prod(tsize), []);

	tmatrix = reshape(tmatrix, prod(tsize),  row_num, col_num);


	for i = 1: min(row_num, col_num)
		tresult(:, i) = tmatrix(:, i, i);
	end

	tresult = reshape(tresult, [tsize, size(tresult, 2) ]);



end