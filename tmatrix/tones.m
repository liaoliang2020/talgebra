function tmatrix = tones(row_num, col_num, tsize)
	% checked
	% this function gives the generalized t-matrix with all t-scalar entities are equal to E_T

	assert(isequal(tsize', tsize(:)));	  
	assert(isequal(abs([row_num, col_num]), [row_num, col_num]) );

	tmatrix = zeros([tsize, row_num, col_num]);

	tmatrix = reshape(tmatrix, [prod(tsize), row_num, col_num]  );

	tmatrix(1, :, :) = ones(row_num, col_num);
	tmatrix = reshape(tmatrix, [tsize, row_num, col_num] );

end