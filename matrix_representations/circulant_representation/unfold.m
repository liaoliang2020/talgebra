function block_column = unfold(tmatrix, tsize)
	% assert(isequal(tsize', tsize(:)));	  
	
	assert(numel(tsize) == 1);

	assert(isequal(class(tmatrix), 'double'));	

	assert(ndims(tmatrix) - numel(tsize) == 2 | ndims(tmatrix) - numel(tsize) == 1| ndims(tmatrix) - numel(tsize) == 0);

	assert(isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1), size(tmatrix, numel(tsize) + 2)]) | ...  
		isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix), tsize) ...
	); 


	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2);

	tmatrix = reshape(tmatrix, [prod(tsize), row_num, col_num]  );
	tmatrix = permute(tmatrix, [2, 3, 1]);


	block_column = get_block_column(tmatrix);

end